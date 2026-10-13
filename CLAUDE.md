# CLAUDE.md

Spindle's marketing site, a Hugo static site. See `README.md` for layout, commands, and content rules.

- Task tracking is in the analyzer repo (`../analyzer`, `td-fd2027`); run `td` from there.
- `just check` must pass before a commit. Never commit without the user's approval; no attribution lines in commits.
- Conventional Commits (`feat(site): ...`, `docs: ...`).
- Every product claim must match what has shipped in the analyzer repo; the "What Spindle reads" page must match its `docs/TRAY.md` and the hard constraints in its `CLAUDE.md`.
- Keep `assets/css/tokens.css` in step with `../analyzer/dashboard/src/tokens.css`.
- No external scripts or fonts without a decision; the site has no JavaScript today.
