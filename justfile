# Spindle's marketing site (Hugo). `just` lists the recipes.

default:
    @just --list

# Serve the site locally with live reload (drafts included)
dev:
    hugo server --buildDrafts --disableFastRender

# Build the production site into public/
build:
    hugo --gc --minify --cleanDestinationDir

# Build with warnings as errors: the gate before a commit
check:
    hugo --gc --minify --cleanDestinationDir --panicOnWarning --printPathWarnings

# (Cloudflare Workers static assets, wrangler.jsonc. Refuses with uncommitted
# changes, so what's live is always a commit; SPINDLE_DEPLOY_ANYWAY=1 skips
# that. The apex's redirect to www is a Redirect Rule in the zone, not here.)
#
# Build, check, and deploy the site to www.spindlelogs.com
deploy: check
    #!/usr/bin/env bash
    set -euo pipefail
    if [ "${SPINDLE_DEPLOY_ANYWAY:-}" != 1 ] && [ -n "$(git status --porcelain)" ]; then
        echo "deploy: uncommitted changes; commit them first (or SPINDLE_DEPLOY_ANYWAY=1)" >&2
        exit 1
    fi
    command -v wrangler >/dev/null || { echo "wrangler not found: npm install -g wrangler" >&2; exit 1; }
    wrangler deploy

# Check the live site: www and its headers, a 404, the apex redirect, the Download page
hosts:
    #!/usr/bin/env bash
    set -uo pipefail
    fail=0
    check() { # name, url, expected status
        got="$(curl -s -o /dev/null -w '%{http_code}' -m 10 "$2")"
        if [ "$got" = "$3" ]; then echo "ok   $1 ($got)"; else echo "FAIL $1: $got, expected $3"; fail=1; fi
    }
    check "www" https://www.spindlelogs.com/ 200
    check "features" https://www.spindlelogs.com/features/ 200
    check "download" https://www.spindlelogs.com/download/ 200
    check "missing page" https://www.spindlelogs.com/no-such-page/ 404
    check "apex redirects" https://spindlelogs.com/features/ 301
    loc="$(curl -sI -m 10 https://spindlelogs.com/features/?a=1 | tr -d '\r' | awk 'tolower($1)=="location:"{print $2}')"
    [ "$loc" = "https://www.spindlelogs.com/features/?a=1" ] && echo "ok   apex keeps path and query" || { echo "FAIL apex location: ${loc:-none}"; fail=1; }
    curl -sI -m 10 https://www.spindlelogs.com/ | grep -qi '^content-security-policy:' && echo "ok   CSP header" || { echo "FAIL no CSP header"; fail=1; }
    exit $fail
