### createTransactionInstant

Buy a label without rating first (POST /transactions, 201) — Shippo calls it an Instalabel. In place of a rate it takes the shipment inline, a carrier account, and a service level token, so one call does what createShipment and createTransaction do together. The transaction answers a rate **object** rather than a rate id, which is how the two purchases differ in their replies. **Cleanup refunds the label.** Proven by plans/labels/instalabel.yaml.

**Adapter:** `createTransactionInstant`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| addressFrom | string | yes |  |  |
| addressTo | string | yes |  |  |
| parcels | string[] | yes |  |  |
| carrierAccountId | string | yes |  |  |
| serviceLevelToken | string | yes |  | A service level of that carrier account, such as usps_priority |
| labelFileType | string | no |  |  |
| async | boolean | no |  |  |
| metadata | string | yes | aat-shippo |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| transactionId | string |  |
| status | string |  |
| labelUrl | string |  |
| labelFormat | string |  |
| trackingNumber | string |  |
| trackingUrlProvider | string |  |
| rateProvider | string | The carrier, read from the rate object an Instalabel answers with |
| rateAmount | string |  |
| messageCount | integer |  |
| test | boolean |  |
| metadata | string |  |

**Error Detection:**

| Path | Rule | Details |
|------|------|---------|
| `test` | equals false |  |

