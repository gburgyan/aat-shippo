### getUserParcelTemplate

Read one saved parcel shape (GET /user-parcel-templates/{id}, 200). Renders its timestamps in the same non-ISO format the create does, and carries the carrier `template` it was built from — null for one built from dimensions, though the spec declares an object. Proven by plans/account/parcel-templates.yaml.

**Adapter:** `getUserParcelTemplate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| templateId | string | yes | from: createUserParcelTemplate.templateId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templateId | string |  |
| name | string |  |
| length | string |  |
| width | string |  |
| height | string |  |
| weight | string |  |
| isDefault | boolean | Shippo's own flag, which stays false even for the template that **is** the account's default — the default lives under /live-rates/settings, not here |
| createdIsIso | boolean |  |

