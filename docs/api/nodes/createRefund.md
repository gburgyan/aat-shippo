### createRefund

Refund a label (POST /refunds, 201), which is the only way to un-buy one: labels cannot be deleted. The refund is asynchronous, running QUEUED → PENDING → SUCCESS | ERROR, and in test mode it does **not** settle quickly: one stayed PENDING for at least 90 seconds, which matches a carrier taking days to accept a refund in the real world. What does happen at once is that the label's own status becomes REFUNDPENDING, so that, not the refund's status, is what a plan waits for. This is what every label's cleanup runs, and the shape of cleanup throughout the package — a refund, never a delete. Proven by plans/labels/buy-and-refund.yaml.

**Adapter:** `createRefund`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| transactionId | string | yes | from: createTransaction.transactionId |  |
| async | boolean | no |  |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| refundId | string |  |
| status | string | QUEUED, PENDING, SUCCESS, or ERROR |
| transactionId | string |  |
| test | boolean |  |

