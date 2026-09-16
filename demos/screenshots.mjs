// Screenshots of the web UI for the README. Run by demos/run.sh against an
// `aat web` serving the runs the tapes recorded:
//
//   node demos/screenshots.mjs <base-url> <out-dir> <label-run>:<step> ...
//
// Each extra argument is a page to shoot, as <run-id>/<step-id>=<file>.png.

import { chromium } from 'playwright';

const [baseURL, outDir, ...shots] = process.argv.slice(2);
if (!baseURL || !outDir || shots.length === 0) {
  console.error('usage: node demos/screenshots.mjs <base-url> <out-dir> <route>=<file> ...');
  process.exit(2);
}

async function getJSON(route) {
  const res = await fetch(new URL(route, baseURL));
  if (!res.ok) throw new Error(`GET ${route}: ${res.status}`);
  return res.json();
}

// A dark, high-density page whose clock is pinned, so relative times do not
// depend on how long the recording took.
async function newPage(browser, when, viewport) {
  const context = await browser.newContext({
    viewport,
    deviceScaleFactor: 2,
    colorScheme: 'dark',
    reducedMotion: 'reduce',
    locale: 'en-US',
    timezoneId: 'UTC',
  });
  await context.addInitScript(() => localStorage.setItem('aat:batchViewMode', 'tests'));
  const page = await context.newPage();
  if (when) await page.clock.setFixedTime(new Date(new Date(when).getTime() + 10_000));
  return page;
}

const browser = await chromium.launch();
try {
  for (const shot of shots) {
    const [spec, file] = shot.split('=');
    const [route, width, height, ...ready] = spec.split('|');
    const runId = route.split('/')[2];
    let when = null;
    try {
      const meta = route.startsWith('/batches/')
        ? await getJSON(`/api/batches/${runId}`)
        : await getJSON(`/api/runs/${runId}`);
      when = meta.timestamp;
    } catch { /* a page that needs no clock */ }

    const page = await newPage(browser, when, { width: Number(width), height: Number(height) });
    await page.goto(new URL(route, baseURL).href);
    for (const selector of ready) {
      // A "tab:Label" entry opens that tab instead of waiting for a selector.
      if (selector.startsWith('tab:')) {
        const tab = page.locator('.tab-button', { hasText: selector.slice(4) }).first();
        await tab.waitFor({ state: 'visible', timeout: 20_000 });
        await tab.click();
        continue;
      }
      await page.locator(selector).first().waitFor({ state: 'visible', timeout: 20_000 });
    }
    // A visualizer draws in an iframe after its postMessage handshake.
    await page.waitForTimeout(2500);
    await page.evaluate(() => document.fonts.ready);
    await page.screenshot({ path: `${outDir}/${file}` });
    console.log(`  ${file}`);
    await page.context().close();
  }
} finally {
  await browser.close();
}
