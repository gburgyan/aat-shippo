### listCarrierAccounts

Page the carrier accounts the token can rate with (GET /carrier_accounts, 200). A clean test account has 15, every one active, `test: true`, and `is_shippo_account: true`, so no carrier credentials are needed to rate or buy. Ten of them actually answer a rate request; see docs/carrier-lane-coverage.md for which, and why the other five do not. `service_levels: true` adds each account's service levels, which is the only way to see them. Proven by plans/carriers/accounts.yaml.

**Adapter:** `listCarrierAccounts`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| serviceLevels | boolean | no |  | Include each account's service levels |  |
| carrier | string | no |  | Only accounts for this carrier token, such as usps |  |
| page | integer | no |  |  |  |
| pageSize | integer | yes | 100 | Accounts per page, 1 to 100 | 1..100 |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| accounts | carrierAccount[] |  |
|   └ carrierAccountId | string | elementField |
|   └ carrier | string | elementField |
|   └ active | boolean | elementField |
| count | integer |  |
| activeCount | integer |  |
| shippoAccountCount | integer | Accounts Shippo provides itself, which need no carrier credentials |
| serviceLevelCount | integer | Service levels across the page; 0 unless serviceLevels was set |
| carriers | string | The page's carrier tokens, sorted and comma-joined |
| liveCount | integer | Accounts not in test mode on the page; 0 for a test token |
| nextPage | integer | The page number in the `next` URL; left out on the last page |

