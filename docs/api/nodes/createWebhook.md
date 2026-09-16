### createWebhook

Register a webhook endpoint (POST /webhooks, 201). Shippo asks for nothing but a URL — there is no verification handshake, no challenge, and no ping — so the whole lifecycle is drivable without a receiver, which is how this package tests it. **No secret is issued**: the Webhook object carries no signing key, so there is nothing here to redact. `event: all` is stored and **read back as `*`**, a value the spec's own enum does not list. Cleanup deletes it. Proven by plans/webhooks/lifecycle.yaml.

**Adapter:** `createWebhook`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| event | string | yes | track_updated | transaction_created, transaction_updated, track_updated, batch_created, batch_purchased, or all — which comes back as `*` |
| url | string | yes |  | Any https URL; Shippo never calls it during a test run. The plans pass {{env.webhookUrl}}, whose path carries aat-shippo — the only tag a webhook can have. |
| active | boolean | yes | true |  |
| isTest | boolean | yes | true |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| webhookId | string |  |
| event | string |  |
| url | string |  |
| active | boolean |  |
| isTest | boolean |  |
| objectUpdated | string | Set on create, and **not bumped by an update** — see plans/webhooks/lifecycle.yaml |

