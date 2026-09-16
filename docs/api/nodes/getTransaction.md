### getTransaction

Read a label by its object id (GET /transactions/{id}, 200). This is what a poll reads while a purchase is QUEUED or WAITING, and what shows a label's status after it has been refunded. Proven by plans/labels/buy-and-refund.yaml.

**Adapter:** `getTransaction`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| transactionId | string | yes | from: createTransaction.transactionId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| transactionId | string |  |
| status | string |  |
| labelUrl | string |  |
| trackingNumber | string |  |
| messageCount | integer |  |
| test | boolean |  |
| metadata | string |  |

