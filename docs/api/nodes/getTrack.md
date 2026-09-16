### getTrack

Read a tracking status by carrier and tracking number (GET /tracks/{Carrier}/{TrackingNumber}, 200). Carrier `shippo` with one of six `SHIPPO_*` numbers returns a fixed, deterministic history that never flakes and costs nothing, which is what the tracking layers cross. The six are a **cumulative chain**, not six independent states: UNKNOWN(1) → TRANSIT(2) → FAILURE(3) → DELIVERED(4) → RETURNED(5), with PRE_TRANSIT its own single entry. `eta` and `original_eta` are relative to now and move on every call, so nothing asserts them. Proven by plans/tracking/fixtures.yaml.

**Adapter:** `getTrack`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrier | string | yes | shippo | The carrier token; `shippo` serves the test fixtures |
| trackingNumber | string | yes | SHIPPO_TRANSIT | SHIPPO_PRE_TRANSIT, SHIPPO_TRANSIT, SHIPPO_DELIVERED, SHIPPO_RETURNED, SHIPPO_FAILURE or SHIPPO_UNKNOWN for a fixture, or a real carrier number from a bought label |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| carrier | string |  |
| trackingNumber | string |  |
| status | string |  |
| statusDetails | string |  |
| historyCount | integer | Entries in tracking_history; a deterministic count for each fixture |
| historyStatuses | string | The history's statuses in order, comma-joined — the chain the fixture walked |
| lastHistoryStatus | string | The final history entry's status, which is what tracking_status reports now |
| hasLocation | boolean | Whether tracking_status.location came back. Null on PRE_TRANSIT and UNKNOWN, set on the rest; the spec declares it non-nullable either way. |
| serviceToken | string |  |
| transactionId | string | The owning transaction, visible only to its owner. Null on a fixture, though the spec declares it a string. |
| metadata | string |  |
| messageCount | integer |  |

