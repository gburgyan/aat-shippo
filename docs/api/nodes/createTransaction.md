### createTransaction

Buy a label from a rate (POST /transactions, 201). This is the two-step purchase: rate the shipment, then buy one of its rates. A successful transaction carries an https `label_url` to the label itself, a carrier tracking number, and a tracking URL; `label_file_type` chooses the format, from PNG and ZPLII to PDF at several sizes. A rate older than seven days cannot be bought. **Cleanup refunds the label** — a label cannot be deleted, and a refund is the only way to un-buy one. Proven by plans/labels/buy-and-refund.yaml.

**Adapter:** `createTransaction`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| rateId | string | yes | from: listShipmentRates.rates |  |
| labelFileType | string | no |  | PNG, PNG_2.3x7.5, PDF, PDF_2.3x7.5, PDF_4x6, PDF_4x8, PDF_A4, PDF_A5, PDF_A6, or ZPLII. Shippo does not echo it back; the label URL's extension is what says which was delivered. |
| async | boolean | no |  | false buys before answering; Shippo's default is true |
| metadata | string | yes | aat-shippo |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| transactionId | string |  |
| status | string | WAITING, QUEUED, SUCCESS, ERROR, REFUNDED, REFUNDPENDING, or REFUNDREJECTED |
| labelUrl | string | An https URL to the label, which the label visualizer shows; "" until it succeeds |
| labelFormat | string | The label URL's extension, lowercased, which is the format actually delivered. Shippo does not echo label_file_type on the transaction, so this is read from the URL. |
| trackingNumber | string |  |
| trackingUrlProvider | string |  |
| qrCodeUrl | string | An https URL to a QR code; "" unless the carrier offers one |
| rateId | string | The rate bought; an Instalabel answers a rate object instead of an id |
| parcelId | string |  |
| eta | string |  |
| messageCount | integer |  |
| test | boolean |  |
| metadata | string |  |

**Error Detection:**

| Path | Rule | Details |
|------|------|---------|
| `test` | equals false |  |

