### deleteUserParcelTemplate

Delete a saved parcel shape (DELETE /user-parcel-templates/{id}, **204** with no body). Paired to createUserParcelTemplate in the graph. Proven by plans/account/parcel-templates.yaml.

**Adapter:** `deleteUserParcelTemplate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| templateId | string | yes | from: createUserParcelTemplate.templateId |  |

