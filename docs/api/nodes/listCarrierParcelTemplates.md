### listCarrierParcelTemplates

Every parcel template the carriers publish (GET /parcel-templates, 200). A test account sees 74, from USPS, UPS, FedEx, DHL eCommerce, DPD UK, and Aramex Australia. The answer is a bare `{results}` with no `next` or `previous`, so it does not page. A template's token is what createParcel takes in place of dimensions. Proven by plans/carriers/parcel-templates.yaml.

**Adapter:** `listCarrierParcelTemplates`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| carrier | string | no |  | Only templates for this carrier token |
| include | string | no |  | Narrow the list; "all" returns every template |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| templates | parcelTemplate[] |  |
|   └ token | string | elementField |
|   └ carrier | string | elementField |
|   └ name | string | elementField |
| count | integer |  |
| carriers | string | The carriers that publish them, sorted and comma-joined |
| fixedCount | integer | Templates whose dimensions are fixed rather than variable |

