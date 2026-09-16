### deleteDefaultParcelTemplate

Clear the account's default parcel template (DELETE /live-rates/settings/parcel-template, **204**). It takes no id — there is only one setting — and it clears the setting without deleting the template it pointed at. Paired to updateDefaultParcelTemplate in the graph. Proven by plans/account/live-rates.yaml.

**Adapter:** `deleteDefaultParcelTemplate`

