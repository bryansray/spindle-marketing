# Spindle marketing site

The public site at https://www.spindlelogs.com: what Spindle is, how it works, what it reads, and links to download the app and sign in. Built with [Hugo](https://gohugo.io) (extended, 0.167+), no theme.

The app itself lives in the separate `analyzer` repository; its dashboard is at https://app.spindlelogs.com. Work on this site is tracked there in `td` (`td-fd2027`).

## Commands

- `just dev`: serve locally at http://localhost:1313 with live reload
- `just build`: build into `public/`
- `just check`: build with warnings as errors

## Layout

| Path | What |
|---|---|
| `hugo.toml` | Site config: URLs for the app, sign-in, the Download page, and the downloads bucket (`[params]`), the menu |
| `content/` | One Markdown file per page; the home page's hero screenshot, tour, and feature cards are in `_index.md`'s front matter |
| `layouts/` | Templates (`_default/baseof.html` is the shell; `partials/` holds the header, footer, call-to-action, `shot.html`, and `mark.html`, the brand mark from the analyzer repo's `brand/spindle-mark.svg`, drawn in the accent like the app's header; `shortcodes/shot.html` puts a screenshot in a Markdown page) |
| `assets/images/` | Screenshots of the app, full-size PNGs at 2x; Hugo serves them as WebP at 720, 1200, and 1800 wide, and crops `latest-key.png` into the social preview image |
| `assets/css/tokens.css` | The app's "Ledger" design tokens, copied from the analyzer repo's `dashboard/src/tokens.css`; keep them in step by hand |
| `assets/css/site.css` | This site's layout |
| `assets/css/fonts.css`, `static/fonts/` | IBM Plex Sans (400, 500, 600) and Mono (400, 500), Latin and Latin Extended, copied from the analyzer repo's dashboard (`@fontsource` 5.3.0) and served from this site; licences in `static/fonts/OFL-IBM-Plex-Sans.txt` and `static/fonts/OFL-IBM-Plex-Mono.txt` |
| `static/` | Files served as they are: the favicons, copied from the analyzer repo's `dashboard/public/` |

## Content rules

- Claim only what has shipped. Upcoming work goes under "Coming next" on the Features page.
- The "What Spindle reads" page must match the analyzer repo's `docs/TRAY.md` ("Game files") and the hard constraints in its `CLAUDE.md`.
- No Blizzard art or logos; keep the "not affiliated" line in the footer.

## The Download page

`content/download.md` (the steps) with `layouts/_default/download.html`. Its buttons go to the downloads bucket's stable `latest/` names, and its checksums link is `latest/SHA256SUMS`: each Spindle release replaces all three, so the page names no version and never needs a deploy after a release. The steps must match the analyzer repo's `docs/INSTALL.md` ("For players"); the app's `/install` forwards here.

## Screenshots

Taken from the analyzer repo's `just cloud-demo` (the demo user, Demo#1001, signed in through the fake Battle.net), dark theme, at 1440 wide and a device pixel ratio of 2, then cropped to the panel being shown. Character names are the user's own group's. Retake them when the screens they show change. In a page:

```
{{</* shot name="explorer" alt="What the screenshot shows, for someone who can't see it" caption="Optional" */>}}
```

## Hosting

Cloudflare Workers static assets, like the app's dashboard (`td-54eac1`; the analyzer repo's `docs/DEPLOY.md`): the Worker `spindle-site`, configured in `wrangler.jsonc`, serves Hugo's `public/` as it is, with no script. Response headers (a CSP with no script at all, and long caching for the fingerprinted CSS and images) are in `static/_headers`.

- `just deploy`: `just check`, then `wrangler deploy`. It refuses with uncommitted changes, so what's live is always a commit.
- **CI** (`.github/workflows/deploy.yml`): every push to `main`, and by hand (Actions › Deploy › Run workflow), runs the same `just deploy`, then `just hosts`. Its `Production` environment (deployment branches: `main` only) holds the secret `CLOUDFLARE_API_TOKEN`, a Cloudflare API token with Account `Workers Scripts: Edit` and Zone `Workers Routes: Edit` and `Zone: Read` on `spindlelogs.com`, and the variable `CLOUDFLARE_ACCOUNT_ID`.
- `just hosts`: checks the live site (www, the Download page, a 404, the apex's redirect, the CSP).
- `www.spindlelogs.com` and `spindlelogs.com` are the Worker's custom domains: `wrangler deploy` made their DNS records and certificates (shown read-only in the zone's DNS; detach the domain from the Worker to remove one). The apex is attached only for its record and certificate: a Redirect Rule in the `spindlelogs.com` zone (Rules › Redirect Rules) sends it to `https://www.spindlelogs.com` with the path and query, 301, before it reaches the Worker.
