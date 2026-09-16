### getCarrierParcelTemplate

Read one carrier parcel template by its token (GET /parcel-templates/{token}, 200), such as USPS_FlatRateEnvelope. Carries the carrier, the display name, the dimensions with their unit, and whether the dimensions vary. Proven by plans/carriers/parcel-templates.yaml.

**Adapter:** `getCarrierParcelTemplate`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| templateToken | string | yes | from: listCarrierParcelTemplates.templates |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| token | string |  |
| carrier | string |  |
| name | string |  |
| length | string |  |
| width | string |  |
| height | string |  |
| distanceUnit | string |  |
| isVariableDimensions | boolean |  |

