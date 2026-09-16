### getShipment

Read a shipment by its object id (GET /shipments/{id}, 200), with whatever rating has produced so far. This is what a poll reads while `status` is QUEUED or WAITING; in test mode it is SUCCESS on the first read. Proven by plans/rating/rate-shop.yaml.

**Adapter:** `getShipment`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| shipmentId | string | yes | from: createShipment.shipmentId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| shipmentId | string |  |
| status | string |  |
| rateCount | integer |  |
| providers | string |  |
| messageCount | integer |  |
| test | boolean |  |
| metadata | string |  |

