### listRefunds

List the account's refunds (GET /refunds/, 200) — note the trailing slash, which the spec declares and the API answers on. The response is a paginated list with `next` and `previous`, but **the spec declares no `page` or `results` parameters for this operation**, alone among the listings, so the node sends none and reads the first page. Refunds carry no metadata of their own, so they are matched to the package by the label they refund. Proven by plans/labels/buy-and-refund.yaml.

**Adapter:** `listRefunds`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| refunds | refund[] |  |
|   └ refundId | string | elementField |
|   └ status | string | elementField |
|   └ transactionId | string | elementField |
| count | integer |  |
| liveCount | integer |  |
| nextPage | integer |  |

