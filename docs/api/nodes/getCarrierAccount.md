### getCarrierAccount

Read one carrier account by its object id (GET /carrier_accounts/{id}, 200). Carries the carrier token and display name, whether it is active, and whether Shippo provides it — but **not its service levels**, which come back only from the listing with `service_levels: true`. Proven by plans/carriers/accounts.yaml.

**Adapter:** `getCarrierAccount`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrierAccountId | string | yes | from: listCarrierAccounts.accounts |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| carrierAccountId | string |  |
| carrier | string |  |
| accountId | string | Shippo's own identifier for the account, which with `carrier` forms its unique key. Neither can be changed, so an update has to send both back unaltered. |
| carrierName | string |  |
| active | boolean |  |
| isShippoAccount | boolean |  |
| test | boolean |  |
| serviceLevelCount | integer | Always 0 here; a single read carries no service levels |
| serviceLevels | string | Always "" here; the listing with serviceLevels set is the only source |

