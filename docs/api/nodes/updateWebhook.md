### updateWebhook

Replace a webhook's settings (PUT /webhooks/{webhookId}, 200). The body is a whole webhook, not a patch. **`object_updated` does not move** — the object answers with the timestamp it was created at, so an update leaves no trace in the object itself. Proven by plans/webhooks/lifecycle.yaml.

**Adapter:** `updateWebhook`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| webhookId | string | yes | from: createWebhook.webhookId |  |
| event | string | yes | track_updated |  |
| url | string | yes |  | The plans pass {{env.webhookUrl}} |
| active | boolean | yes | false |  |
| isTest | boolean | yes | true |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| webhookId | string |  |
| event | string |  |
| url | string |  |
| active | boolean |  |
| isTest | boolean |  |
| objectUpdated | string |  |

