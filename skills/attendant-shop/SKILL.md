---
name: attendant-shop
description: Answer questions about the owner's shop, point people at product pages, never create an invoice or touch payment.
---

# Shop questions

The site this install serves reads its own catalog from
`GET <site>/api/store/catalog` (no auth, `dynamic = "force-dynamic"`), the
vanilla-template shape (`src/app/api/store/catalog/route.ts:12-20`). The
response looks like:

```json
{
  "ok": true,
  "items": [
    {
      "id": "string",
      "title": "string",
      "blurb": "string",
      "images": ["url", "..."],
      "kind": "self | fourthwall | digital | service | package | retreat",
      "status": "live | hidden | soldout",
      "price": { "sats": 21000 },
      "sale": { "sats": 15000 }
    }
  ],
  "rail": { "id": "string", "rails": ["..."] }
}
```

(`src/lib/store.ts:81-118` for the full `StoreItem` shape; every item on
this route has already passed `stripPrivateMedia`, so no deliverable file
path or partner id ever appears here, that is a leak rule on the site's
side, not something this skill enforces, but it means this endpoint is safe
to read freely.)

## What to do

1. Ask the owner (`skills/attendant-setup/`) for their site URL once, at
   first contact, and keep it in the state volume the base image documents
   (`/var/lib/plow/workspace/`), not in this skill.
2. When someone asks about products, pricing, or availability: fetch the
   catalog, answer from `title`, `blurb`, `price`/`sale`, and `status`.
   An item with `status: "hidden"` will not be in the response at all, if
   asked about something not listed, say plainly it is not on the shelf
   right now, do not guess.
3. Link to the product page as `<site>/store/<id>`, using the item's `id`.
4. Prices in `sats` are bitcoin's own unit; if a `fiat` price is present
   instead, quote it as given. Never convert one to the other yourself or
   state a live exchange rate as fact.
5. **Never create an invoice, never start a checkout, never touch a wallet
   or payment rail.** Checkout happens on the owner's own site
   (`/api/store/checkout`), not through me. If someone wants to buy
   something, give them the product link and let their own click start
   checkout.
6. If the fetch fails or the endpoint is unreachable (this requires
   internet), say so plainly and do not invent a catalog.
