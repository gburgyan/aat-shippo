### getWebhook

Read one webhook by its object id (GET /webhooks/{webhookId}, 200). After a delete the same read answers 404 with Shippo's flat `{"detail": "Not found."}`. Proven by plans/webhooks/lifecycle.yaml.

**Adapter:** `getWebhook`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| webhookId | string | yes | from: createWebhook.webhookId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| webhookId | string |  |
| event | string |  |
| url | string |  |
| active | boolean |  |
| isTest | boolean |  |
| objectUpdated | string |  |

