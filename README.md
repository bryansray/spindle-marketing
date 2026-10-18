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
| `hugo.toml` | Site config: URLs for the app, sign-in, and download (`[params]`), the menu |
| `content/` | One Markdown file per page; the home page's hero screenshot, tour, and feature cards are in `_index.md`'s front matter |
| `layouts/` | Templates (`_default/baseof.html` is the shell; `partials/` holds the header, footer, call-to-action, `shot.html`, and `mark.html`, the brand mark from the analyzer repo's `brand/spindle-mark.svg`, drawn in the accent like the app's header; `shortcodes/shot.html` puts a screenshot in a Markdown page) |
| `assets/images/` | Screenshots of the app, full-size PNGs at 2x; Hugo serves them as WebP at 720, 1200, and 1800 wide, and crops `latest-key.png` into the social preview image |
| `assets/css/tokens.css` | The app's "Ledger" design tokens, copied from the analyzer repo's `dashboard/src/tokens.css`; keep them in step by hand |
| `assets/css/site.css` | This site's layout |
| `static/` | Files served as they are: the favicons, copied from the analyzer repo's `dashboard/public/` |

## Content rules

- Claim only what has shipped. Upcoming work goes under "Coming next" on the Features page.
- The "What Spindle reads" page must match the analyzer repo's `docs/TRAY.md` ("Game files") and the hard constraints in its `CLAUDE.md`.
- No Blizzard art or logos; keep the "not affiliated" line in the footer.

## Screenshots

Taken from the analyzer repo's `just cloud-demo` (the demo user, Demo#1001, signed in through the fake Battle.net), dark theme, at 1440 wide and a device pixel ratio of 2, then cropped to the panel being shown. Character names are the user's own group's. Retake them when the screens they show change. In a page:

```
{{</* shot name="explorer" alt="What the screenshot shows, for someone who can't see it" caption="Optional" */>}}
```

## Hosting

Planned: Cloudflare (Pages, or Workers static assets like the dashboard) at `www.spindlelogs.com`, with the apex redirecting to it (`td-54eac1`). Build command `hugo --gc --minify`, output `public/`.
