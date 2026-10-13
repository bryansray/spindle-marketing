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
