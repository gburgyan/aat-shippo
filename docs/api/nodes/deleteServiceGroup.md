### deleteServiceGroup

Delete a service group (DELETE /service-groups/{id}, **204** with no body). The delete does take a path id, where the update does not. Paired to createServiceGroup in the graph. Proven by plans/account/service-groups.yaml.

**Adapter:** `deleteServiceGroup`

**Inputs:**

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| serviceGroupId | string | yes | from: createServiceGroup.serviceGroupId |  |

