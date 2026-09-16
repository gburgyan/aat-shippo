### getParcel

Read a parcel by its object id (GET /parcels/{id}, 200). A parcel is immutable, so this answers what the create did, with the dimensions a template supplied filled in. Proven by plans/parcels/create-and-read.yaml.

**Adapter:** `getParcel`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| parcelId | string | yes | from: createParcel.parcelId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| parcelId | string |  |
| length | string |  |
| width | string |  |
| height | string |  |
| distanceUnit | string |  |
| weight | string |  |
| massUnit | string |  |
| template | string |  |
| objectState | string |  |
| test | boolean |  |
| metadata | string |  |

