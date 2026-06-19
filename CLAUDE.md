# tire-clients

## What This Repo Is

This is the public-facing client intake site for Truth in Real Estate (rebranding from Kati Spaniak Team). It lives at `https://tire-clients.fly.dev` and is where potential buyers and sellers fill out a multi-step intake form to be matched with a TruthCertified referral agent. It also hosts the "Investment Matrix" quiz, a standalone tool that helps homeowners decide which renovation category their property falls into. There is no backend here — all form submission logic hits a Supabase Edge Function in the main CRM.

---

## Tech Stack

- Pure static HTML, CSS, and vanilla JavaScript — no framework, no build step
- Nginx (alpine) serves files inside a Docker container
- Deployed on Fly.io
- Form submissions POST to a Supabase Edge Function (`submit-referral-form`)
- Main landing page (`index.html`) is GHL (Go High Level) page-builder output — large and minified, not hand-editable

---

## File Structure

```
tire-clients/
├── index.html                  # Public landing page (GHL-generated, 745KB, do not hand-edit)
├── form.html                   # 4-step client intake form (hand-written, iframe-embeddable)
├── investment-matrix.html      # Redirect/wrapper to investment-matrix/index.html
├── investment-matrix/
│   ├── index.html              # Full investment matrix quiz page (standalone)
│   └── og-image.png            # OG social share image
├── logo.png
├── Dockerfile                  # nginx:alpine, copies HTML files, no build
├── nginx.conf                  # Serves /usr/share/nginx/html, falls back to index.html
├── fly.toml                    # Fly.io app config
└── package.json                # Only script: local dev server via npx serve
```

**Edit `form.html` for intake form changes. Edit `investment-matrix/index.html` for quiz changes. Do not hand-edit `index.html` — it is GHL-generated.**

---

## How to Run / Develop

Local dev server (no install needed):

```bash
npm start
# Runs: npx serve -p 3002 --open
# Site available at http://localhost:3002
```

There is no build step. Save a file, refresh the browser.

---

## Deployment

- **Live URL:** `https://tire-clients.fly.dev`
- **Platform:** Fly.io, region `iad` (US East)
- **VM:** 256MB RAM, 1 shared CPU, scales to zero when idle
- **Deploy command:**

```bash
flyctl deploy
```

The Dockerfile copies all HTML files and `logo.png` into the nginx html root and serves on port 8080. Fly.io forces HTTPS automatically.

---

## Environment Variables

There are no `.env` files or build-time injection. Two values are hardcoded directly in `form.html` (lines 481–482):

| Variable | Purpose |
|---|---|
| `EDGE_FUNCTION_URL` | Supabase Edge Function endpoint for form submission |
| `SUPABASE_ANON_KEY` | Supabase public anon JWT (safe to expose client-side by Supabase design) |

If the Supabase project changes, update both values directly in `form.html`.

---

## Key Patterns and Conventions

**Design tokens** (used in `form.html` and `investment-matrix/index.html`):
- Dark navy: `#14213d`
- Warm cream: `#faf9f6`
- Gold: `#d4b07a`
- Fonts: Inter (body), Red Hat Display (headings)

**form.html** is a 4-step multi-step form:
1. Contact info (name, email, phone)
2. Current address + agent type (Buy / Sell / Both)
3. Property details (dynamically renders buyer fields, seller fields, or both based on step 2)
4. Agent preferences (qualities checkboxes, hand-holding scale 1–10, best time to reach, DNR agents, free text)

On submit it POSTs a JSON payload to the Supabase Edge Function. It also uses `window.parent.postMessage` to communicate iframe resize events and submission completion back to the parent page when embedded as an iframe.

T&C consent checkbox is required — form will not submit without it.

**index.html** connects to `leadconnectorhq.com` and `filesafe.space` (GHL infrastructure). Credentials for GHL are managed inside the GHL platform, not in this repo.

**nginx.conf** uses a catch-all fallback to `index.html` (SPA-style routing), so any unknown path serves the landing page.

---

## Integrations

| Service | How it connects | Notes |
|---|---|---|
| Supabase | `form.html` POSTs to Edge Function `submit-referral-form` | Anon key hardcoded in client-side JS |
| Go High Level (GHL) | `index.html` embeds GHL form via `leadconnectorhq.com` scripts | Managed in GHL platform, not this repo |
| Fly.io | Docker + nginx deployment | `flyctl deploy` |

---

## Known Issues and Gotchas

- **`index.html` is GHL-generated and 745KB.** Do not attempt to hand-edit it for content changes — make those changes inside the GHL page builder and re-export, or coordinate with whoever manages GHL.
- **Supabase anon key is hardcoded** in `form.html`. This is intentional and safe by Supabase's design (anon keys are public), but if the Supabase project is ever rotated or migrated, remember to update this file and redeploy.
- **Scale-to-zero on Fly.io** means the first request after idle may have a cold-start delay of a few seconds. This is expected behavior.
- **Brand is mid-rebrand.** The investment matrix quiz still references "Kati's Investment Matrix" and OG tags point to `truthinrealestate.com`. When the rebrand to Truth in Real Estate is complete, audit both `investment-matrix/index.html` and `index.html` for stale brand references.
- **No HTTPS redirect in nginx.conf** — Fly.io handles HTTPS termination and forces it at the edge. Do not add SSL config to nginx.

---

## Session Update Rule

At the end of every session, update this CLAUDE.md to reflect any significant changes made (new features, files, deployment changes, process changes).
