# Which carriers answer on which lanes

Measured live against the Shippo test API on 2026-09-15, with `aat v0.1.0-98-gd50522a`. Every number
here came from a run: one shipment per lane, rates read with `async: false`, and the carriers left to
Shippo's own choice unless a row says otherwise. The probes are not committed — `probes/` is ignored —
but the runs are reproducible from the plans this package ships.

This is the table the layer set is built on. A lane with no carrier is not a layer; a carrier that
never answers is not a layer member.

## The account

The test token has **15 active carrier accounts**, every one `is_shippo_account: true` and
`test: true`: `usps`, `ups` (two), `fedex`, `dhl_express`, `canada_post`, `chronopost`, `colissimo`,
`correos`, `couriersplease`, `deutsche_post`, `dpd_de`, `dpd_uk`, `hermes_uk`, `lso`.

**Ten of them can be rated.** The other five are listed and active but answer nothing — see
[Carriers that never answer](#carriers-that-never-answer).

## The grid

A 10 × 8 × 4 in, 2 lb parcel, unless the row says otherwise.

| Lane | Rates | Carriers, with the price range |
|---|---:|---|
| `us-domestic` (SF → NY) | 10 | UPS 7 [14.97–88.03 USD], USPS 3 [10.05–63.94 USD] |
| `ca-domestic` (Toronto → Vancouver) | 5 | UPS 5 [18.26–58.84 CAD] |
| `uk-domestic` (London → Manchester) | 3 | Hermes UK 2 [2.71–3.42 GBP], DPD UK 1 [5.85 GBP] |
| `de-domestic` (Berlin → Munich) | 1 | DPD DE 1 [4.85 EUR] |
| `fr-domestic` (Paris → Lyon) | 2 | Colissimo 2 [8.84–10.70 EUR] |
| `es-domestic` (Madrid → Barcelona) | 2 | Correos 2 [4.97–5.86 EUR] |
| `us-canada` (SF → Toronto) | 4 | USPS 3 [27.65–68.92 USD], DHL Express 1 [34.67 USD] |
| `us-uk` (SF → London) | 4 | USPS 3 [33.98–93.11 USD], DHL Express 1 [45.65 USD] |
| `us-germany` (SF → Berlin) | 4 | USPS 3 [31.27–102.22 USD], DHL Express 1 [45.65 USD] |
| `au-domestic` (Sydney → Melbourne) | **0** | — nothing answers; see below |

## The parcel changes which carriers answer

This is the finding that decides the layer design. The parcel is not a cosmetic axis: on two
independent lanes it changes the carrier set, not just the price.

| Lane | Parcel | Rates | Carriers |
|---|---|---:|---|
| `de-domestic` | 10 × 8 × 4 in, 2 lb | 1 | DPD DE |
| `de-domestic` | 22 × 11 × 1 cm, 15 g | **2** | DPD DE, **Deutsche Post** [Kompaktbrief 1.10 EUR] |
| `fr-domestic` | 10 × 8 × 4 in, 2 lb | 2 | Colissimo |
| `fr-domestic` | 30 × 22 × 15 cm, 2 kg | **6** | Colissimo, **Chronopost** 4 [10.57–21.99 EUR] |

Both carriers said exactly why they were absent, in the shipment's `messages`:

- Deutsche Post, on the 2 lb parcel: `The weight of your package (907.184739 g) exceeds the maximum
  allowed of 50 g for deutsche_post_kompaktbrief.` — one message per product it rules out.
- Chronopost, on the 10 in parcel: `Dimension 20.3200 cm, is less than required 21 cm Chrono 10,
  Chrono 13, Chrono 18, …` — its products have a *minimum* size.

So the parcel layer needs at least three members to reach every carrier: a letter-sized one under
50 g, a mid-sized box, and one at least 21 cm on its longest side.

## Where the refusals are recorded

A carrier that cannot serve a shipment does not fail the request. `POST /shipments` answers `201`
with fewer rates and a `messages` array saying why, one entry per carrier account. Rate shopping is
therefore never an error to assert against — the count of rates and the messages are the evidence.
The kinds seen, all verbatim:

| Message | Means |
|---|---|
| `Carrier account <name> doesn't support one or more shipment options` | the carrier does not serve this lane at all |
| `Shipment origin is out of service area for UPS Master account from US` | the Shippo master account is bound to one origin country |
| `Shippo's DHL Express master account doesn't support shipments from outside of the US` | same, for DHL Express |
| `Your account is restricted from using this carrier.` | FedEx on this account, on every lane |
| `Shipment origin or destination state is out of the service area for LSO.` | LSO is a Texas regional carrier |
| `There is a mismatch between the endpoints and the authorization.` | Canada Post's test credentials |
| `Please include company name in the field 'Company' of the From Address.` | CouriersPlease wants a company |
| `The weight of your package … exceeds the maximum allowed of 50 g for …` | the parcel is too heavy for that product |
| `Dimension 20.3200 cm, is less than required 21 cm …` | the parcel is too small for that product |
| `Attribute "customs_declaration" must not be empty.` | an international lane, rated without customs |
| `Hard: Too Many Requests` | UPS rate-limited us mid-sweep; its rates were simply absent |

The last one matters for a matrix run: UPS answered on `us-canada` but not on `us-uk` or
`us-germany`, and the only difference was how fast the probes ran. A matrix that rate-shops has to be
paced, and a plan must not assert that a particular carrier is present unless it pins that carrier.

## Carriers that never answer

| Carrier | Why | Usable? |
|---|---|---|
| `fedex` | `Your account is restricted from using this carrier.` on every lane, including when asked for on its own | no |
| `canada_post` | `There is a mismatch between the endpoints and the authorization.` | no |
| `lso` | Texas regional: `Shipment origin or destination state is out of the service area for LSO.` | no |
| `couriersplease` | Asked for a company name on the from address; supplying one cleared that message but it still returned nothing on Sydney → Melbourne | no |
| `ups` (second account) | The account holds two `ups` entries; rates come back under one provider | n/a |

`au-domestic` is therefore **not a lane this package can use** — `couriersplease` is the only carrier
with an AU service area, and it answers nothing. Every other carrier on that lane reports an origin
outside its service area.

## What this settles for the layer set

- **Lane layers:** `us-domestic`, `ca-domestic`, `uk-domestic`, `de-domestic`, `fr-domestic`,
  `es-domestic`, `us-canada`, `us-uk`, `us-germany`. Not `au-domestic`.
- **Carrier layers:** `usps`, `ups`, `dhl-express`, `dpd-uk`, `hermes-uk`, `dpd-de`, `deutsche-post`,
  `colissimo`, `correos`, `chronopost`. Not `fedex`, `canada-post`, `lso`, `couriersplease`.
- **Parcel layers** need a letter under 50 g, a mid-sized box, and one at least 21 cm long.
- A carrier layer only composes with the lanes it serves, so the purchase matrix runs **per region**,
  as a layer group, rather than crossing every carrier with every lane. No `incompatible` primitive is
  needed: a layer group already picks at most one of its options.
