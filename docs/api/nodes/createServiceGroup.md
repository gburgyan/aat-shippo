### createServiceGroup

Create a shipping option to show at checkout (POST /service-groups, 201). A group bundles service levels from carrier accounts under one customer-facing name and price: `FLAT_RATE`, `LIVE_RATE` or `FREE_SHIPPING`. Its `service_levels` name an account and one of that account's service level tokens, which are visible **only** through the carrier account listing with `service_levels: true`, so this node is wired from there. `flat_rate` is normalised on the way in — "5.00" comes back "5". A ServiceGroup carries no `metadata` and no `test`, so this package tags it by name. Cleanup deletes it. Proven by plans/account/service-groups.yaml.

**Adapter:** `createServiceGroup`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| name | string | yes | aat-shippo flat rate | Shown to the customer, and the only tag this object can carry |
| description | string | yes | aat-shippo test service group |  |
| type | string | yes | FLAT_RATE | LIVE_RATE, FLAT_RATE, or FREE_SHIPPING |
| flatRate | string | yes | 5.00 | Required unless the type is FREE_SHIPPING — a rule the schema states in prose |
| flatRateCurrency | string | yes | USD |  |
| accountObjectId | string | yes | from: listCarrierAccounts.accounts |  |
| serviceLevelToken | string | yes | usps_first_class_mail_letter |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| serviceGroupId | string |  |
| name | string |  |
| type | string |  |
| flatRate | string | Normalised — "5.00" goes out and "5" comes back |
| flatRateCurrency | string |  |
| isActive | boolean |  |
| serviceLevelCount | integer |  |

