# CLAUDE.md — tire-clients (Client Intake Site)

This file is read automatically by Claude Code at the start of every session.

---

## What this project is

This is the **public-facing client intake site** for Truth in Real Estate. It lives at **https://tire-clients.fly.dev** and is where potential buyers and sellers fill out the intake form to get matched with a referral agent.

**This is NOT the CRM.** The CRM (internal tool) is a separate repo called `truth-in-real-estate`.

---

## The four TIRE sites — which folder is which

| Site | Folder | Live URL | Purpose |
|---|---|---|---|
| Client intake | `tire-clients` ← **YOU ARE HERE** | tire-clients.fly.dev | Public intake form for buyers/sellers |
| CRM | `truth-in-real-estate` | tire-crm.fly.dev | Internal team tool |
| Agent portal | `tire-agents` | tire-agents.fly.dev | Future — agent-facing portal |
| Marketing site | `tire-main` | truthinrealestate.com (future) | Future — public website |

---

## Files in this project

| File | What it is |
|---|---|
| `index.html` | The main page — hero, team section, all site content |
| `form.html` | The intake form embedded inside index.html |
| `logo.png` | Site logo |
| `nginx.conf` | Server config — do not edit |
| `Dockerfile` | Build config for Fly.io — do not edit |
| `fly.toml` | Fly.io deployment config — do not edit |

**To make content changes, edit `index.html` or `form.html`.**

---

## How to deploy after making changes

```
flyctl deploy
```

Run this from inside the `tire-clients` folder.

---

## Design — colors and fonts

| Element | Value |
|---|---|
| Dark navy | `#14213d` |
| Warm cream | `#faf9f6` |
| Gold accent | `#d4b07a` |
| Body font | Inter |
| Heading font | Red Hat Display |

---

## Who works on this

- **Kati Spaniak** — content and design decisions
- **Lisa Spaniak** — technical lead, deployments

---

*This file is maintained by Lisa Spaniak. Update it when major changes are made to this project.*
