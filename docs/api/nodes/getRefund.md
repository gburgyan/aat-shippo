### getRefund

Read a refund by its object id (GET /refunds/{id}, 200), which is what a poll reads while it is QUEUED or PENDING. Proven by plans/labels/buy-and-refund.yaml.

**Adapter:** `getRefund`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| refundId | string | yes | from: createRefund.refundId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| refundId | string |  |
| status | string |  |
| transactionId | string |  |
| test | boolean |  |

