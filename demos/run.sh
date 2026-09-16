#!/usr/bin/env bash
# Regenerates the README's recordings and screenshots against the live Shippo
# test API: three terminal GIFs, one terminal still, and five web UI screenshots.
#
# Usage:
#   SHIPPO_API_TOKEN=shippo_test_... demos/run.sh
#
# Needs: aat on PATH, the pinned VHS (v0.11.0 — v0.12.0 writes no GIF), ffmpeg,
# node and npm with Playwright's Chromium, gifsicle, jq, and the JetBrains Mono
# font. It uses port 9130 for the web UI. The recorded runs buy labels in test
# mode and refund them.
#
# Every recording is checked against the archive it produced before anything is
# copied into docs/images: VHS exits 0 whether the run inside it passed or not,
# so "the GIF was written" is not evidence that the run was green.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
demos="$root/demos"
out="$demos/out"
images="$root/docs/images"
vhs_version="v0.11.0"
vhs="$demos/.bin/vhs"
web_port=9130

step() { printf '\n==> %s\n' "$*" >&2; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }

: "${SHIPPO_API_TOKEN:?export SHIPPO_API_TOKEN with a shippo_test_ token}"
command -v aat >/dev/null || die "aat is not on PATH"
command -v jq >/dev/null || die "jq is not on PATH"
command -v ffmpeg >/dev/null || die "ffmpeg is not on PATH"
command -v gifsicle >/dev/null || die "gifsicle is not on PATH"

# NO_COLOR would make aat treat stdout as a pipe: no colour, and no batch
# progress display. The rest would leak the caller's shell into the frame or
# point the run at another project.
unset NO_COLOR PS1 PROMPT AAT_PROJECT AAT_ENV_NAME AAT_HOST

mkdir -p "$out" "$images" "$demos/.bin"

step "Pinned VHS $vhs_version"
if [ ! -x "$vhs" ]; then
  GOBIN="$demos/.bin" go install "github.com/charmbracelet/vhs@$vhs_version"
fi

step "Playwright"
(cd "$demos" && npm install --silent && npx --yes playwright install chromium >/dev/null)

cd "$root"

# The newest archive of a kind, and a jq assertion over it. A recording that did
# not pass stops the script before it can reach docs/images.
newest() { basename "$(ls -dt "$root"/_output/runs/$1-* | head -1)"; }
check() {
  local file="$1" filter="$2" what="$3"
  [ -f "$file" ] || die "$what: no archive at $file"
  [ "$(jq -r "$filter" "$file")" = "true" ] || die "$what: $(jq -c "$filter" "$file") was not true in $file"
}

step "Recording: validate (a still, not a GIF)"
"$vhs" "$demos/validate.tape"
# The report is printed in one burst at the end, so the last frame is the whole of it.
ffmpeg -loglevel error -sseof -0.5 -i "$out/demo-validate.mp4" \
  -update 1 -frames:v 1 -y "$out/demo-validate.png"
[ -s "$out/demo-validate.png" ] || die "validate: no still was extracted"

step "Recording: label"
before_label=$(newest run)
"$vhs" "$demos/label.tape"
label_run=$(newest run)
[ "$label_run" != "$before_label" ] || die "label: the tape recorded no new run"
check "$root/_output/runs/$label_run/archive.json" \
  '.result.outcome == "passed" and (.steps | length) == 11' "label"

step "Recording: matrix"
# --parallel 4 inside the tape: the bars are the recording. The archive is the same eight runs
# either way, so the check below does not change.
"$vhs" "$demos/matrix.tape"
matrix_batch=$(newest batch)
check "$root/_output/runs/$matrix_batch/batch.json" \
  '.result.outcome == "passed" and .result.totalRuns == 8 and .result.passedRuns == 8' "matrix"

step "Recording: tracking"
"$vhs" "$demos/tracking.tape"
tracking_batch=$(newest batch)
check "$root/_output/runs/$tracking_batch/batch.json" \
  '.result.outcome == "passed" and .result.skippedRuns == 7 and .result.passedRuns == 7' "tracking"

step "Trimming, then into docs/images"
# A stale GIF from an older tape would otherwise be copied forward forever; validate writes an
# MP4 now, and its still is extracted from that.
rm -f "$out/demo-validate.gif"
for gif in "$out"/*.gif; do
  gifsicle -O3 --lossy=60 --colors 64 "$gif" -o "$gif.opt" && mv "$gif.opt" "$gif"
done

# Budgets in KB. A README that takes a minute to load is a README nobody scrolls.
budget() {
  local file="$1" limit="$2" size
  size=$(( $(wc -c <"$file") / 1024 ))
  [ "$size" -le "$limit" ] || die "$(basename "$file") is ${size}KB, over its ${limit}KB budget"
}
budget "$out/demo-label.gif"    1000
budget "$out/demo-matrix.gif"   3000
budget "$out/demo-tracking.gif" 1500
budget "$out/demo-validate.png"  500

for asset in "$out"/demo-*.gif "$out"/demo-validate.png; do
  cp "$asset" "$images/$(basename "$asset")"
  printf '  %-24s %s\n' "$(basename "$asset")" "$(du -h "$asset" | cut -f1)"
done

step "Runs for the screenshots"
aat run plan labels/formats --env test-ci --quiet >/dev/null
formats_run=$(newest run)
aat run plan rating/rate-shop --env test-ci --quiet >/dev/null
rates_run=$(newest run)
# register reads the delivered fixture, whose four-entry history is the one worth drawing.
aat run plan tracking/register --env test-ci --quiet >/dev/null
track_run=$(newest run)

step "Web UI on :$web_port"
aat web --port "$web_port" >"$out/web.log" 2>&1 &
web_pid=$!
trap 'kill "$web_pid" 2>/dev/null || true' EXIT
until curl -sf "http://localhost:$web_port/api/runs" >/dev/null; do sleep 0.3; done

step "Screenshots"
node "$demos/screenshots.mjs" "http://localhost:$web_port" "$images" \
  "/runs/$formats_run/steps/png|1180|1030|.step-detail-header|tab:Label=ui-label.png" \
  "/runs/$rates_run/steps/shipment|1180|870|.step-detail-header|tab:Rates=ui-refusals.png" \
  "/runs/$rates_run|1180|1190|.run-detail-header=ui-run.png" \
  "/runs/$track_run/steps/readBack|1180|760|.step-detail-header|tab:Tracking=ui-tracking.png" \
  "/batches/$matrix_batch|1440|560|table.test-matrix=ui-matrix.png"

step "Done"
printf 'Everything the README embeds is in %s\n' "$images"
