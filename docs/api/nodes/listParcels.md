### listParcels

Page the account's parcels (GET /parcels, 200), newest first. Pages like the other listings. Each page counts the parcels this package created and any not in test mode. Proven by plans/parcels/create-and-read.yaml.

**Adapter:** `listParcels`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| page | integer | no |  |  |  |
| pageSize | integer | yes | 25 |  | 1..100 |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| parcels | parcel[] |  |
|   └ parcelId | string | elementField |
|   └ massUnit | string | elementField |
| count | integer |  |
| ourCount | integer |  |
| liveCount | integer |  |
| nextPage | integer |  |

