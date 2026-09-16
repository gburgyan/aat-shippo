### createAddress

Create an address (POST /addresses, 201). Only `country` is required to create one, but a purchase needs name, street1, city, zip, and a phone and email for some carriers, and `is_complete` says whether it has them. With `validate: true` Shippo corrects the address as it creates it — "1 Market Stret, San Fransisco" came back "1 Market St, San Francisco" with the ZIP+4 — and **drops `metadata`**, so a validated address cannot carry the package's tag. Addresses cannot be deleted, so nothing cleans them up; they are tagged instead. Proven by plans/addresses/create-and-read.yaml and plans/addresses/validate.yaml.

**Adapter:** `createAddress`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| country | string | yes |  | An ISO 3166-1 alpha-2 code, such as US or DE |
| name | string | no |  |  |
| company | string | no |  | Required by CouriersPlease on a from address |
| street1 | string | no |  |  |
| street2 | string | no |  |  |
| city | string | no |  |  |
| state | string | no |  | Required for US, CA, and AU; most carriers take two or three characters |
| zip | string | no |  |  |
| phone | string | no |  |  |
| email | string | no |  |  |
| isResidential | boolean | no |  |  |
| validate | boolean | no |  | Correct the address while creating it; Shippo then drops metadata |
| metadata | string | yes | aat-shippo | Up to 100 characters; every object this package creates carries its name |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| addressId | string |  |
| name | string |  |
| company | string |  |
| street1 | string |  |
| city | string |  |
| state | string |  |
| zip | string |  |
| country | string |  |
| isComplete | boolean | Whether the address has everything a label purchase needs |
| test | boolean |  |
| metadata | string | "" for an address created with validate: true |
| validationIsValid | boolean | Present only when the address was created with validate; Shippo's verdict |
| validationMessageCount | integer | Validator messages returned with the address; 0 when it was not validated |

**Error Detection:**

| Path | Rule | Details |
|------|------|---------|
| `test` | equals false |  |

