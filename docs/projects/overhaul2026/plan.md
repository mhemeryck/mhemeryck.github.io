# Plan

This document tracks the practical plan for turning the existing blog and CV material into a coherent professional profile.

The work is intentionally split between near-term application work and longer-term overhaul work.

## Guiding Documents

- [brief.md](brief.md): long-term design brief and technical direction
- [positioning.md](positioning.md): professional narrative and public positioning
- [current-cv.md](current-cv.md): current CV contents captured as source material

## Checklist

- [ ] [Phase 0: repository and tooling cleanup](#phase-0-repository-and-tooling-cleanup)
- [ ] [Phase 1: application profile](#phase-1-application-profile)
- [ ] [Phase 2: resume and content model](#phase-2-resume-and-content-model)
- [ ] [Phase 3: visual and technical overhaul](#phase-3-visual-and-technical-overhaul)
- [ ] [Phase 4: resume generation](#phase-4-resume-generation)

## Near-Term Scope

The near-term goal is to improve the public profile enough to support a job application.

This should avoid turning into a full site migration or complete redesign.

Keep the current Hugo setup unless there is a strong reason to change it.

Focus on making existing seniority and project ownership visible.

### Near-Term Deliverables

- professional landing page
- projects overview page
- one strong project case study
- clear links to CV, LinkedIn, GitHub, and relevant writing
- minimal style improvements where they directly support readability and positioning

### Near-Term Non-Goals

- full Zola migration
- full custom design system
- complete resume data model
- PDF resume generation
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
- [x] verify the site can be built locally
- [ ] verify the GitHub Pages deployment path still works

Success criteria:

- local development has a documented, reproducible entry point
- major tooling dependencies are no longer stale
- GitHub Actions no longer rely on outdated action versions
- the cleanup remains separate from content and design changes

## Phase 1: Application Profile

Goal: create a credible, focused public profile quickly.

Tasks:

- [ ] define homepage message from [positioning.md](positioning.md)
- [ ] add or adapt homepage content around professional positioning
- [ ] add a projects section
- [ ] write one case study for the home automation platform
- [ ] link existing home automation blog posts as supporting evidence
- [ ] make navigation point to projects, writing, CV, GitHub, and LinkedIn
- [ ] keep styling changes small and deliberate

Success criteria:

- a technically sophisticated reviewer can understand what kind of engineer I am within a minute
- the site communicates systems thinking, ownership, and delivery
- the site no longer reads only as a chronological blog

## Phase 2: Resume And Content Model

Goal: turn the current CV and project material into reusable structured content.

Tasks:

- [ ] design a structured resume data model
- [ ] map [current-cv.md](current-cv.md) into the model
- [ ] decide which resume content belongs on the website versus in a PDF
- [ ] create an HTML resume page
- [ ] improve selected experience bullets around ownership, tradeoffs, and outcomes
- [ ] add additional project pages beyond home automation

Success criteria:

- resume content exists in one maintainable source
- website and resume tell the same story
- project pages provide evidence for resume claims

## Phase 3: Visual And Technical Overhaul

Goal: make the site feel intentionally designed rather than theme-driven.

Tasks:

- [ ] decide whether to stay on Hugo or migrate to Zola
- [ ] replace the current theme-driven style with custom templates and CSS
- [ ] refine typography, spacing, navigation, and project presentation
- [ ] preserve important URLs where possible
- [ ] revisit deployment and CI after the generator decision

Success criteria:

- the site looks and feels like a durable engineering portfolio
- the implementation remains simple and maintainable
- content remains Markdown-based and easy to update

## Phase 4: Resume Generation

Goal: generate multiple resume outputs from the same source data.

Tasks:

- [ ] generate HTML resume from structured data
- [ ] generate PDF resume from the same data
- [ ] consider machine-readable formats if useful
- [ ] decide how the existing LaTeX CV should evolve or be retired

Success criteria:

- resume data is not duplicated across systems
- HTML and PDF outputs are consistent
- updating resume content is straightforward
