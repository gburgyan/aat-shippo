### createUserParcelTemplate

Save a parcel shape to reuse (POST /user-parcel-templates, **201**, where the spec declares 200). The body is a `oneOf`: either a `template` token from a carrier's own parcel templates with a weight, or a full set of dimensions with a name. This node writes the dimension form. **This family's timestamps are not ISO 8601** — `object_created` comes back as `2026-09-16 13:23:18.665011 +0000 UTC`, Go's default time format, where the rest of this API sends ISO 8601. Reading it back gives the same thing; fetching the very same object through the default-parcel-template setting gives ISO 8601, so one object has two renderings. A UserParcelTemplate carries no `metadata` and no `test`, so this package tags it by name instead. Cleanup deletes it. Proven by plans/account/parcel-templates.yaml.

**Adapter:** `createUserParcelTemplate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| name | string | yes | aat-shippo template | The only tag this object can carry: it has no metadata field, so the guard and the plans recognise their own by an aat-shippo name prefix. |
| length | string | yes | 10 |  |
| width | string | yes | 8 |  |
| height | string | yes | 4 |  |
| distanceUnit | string | yes | in |  |
| weight | string | yes | 2 |  |
| weightUnit | string | yes | lb |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templateId | string |  |
| name | string |  |
| length | string |  |
| width | string |  |
| height | string |  |
| distanceUnit | string |  |
| weight | string |  |
| weightUnit | string |  |
| createdIsIso | boolean | Whether object_created parsed as ISO 8601. False on a create — the one endpoint in this API that answers a Go-formatted timestamp. |

