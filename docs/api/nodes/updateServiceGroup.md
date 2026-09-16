### updateServiceGroup

Change a service group (**PUT /service-groups**, 200) — with **no path parameter**: the group is named by `object_id` in the body, alone among this API's updates. `is_active` is required, and **sending it as false is rejected exactly as if it were missing** (`{"is_active": ["field is required"]}`, 400), so a service group cannot be deactivated through its own update endpoint. Proven by plans/account/service-groups.yaml.

**Adapter:** `updateServiceGroup`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| serviceGroupId | string | yes | from: createServiceGroup.serviceGroupId | Sent in the body as object_id, because the path carries no id |
| name | string | yes | aat-shippo flat rate renamed |  |
| description | string | yes | aat-shippo test service group |  |
| type | string | yes | FLAT_RATE |  |
| flatRate | string | yes | 6.50 |  |
| flatRateCurrency | string | yes | USD |  |
| isActive | boolean | yes | true | Required, and false is read as absent |
| accountObjectId | string | yes | from: listCarrierAccounts.accounts |  |
| serviceLevelToken | string | yes | usps_first_class_mail_letter |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| serviceGroupId | string |  |
| name | string |  |
| flatRate | string |  |
| isActive | boolean |  |

