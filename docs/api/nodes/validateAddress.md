### validateAddress

Validate an address that already exists (GET /addresses/{id}/validate, 200). Shippo answers a **new** address object with its own object id, the corrected fields, and `validation_results.messages`, each with a source, a code, and text. A valid address can still carry a message: a correct street with no apartment number comes back `is_valid: true` with "Default Match — More information, such as an apartment or suite number, may give a more specific address." Proven by plans/addresses/validate.yaml.

**Adapter:** `validateAddress`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| addressId | string | yes | from: createAddress.addressId |  |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| addressId | string | A new object id, not the one that was validated |
| isValid | boolean |  |
| messageCount | integer |  |
| messageCodes | string | The validator message codes, sorted and comma-joined |
| messageText | string | The first message's text; "" when there are none |
| street1 | string |  |
| city | string |  |
| zip | string |  |
| isComplete | boolean |  |
| test | boolean |  |

