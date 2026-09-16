### getCarrierRegistrationStatus

Ask how far a carrier registration has got (GET /carrier_accounts/reg-status/, 200). **The trailing slash is required** — without it Shippo answers 301 to the same path with one, as GET /refunds/ does — and the spec declares the path without it. On an account whose carriers are all Shippo-provided there is nothing registering, so the answer is an empty object: the registration flow belongs to accounts you bring yourself. Proven by plans/account/carrier-writes.yaml.

**Adapter:** `getCarrierRegistrationStatus`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrier | string | yes | usps |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| status | string | "" on a Shippo-provided account, which has nothing to register |
| isEmpty | boolean | Whether the body came back as the empty object |

