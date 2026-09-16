### createParcel

Create a parcel (POST /parcels, 201). The body is one of two shapes: explicit dimensions with `length`, `width`, `height`, and `distance_unit`, or a carrier's `template` token, which supplies them. Both need `weight` and `mass_unit`. Dimensions and weight are strings, not numbers. The parcel decides which carriers will rate a shipment at all, not just the price: a 15 g letter reaches Deutsche Post and a 30 cm box reaches Chronopost, where a 2 lb box reaches neither. Parcels cannot be deleted, so nothing cleans them up. Proven by plans/parcels/create-and-read.yaml and plans/parcels/from-template.yaml.

**Adapter:** `createParcel`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| weight | string | yes | 2 |  |
| massUnit | string | yes | lb | g, oz, lb, or kg |
| length | string | no | 10 |  |
| width | string | no | 8 |  |
| height | string | no | 4 |  |
| distanceUnit | string | no | in | cm, in, ft, mm, m, or yd |
| template | string | no |  | A carrier parcel template token, in place of the dimensions. A plan that sends one clears the dimension inputs with {} so the body writes a single shape. |
| metadata | string | yes | aat-shippo |  |

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
| template | string | The template token the parcel was built from; "" for explicit dimensions |
| objectState | string |  |
| test | boolean |  |
| metadata | string |  |

**Error Detection:**

| Path | Rule | Details |
|------|------|---------|
| `test` | equals false |  |

