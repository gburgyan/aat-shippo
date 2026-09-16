### listTransactions

Page the labels the account has bought (GET /transactions, 200). `object_created_gte` narrows the list to labels created at or after an ISO 8601 UTC time, which is how the guard looks only at what this package could have bought; the spec declares that filter on this operation and on ListShipments alone. Each page counts the labels this package bought and any bought with a live token, which is the one unrecoverable mistake. Proven by plans/zz-guard/no-live-labels.yaml.

**Adapter:** `listTransactions`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| page | integer | no |  |  |  |
| pageSize | integer | yes | 100 |  | 1..100 |
| createdGte | string | no |  | Only labels created at or after this ISO 8601 UTC time |  |
| objectStatus | string | no |  | QUEUED, WAITING, SUCCESS, ERROR, or REFUNDED |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| transactions | transaction[] |  |
|   └ transactionId | string | elementField |
|   └ status | string | elementField |
| count | integer |  |
| ourCount | integer | Labels on the page whose metadata starts aat-shippo |
| ourLabels | ourLabel[] | The package's labels on the page, when there are any, so a guard can name them |
|   └ transactionId | string | elementField |
|   └ status | string | elementField |
| ourUnrefundedCount | integer | The package's labels still in SUCCESS — bought and not refunded. A label cannot be deleted, so this, not a count of what is left, is what a guard checks. |
| ourUnrefunded | ourLabel[] | Those labels, when there are any, so a failing guard can name them |
|   └ transactionId | string | elementField |
|   └ status | string | elementField |
| liveCount | integer | Labels on the page not in test mode; a live token bought a real label |
| nextPage | integer |  |

