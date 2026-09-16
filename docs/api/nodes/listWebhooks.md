### listWebhooks

List the account's webhooks (GET /webhooks, 200). The spec declares **no `page` or `results` parameters** for this listing, alone with GET /refunds/, so this node sends none and asserts the response carries no `next` — a guard that cannot page must prove it did not need to. (The API does honour both parameters if you send them; the spec is what is wrong, and sending an undeclared parameter would be the caller's fault rather than the spec's.) A Webhook carries no `metadata`, so a webhook is recognised as this package's by `aat-shippo` in its URL. Proven by plans/webhooks/lifecycle.yaml and plans/zz-guard/no-stray-webhooks.yaml.

**Adapter:** `listWebhooks`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| webhooks | webhook[] |  |
|   └ webhookId | string | elementField |
|   └ event | string | elementField |
|   └ url | string | elementField |
| count | integer |  |
| ourCount | integer | Webhooks whose URL carries aat-shippo |
| liveCount | integer | Webhooks not marked is_test; 0 for anything this package registers |

