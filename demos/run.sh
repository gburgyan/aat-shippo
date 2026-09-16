#!/usr/bin/env bash
# Regenerates the README's recordings and screenshots against the live Shippo
# test API: three terminal GIFs and four web UI screenshots.
#
# Usage:
#   source ~/dev/aat/setup-shippo.sh && SHIPPO_API_TOKEN=$SHIPPO_TOKEN demos/run.sh
#
# Needs: aat on PATH, the pinned VHS (v0.11.0 — v0.12.0 writes no GIF), node and
# npm with Playwright's Chromium, gifsicle, and the JetBrains Mono font. It uses
# port 9130 for the web UI. The recorded runs buy labels in test mode and refund
# them; nothing under docs/images changes unless every recording passed.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
demos="$root/demos"
out="$demos/out"
images="$root/docs/images"
vhs_version="v0.11.0"
vhs="$demos/.bin/vhs"
web_port=9130

step() { printf '\n==> %s\n' "$*" >&2; }

: "${SHIPPO_API_TOKEN:?export SHIPPO_API_TOKEN with a shippo_test_ token}"
command -v aat >/dev/null || { echo "aat is not on PATH" >&2; exit 1; }

mkdir -p "$out" "$images" "$demos/.bin"

step "Pinned VHS $vhs_version"
if [ ! -x "$vhs" ]; then
  GOBIN="$demos/.bin" go install "github.com/charmbracelet/vhs@$vhs_version"
fi

step "Playwright"
(cd "$demos" && npm install --silent && npx --yes playwright install chromium >/dev/null)

step "Recording the terminal"
cd "$root"
for tape in validate label matrix; do
  "$vhs" "$demos/$tape.tape"
done

step "Trimming the GIFs, then into docs/images"
for gif in "$out"/*.gif; do
  gifsicle -O3 --lossy=60 --colors 128 "$gif" -o "$gif.opt" && mv "$gif.opt" "$gif"
  cp "$gif" "$images/$(basename "$gif")"
  printf '  %s  %s\n' "$(basename "$gif")" "$(du -h "$gif" | cut -f1)"
done

step "Runs for the screenshots"
aat run plan labels/formats --env test-ci --quiet >/dev/null
label_run=$(basename "$(ls -dt "$root"/_output/runs/run-* | head -1)")
aat run plan rating/rate-shop --env test-ci --quiet >/dev/null
rates_run=$(basename "$(ls -dt "$root"/_output/runs/run-* | head -1)")
aat run batch matrix --env test-ci --quiet \
  --layer-group parcel-letter,parcel-large,parcel-heavy >/dev/null
batch_run=$(basename "$(ls -dt "$root"/_output/runs/batch-* | head -1)")

step "Web UI on :$web_port"
aat web --port "$web_port" >"$out/web.log" 2>&1 &
web_pid=$!
trap 'kill "$web_pid" 2>/dev/null || true' EXIT
until curl -sf "http://localhost:$web_port/api/runs" >/dev/null; do sleep 0.3; done

step "Screenshots"
node "$demos/screenshots.mjs" "http://localhost:$web_port" "$images" \
  "/runs/$label_run/steps/png|1180|1030|.step-detail-header|tab:Label=ui-label.png" \
  "/runs/$rates_run/steps/shipment|1180|870|.step-detail-header|tab:Rates=ui-refusals.png" \
  "/runs/$rates_run|1180|1190|.run-detail-header=ui-run.png" \
  "/batches/$batch_run|1440|560|table.test-matrix=ui-matrix.png"

step "Done"
printf 'Everything the README embeds is in %s\n' "$images"
