### updateUserParcelTemplate

Change a saved parcel shape (PUT /user-parcel-templates/{id}, 200). The body is optional in the spec and a whole template in practice. Proven by plans/account/parcel-templates.yaml.

**Adapter:** `updateUserParcelTemplate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| templateId | string | yes | from: createUserParcelTemplate.templateId |  |
| name | string | yes | aat-shippo template resized |  |
| length | string | yes | 12 |  |
| width | string | yes | 9 |  |
| height | string | yes | 6 |  |
| distanceUnit | string | yes | in |  |
| weight | string | yes | 3 |  |
| weightUnit | string | yes | lb |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templateId | string |  |
| name | string |  |
| length | string |  |
| width | string |  |
| height | string |  |
| weight | string |  |

