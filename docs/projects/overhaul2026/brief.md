# Personal Website Refresh — Design Brief

## Background

I am a Belgian software engineer with 14+ years of professional experience.

My background includes:

- Electrical engineering (signal processing)
- Research and publications
- Python and Go backend development
- Cloud platforms (AWS and GCP)
- Kubernetes and infrastructure automation
- Software architecture
- Personal engineering projects

I currently maintain:

- a personal website
- a technical blog
- a LaTeX CV
- LinkedIn

These assets have evolved independently and are no longer consistent.

Recently I discovered Earendil, a startup founded by engineers with a strong reputation in software craftsmanship and open source.

While reviewing whether I should apply, I realized that my public profile no longer reflects the engineer I have become over the last decade.

The issue is not a lack of experience.

The issue is presentation.

My current CV mostly communicates:

- job titles
- technologies
- responsibilities

It does not communicate:

- architectural work
- systems thinking
- project ownership
- technical decision making
- measurable impact

The goal of this project is therefore not merely to build a new website.

The goal is to create a coherent professional profile that accurately represents my experience and can serve as the foundation for future opportunities, whether or not I eventually apply to Earendil.

## Design Principles

### Single Source of Truth

The same information should not be maintained in multiple places.

The website should become the authoritative source.

The resume data should exist once and be rendered into:

- HTML
- PDF
- machine-readable formats if useful later

### Content First

Content is more important than design.

Avoid:

- marketing language
- buzzwords
- unnecessary graphics
- flashy animations

Prioritize:

- clarity
- readability
- technical depth
- longevity

### Showcase Engineering Work

The site should emphasize:

- projects
- architectural decisions
- engineering tradeoffs
- lessons learned

rather than technology keyword lists.

### Maintainability

The site should feel like an engineering project.

It should be easy to:

- update
- version control
- review
- deploy

The maintenance burden should be near zero.

## What Makes This Profile Interesting

The website should help visitors understand the unusual combination of:

- research background
- software engineering
- cloud infrastructure
- architecture work
- personal systems projects

Representative examples include:

- home automation platform
- CODA/GODA parser-generator work
- architecture documentation initiatives
- AWS certification journey
- facturette
- technical blog posts

These projects are often more representative of my capabilities than job titles.

## Target Audience

Primary audience:

- engineering founders
- architects
- staff engineers
- hiring managers
- technically sophisticated recruiters

Secondary audience:

- fellow engineers
- readers of technical blog posts
- collaborators

The site should assume technical literacy.

## Desired Outcome

A visitor should leave with the impression:

"This is an experienced engineer who designs and builds systems, thinks carefully about tradeoffs, communicates clearly, and finishes projects."

Not:

"This person knows many technologies."

## Technical Requirements

- Static website
- GitHub Pages deployment
- GitHub Actions deployment pipeline
- Minimal dependencies
- Prefer Zola unless a compelling alternative exists
- Markdown-based content
- Structured resume data
- HTML resume generation
- PDF resume generation from the same source data

## Initial Deliverables

Phase 1:

- site structure
- content model
- resume data model
- resume HTML page
- PDF generation
- GitHub Pages deployment

Phase 2:

- project pages
- migration of existing blog content
- improved project writeups

Phase 3:

- polishing and visual refinement

The architecture should favor simplicity over cleverness.
