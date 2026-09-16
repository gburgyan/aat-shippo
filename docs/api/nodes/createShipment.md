### createShipment

Create a shipment and rate it (POST /shipments, 201). It takes a from address, a to address, and a list of parcel ids, each as an object id. Shippo documents rating as asynchronous and gives the shipment a `status` of QUEUED, WAITING, SUCCESS, or ERROR for it, but in test mode every lane probed answered SUCCESS with its rates already attached. A carrier that cannot serve the shipment does not fail the request: it leaves a line in `messages` saying why, and the rate simply is not there — so a rate count is the evidence, never an error. Shipments cannot be deleted. Proven by plans/rating/rate-shop.yaml.

**Adapter:** `createShipment`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| addressFrom | string | yes | from: createAddress.addressId |  |
| addressTo | string | yes |  |  |
| parcels | string[] | yes |  | One or more parcel object ids |
| async | boolean | no |  | false rates before answering; Shippo's default is true |
| shipmentDate | string | no |  |  |
| carrierAccounts | string[] | no |  | Rate only these carrier accounts, by object id, instead of all of them |
| customsDeclaration | string | no |  | Required by some carriers on an international lane |
| metadata | string | yes | aat-shippo |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| shipmentId | string |  |
| status | string | QUEUED, WAITING, SUCCESS, or ERROR |
| rateCount | integer |  |
| providers | string | The carriers that answered, sorted and comma-joined |
| messageCount | integer | Lines explaining why a carrier did not answer |
| addressFrom | string |  |
| addressTo | string |  |
| parcelCount | integer |  |
| test | boolean |  |
| metadata | string |  |

**Error Detection:**

| Path | Rule | Details |
|------|------|---------|
| `test` | equals false |  |

