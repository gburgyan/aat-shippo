### listServiceGroups

List the account's service groups (GET /service-groups, 200). The response is a **bare JSON array**, with no envelope, no count and no paging — the only listing in this API shaped that way. Counts this package's own by their aat-shippo name prefix. Proven by plans/account/service-groups.yaml.

**Adapter:** `listServiceGroups`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| groups | serviceGroup[] |  |
|   └ serviceGroupId | string | elementField |
|   └ name | string | elementField |
| count | integer |  |
| ourCount | integer | Groups whose name starts aat-shippo |

