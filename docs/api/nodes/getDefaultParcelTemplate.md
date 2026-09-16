### getDefaultParcelTemplate

Read the account's default parcel template (GET /live-rates/settings/parcel-template, 200). **When none is set, `result` is null**, where the spec declares a UserParcelTemplate object. Proven by plans/account/live-rates.yaml.

**Adapter:** `getDefaultParcelTemplate`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templateId | string | Empty when no default is set, which is how the account starts and ends |
| name | string |  |
| isSet | boolean |  |

