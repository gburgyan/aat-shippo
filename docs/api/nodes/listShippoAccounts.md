### listShippoAccounts

List the Shippo managed accounts under this one (GET /shippo-accounts, 200). **Creating one is gated**: POST answers 403 with the bare JSON string "Unauthorized to create accounts" — a third error envelope again — on a standard test token, and the API offers no DELETE at all, so this package reads and never writes. Its pagination is its own too: `next` and `previous` come back as **empty strings** where every other listing sends null, and the `count` the spec declares is absent. Proven by plans/account/platform-accounts.yaml.

**Adapter:** `listShippoAccounts`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| accounts | shippoAccount[] |  |
|   └ accountId | string | elementField |
|   └ email | string | elementField |
| count | integer | Derived by counting results; the response omits the count the spec declares |
| ourCount | integer | Accounts this package created, which is always 0 — creating them is gated |

