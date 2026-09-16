### getRate

Read one rate by its object id (GET /rates/{id}, 200), with everything the listing shows and more: the service level's token and terms, the delivery estimate, the carrier's zone, the insurance included, and `provider_image_75` and `provider_image_200`, which are https URLs to the carrier's logo. `servicelevel.display_name` and `parent_servicelevel` come back null where the spec types them strings. Proven by plans/rating/rate-shop.yaml.

**Adapter:** `getRate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| rateId | string | yes | from: listShipmentRates.rates |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| rateId | string |  |
| provider | string |  |
| serviceLevelName | string |  |
| serviceLevelToken | string |  |
| amount | string |  |
| currency | string |  |
| estimatedDays | integer |  |
| attributes | string | CHEAPEST, FASTEST, BESTVALUE, sorted and comma-joined; "" when none |
| zone | string | The carrier's zone for the lane; "" when it gives none |
| shipmentId | string |  |
| carrierAccountId | string |  |
| providerImage | string | An https URL to the carrier's logo, which the rates visualizer shows |
| test | boolean |  |

