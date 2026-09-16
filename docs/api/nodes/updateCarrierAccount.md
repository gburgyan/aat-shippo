### updateCarrierAccount

Change a carrier account's settings (PUT /carrier_accounts/{id}, 200). `carrier` and `account_id` together identify the account and cannot be changed, so on a Shippo-provided test account the one thing worth writing is `active`. This package toggles it on **couriersplease**, which docs/carrier-lane-coverage.md records as answering no lane at all — so turning it off cannot change what any other plan is quoted. Cleanup turns it back on. Proven by plans/account/carrier-writes.yaml.

**Adapter:** `updateCarrierAccount`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrierAccountId | string | yes | from: listCarrierAccounts.accounts |  |
| carrier | string | yes | couriersplease |  |
| accountId | string | yes |  | Shippo's own id for the account, which is echoed back rather than changed |
| active | boolean | yes | false |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| carrierAccountId | string |  |
| carrier | string |  |
| active | boolean |  |
| test | boolean |  |

