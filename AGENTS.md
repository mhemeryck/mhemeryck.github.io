# Repository Instructions

This repository contains a Hugo-based personal website and blog.

## Working Style

- Keep changes small and focused.
- Prefer content and tooling changes over broad redesigns unless explicitly requested.
- Preserve existing URLs where possible.
- Use Markdown links for references to local documentation files.

## Local Development

- Prefer the Nix flake development shell for local tooling.
- Use `nix develop` before running Hugo commands when Nix is available.
- Use `hugo server -D` for local previews.
- Use `hugo --minify` to verify a production build.

## Markdown

- Use `[ ]` and `[x]` for checkbox lists.
- Keep Markdown simple and readable.
- Use one sentence per line in all Markdown documents to keep diffs coherent.
- Prefer reference-style Markdown links and collect link definitions at the bottom of the document.

## Git

- Never commit without explicit user approval.
- Never push without explicit user approval.
- Approval for one git operation does not imply approval for another.
- When in doubt, stop and ask before running `git commit`, `git push`, or any command that changes remote state.
- Write pull request descriptions so they can be used directly as squash commit messages.
- Start with the intended commit title, then a blank line, then a concise body that explains why the change exists.
- Avoid checklist-style pull request descriptions unless explicitly requested.

## Deployment

- The site deploys to GitHub Pages through GitHub Actions.
- Keep deployment changes separate from content and design changes where possible.
