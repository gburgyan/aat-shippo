### listShipments

Page the account's shipments (GET /shipments, 200). One of only two operations whose spec declares `object_created_gte`, the other being ListTransactions. Proven by plans/rating/rate-shop.yaml.

**Adapter:** `listShipments`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| page | integer | no |  |  |  |
| pageSize | integer | yes | 25 |  | 1..100 |
| createdGte | string | no |  | Only shipments created at or after this ISO 8601 UTC time |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| shipments | shipment[] |  |
|   └ shipmentId | string | elementField |
|   └ status | string | elementField |
| count | integer |  |
| ourCount | integer |  |
| liveCount | integer |  |
| nextPage | integer |  |

