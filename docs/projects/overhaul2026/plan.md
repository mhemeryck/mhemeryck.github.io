# Plan

This document tracks the practical plan for turning the existing blog and CV material into a coherent professional profile.

The work is intentionally split between near-term application work and longer-term overhaul work.

## Guiding Documents

- `docs/overhaul.md`: long-term design brief and technical direction
- `docs/positioning.md`: professional narrative and public positioning
- `docs/current-cv.md`: current CV contents captured as source material

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

## Phase 1: Application Profile

Goal: create a credible, focused public profile quickly.

Tasks:

- define homepage message from `docs/positioning.md`
- add or adapt homepage content around professional positioning
- add a projects section
- write one case study for the home automation platform
- link existing home automation blog posts as supporting evidence
- make navigation point to projects, writing, CV, GitHub, and LinkedIn
- keep styling changes small and deliberate

Success criteria:

- a technically sophisticated reviewer can understand what kind of engineer I am within a minute
- the site communicates systems thinking, ownership, and delivery
- the site no longer reads only as a chronological blog

## Phase 2: Resume And Content Model

Goal: turn the current CV and project material into reusable structured content.

Tasks:

- design a structured resume data model
- map `docs/current-cv.md` into the model
- decide which resume content belongs on the website versus in a PDF
- create an HTML resume page
- improve selected experience bullets around ownership, tradeoffs, and outcomes
- add additional project pages beyond home automation

Success criteria:

- resume content exists in one maintainable source
- website and resume tell the same story
- project pages provide evidence for resume claims

## Phase 3: Visual And Technical Overhaul

Goal: make the site feel intentionally designed rather than theme-driven.

Tasks:

- decide whether to stay on Hugo or migrate to Zola
- replace the current theme-driven style with custom templates and CSS
- refine typography, spacing, navigation, and project presentation
- preserve important URLs where possible
- revisit deployment and CI after the generator decision

Success criteria:

- the site looks and feels like a durable engineering portfolio
- the implementation remains simple and maintainable
- content remains Markdown-based and easy to update

## Phase 4: Resume Generation

Goal: generate multiple resume outputs from the same source data.

Tasks:

- generate HTML resume from structured data
- generate PDF resume from the same data
- consider machine-readable formats if useful
- decide how the existing LaTeX CV should evolve or be retired

Success criteria:

- resume data is not duplicated across systems
- HTML and PDF outputs are consistent
- updating resume content is straightforward
