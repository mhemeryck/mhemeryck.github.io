# Plan

This document tracks the practical plan for turning the existing CV material into a single-source CV with web and PDF outputs.

The work is intentionally focused on getting a usable CV ready for job applications without turning the blog into a full portfolio rebuild.

## Guiding Documents

- [brief.md](brief.md): long-term design brief and technical direction
- [positioning.md](positioning.md): professional narrative and public positioning
- [current-cv.md](current-cv.md): current CV contents captured as source material
- [cv-achievement-themes.md](cv-achievement-themes.md): sanitized achievement themes for CV wording

## Checklist

- [x] [Phase 0: repository and tooling cleanup](#phase-0-repository-and-tooling-cleanup)
- [ ] [Phase 1: about page and web CV](#phase-1-about-page-and-web-cv)
- [ ] [Phase 2: PDF CV](#phase-2-pdf-cv)
- [ ] [Phase 3: application polish](#phase-3-application-polish)
- [ ] [Phase 4: optional site overhaul](#phase-4-optional-site-overhaul)

## Near-Term Scope

The near-term goal is to create a concise public profile and a complete CV that can be read on the website and sent as a PDF for job applications.

This should avoid turning into a full site migration or complete redesign.

Keep the current Hugo setup unless there is a strong reason to change it.

Focus on making existing seniority, ownership, and technical depth visible through the CV.

### Near-Term Deliverables

- concise `about` page for the public profile
- complete web CV page used as the maintainable CV source
- PDF CV generated from that source
- clear links to CV, LinkedIn, GitHub, and relevant writing
- minimal style improvements where they directly support readability and positioning

### Near-Term Non-Goals

- full Zola migration
- full custom design system
- portfolio project pages
- project case studies
- full blog migration or rewrite
- perfect portfolio site

## Phase 0: Repository And Tooling Cleanup

Goal: bring the existing repository up to date before changing the public profile.

This phase should make local development and deployment predictable without turning into a redesign.

Tasks:

- [x] add an `AGENTS.md` file with project-specific working instructions
- [x] update Hugo to a current version
- [x] update Go to a current version if the repository still needs Go tooling
- [x] add a Nix flake for local Hugo development tooling
- [x] add a `justfile` for common local operations
- [x] document the local development command
- [x] update GitHub Actions versions and action dependencies
- [x] add a Hugo production build check to pull request CI
- [x] remove the fixup-commit blocking workflow
- [x] update Markdown working instructions in `AGENTS.md`
- [x] normalize blog post heading levels for the current Hugo theme
- [x] fix small Markdown content issues found during repository review
- [x] add `lastmod` metadata for posts changed during cleanup
- [x] verify the site can be built locally
- [x] verify the GitHub Pages deployment path still works

Success criteria:

- local development has a documented, reproducible entry point
- major tooling dependencies are no longer stale
- GitHub Actions no longer rely on outdated action versions
- the cleanup remains separate from content and design changes

## Phase 1: About Page And Web CV

Goal: create a concise public `about` page and a complete standalone web CV page backed by one maintainable CV source.

Tasks:

- [x] decide the CV source format
- [x] define the CV sections needed for job applications
- [ ] map [current-cv.md](current-cv.md) into the CV source
- [ ] complete the remaining CV sections after the Codabox experience
- [x] improve the Codabox experience around ownership, tradeoffs, and outcomes
- [ ] improve remaining experience bullets around ownership, tradeoffs, and outcomes
- [ ] choose which projects and writing links support the CV
- [x] keep `about` as a short curated profile rather than a complete CV
- [x] render the complete CV source as a standalone Hugo page
- [x] link from the `about` page to the full CV page
- [x] make navigation point to the public profile, writing, GitHub, and LinkedIn
- [x] keep styling changes small and focused on readability
- [ ] remove or postpone material that belongs in a later portfolio overhaul

Success criteria:

- the CV content exists in one maintainable source
- the about page is concise, readable, and shareable
- the full web CV is complete enough to act as the source for PDF generation
- the CV communicates seniority, systems thinking, ownership, and delivery
- the existing blog can remain mostly unchanged
- the content is ready to drive the PDF output

## Phase 2: PDF CV

Goal: generate a sendable PDF CV from the same source as the web CV.

Tasks:

- [ ] choose the PDF generation approach
- [ ] generate a PDF CV from the CV source
- [ ] verify the PDF layout is suitable for job applications
- [ ] decide how the existing LaTeX CV should evolve or be retired
- [ ] document the command for regenerating the PDF

Success criteria:

- web and PDF CV outputs are consistent
- resume content is not duplicated across systems
- updating the CV and regenerating outputs is straightforward

## Phase 3: Application Polish

Goal: make the web CV and PDF CV clear enough to support job applications.

Tasks:

- [ ] refine the opening profile around [positioning.md](positioning.md)
- [ ] link relevant blog posts as supporting evidence where useful
- [ ] tighten project and experience wording based on the generated outputs
- [ ] verify the web CV is easy to find from the site navigation
- [ ] verify the PDF is suitable to send with applications

Success criteria:

- a technically sophisticated reviewer can understand what kind of engineer I am within a minute
- the CV communicates systems thinking, ownership, and delivery
- the application materials are ready to share

## Phase 4: Optional Site Overhaul

Goal: improve the surrounding site only if the current setup becomes limiting.

Tasks:

- [ ] add project pages or case studies only if they support applications
- [ ] decide whether to stay on Hugo or migrate to Zola only if there is a concrete reason
- [ ] replace the current theme-driven style with custom templates and CSS only if needed
- [ ] improve typography, spacing, navigation, and project presentation
- [ ] preserve important URLs where possible

Success criteria:

- the site supports the CV without becoming a full redesign project
- the implementation remains simple and maintainable
- content remains Markdown-based and easy to update
