### deleteWebhook

Delete a webhook (DELETE /webhooks/{webhookId}, **204** with no body). Webhooks are the one thing this package creates that Shippo lets it destroy, so this is real cleanup rather than the refund every label needs. Paired to createWebhook in the graph. Proven by plans/webhooks/lifecycle.yaml.

**Adapter:** `deleteWebhook`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| webhookId | string | yes | from: createWebhook.webhookId |  |

