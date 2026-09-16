### listShipmentRates

The rates a shipment was quoted (GET /shipments/{id}/rates, 200), each with a carrier, a service level, a price, and an estimate in days. Shippo marks the standouts in `attributes`: CHEAPEST, FASTEST, and BESTVALUE, which is not always present — on a lane where one rate is both cheapest and fastest, only those two appear. Proven by plans/rating/rate-shop.yaml.

**Adapter:** `listShipmentRates`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| shipmentId | string | yes | from: createShipment.shipmentId |  |  |
| page | integer | no |  |  |  |
| pageSize | integer | yes | 100 |  | 1..100 |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| rates | rate[] |  |
|   └ rateId | string | elementField |
|   └ provider | string | elementField |
|   └ amount | string | elementField |
| count | integer |  |
| providers | string | The carriers that answered, sorted and comma-joined |
| currency | string | The currency the rates are quoted in; "" when there are none |
| cheapestRateId | string | The rate marked CHEAPEST; "" when none is |
| cheapestProvider | string |  |
| cheapestAmount | string |  |
| fastestProvider | string | The carrier of the rate marked FASTEST; "" when none is |
| attributeCount | integer | Rates carrying at least one attribute |

