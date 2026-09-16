### createTrack

Register a tracking number so Shippo watches it and fires `track_updated` webhooks (POST /tracks, **200**, not the 201 a create usually answers). The response is a full Track, the same shape GetTrack returns, so registering and reading tell you the same thing — the difference is that registering subscribes. Registering a number already registered answers 200 again rather than a conflict. Proven by plans/tracking/register.yaml.

**Adapter:** `createTrack`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrier | string | yes | shippo | The carrier token; `shippo` serves the deterministic test fixtures |
| trackingNumber | string | yes | SHIPPO_TRANSIT |  |
| metadata | string | no |  | Up to 100 characters. A fixture ignores it and answers Shippo's own "Shippo test tracking", so a tracked fixture cannot carry this package's tag. |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| carrier | string |  |
| trackingNumber | string |  |
| status | string | UNKNOWN, PRE_TRANSIT, TRANSIT, DELIVERED, RETURNED, or FAILURE |
| statusDetails | string |  |
| historyCount | integer |  |
| metadata | string |  |

