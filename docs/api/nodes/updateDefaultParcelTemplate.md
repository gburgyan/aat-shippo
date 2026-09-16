### updateDefaultParcelTemplate

Set the parcel a live-rate request uses when it names none (PUT /live-rates/settings/parcel-template, 200). The body is just an `object_id`, and the response wraps the whole template in a single-key `{result}` envelope — a shape nothing else in this API uses. Note the template's own `is_default` stays false: this setting is the only thing that knows. Cleanup clears it. Proven by plans/account/live-rates.yaml.

**Adapter:** `updateDefaultParcelTemplate`

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

