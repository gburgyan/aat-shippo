### listUserParcelTemplates

List the account's saved parcel shapes (GET /user-parcel-templates, 200). The response is a bare `{results}` with **no `count`, `next` or `previous`** — alone among this API's listings — and takes no paging parameters. **When the account has none, `results` is `null` rather than an empty array**, which the spec's array type disallows. Counts this package's own by their aat-shippo name prefix, since the object has no metadata. Proven by plans/account/parcel-templates.yaml.

**Adapter:** `listUserParcelTemplates`

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templates | userParcelTemplate[] |  |
|   └ templateId | string | elementField |
|   └ name | string | elementField |
| count | integer | Derived by counting results, which the response does not report itself |
| ourCount | integer | Templates whose name starts aat-shippo |

