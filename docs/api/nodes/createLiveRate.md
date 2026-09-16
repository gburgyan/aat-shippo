### createLiveRate

Ask what to show a customer at checkout (POST /live-rates, 200). This is not a rate shop: **the options it returns are service groups, not carrier services** — each `title` is a group's name and each `amount` its configured price — so it answers nothing at all until a service group exists. Omitting `parcel` uses the account's default parcel template, which is what makes that setting worth having. `address_from` is **required in practice** although the spec marks it optional; without one the request is refused with an error in a third shape, `{"message", "details"}`, rather than Shippo's usual flat `{"detail"}`. Proven by plans/account/live-rates.yaml.

**Adapter:** `createLiveRate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| addressFromStreet1 | string | yes | 215 Clayton St |  |
| addressFromCity | string | yes | San Francisco |  |
| addressFromState | string | yes | CA |  |
| addressFromZip | string | yes | 94117 |  |
| addressFromCountry | string | yes | US |  |
| addressToStreet1 | string | yes | 233 E Wacker Dr |  |
| addressToCity | string | yes | Chicago |  |
| addressToState | string | yes | IL |  |
| addressToZip | string | yes | 60601 |  |
| addressToCountry | string | yes | US |  |
| itemTitle | string | yes | aat-shippo widget |  |
| itemQuantity | integer | yes | 1 |  |
| itemPrice | string | yes | 20.00 |  |
| itemCurrency | string | yes | USD |  |
| itemWeight | string | yes | 1 |  |
| itemWeightUnit | string | yes | lb |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| count | integer |  |
| titles | string | Each option's title, comma-joined — these are service group names |
| firstAmount | string |  |
| firstCurrency | string |  |

