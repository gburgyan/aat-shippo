### getAddress

Read an address by its object id (GET /addresses/{id}, 200). An address is immutable once created, so this answers exactly what the create did. Proven by plans/addresses/create-and-read.yaml.

**Adapter:** `getAddress`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| addressId | string | yes | from: createAddress.addressId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| addressId | string |  |
| name | string |  |
| street1 | string |  |
| city | string |  |
| state | string |  |
| zip | string |  |
| country | string |  |
| isComplete | boolean |  |
| test | boolean |  |
| metadata | string |  |

