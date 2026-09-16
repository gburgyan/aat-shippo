### listAddresses

Page the account's addresses (GET /addresses, 200), newest first. `next` is a full URL carrying the next page number and `previous` is null on the first page, though the spec types both as strings. Each page counts the addresses this package created, by their metadata tag, and any not in test mode. Proven by plans/addresses/create-and-read.yaml.

**Adapter:** `listAddresses`

**Inputs:**

| Name | Type | Required | Default | Description | Constraints |
|------|------|----------|---------|-------------|------------|
| page | integer | no |  |  |  |
| pageSize | integer | yes | 25 | Addresses per page, 1 to 100 | 1..100 |

**Outputs:**

| Name | Type | Description |
|------|------|-------------|
| addresses | address[] |  |
|   └ addressId | string | elementField |
|   └ country | string | elementField |
| count | integer |  |
| ourCount | integer | Addresses on the page whose metadata starts aat-shippo |
| liveCount | integer | Addresses not in test mode on the page; 0 for a test token |
| nextPage | integer | The page number in the `next` URL; left out on the last page |

