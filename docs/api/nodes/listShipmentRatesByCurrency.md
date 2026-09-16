### listShipmentRatesByCurrency

The same rates converted (GET /shipments/{id}/rates/{currency}, 200). Each rate keeps `amount` and `currency` as quoted and adds `amount_local` and `currency_local` in the currency asked for, so a US shipment's 63.94 USD reads 55.40 EUR beside it. Proven by plans/rating/currencies.yaml.

**Adapter:** `listShipmentRatesByCurrency`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| shipmentId | string | yes | from: createShipment.shipmentId |  |  |
| currencyCode | string | yes | EUR | An ISO 4217 code |  |
| pageSize | integer | yes | 100 |  | 1..100 |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| count | integer |  |
| currency | string | The currency the rates were quoted in |
| currencyLocal | string | The currency asked for |
| convertedCount | integer | Rates that came back with an amount in the local currency |

