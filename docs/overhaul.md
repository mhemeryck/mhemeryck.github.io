# Personal Website Refresh

Create a static personal website for a senior software engineer.

## Goals

The website should become the single source of truth for:

- Personal homepage
- Resume / CV
- Blog
- Project portfolio

The site should be entirely static and deployable to GitHub Pages.

## Technical Requirements

- Use a static site generator (prefer Zola)
- No database
- No server-side runtime
- Build locally and in GitHub Actions
- Generate static HTML files
- Mobile-friendly
- Fast loading
- Minimalist design
- Dark mode support

## Content Structure

content/
├── about
├── resume
├── projects
├── blog

## Resume Requirements

The resume should be stored as structured data (YAML or TOML).

Example sections:

- Personal information
- Summary
- Experience
- Education
- Certifications
- Skills
- Publications
- Talks / presentations

The resume data must be reusable.

Generate:

- /resume/ HTML page
- downloadable PDF CV

The PDF and HTML version must originate from the same source data.

## Project Pages

Support dedicated pages for projects.

Initial projects:

- Home automation platform
- Facturette
- GODA / CODA parser-generator
- Architecture documentation work

Each project page should contain:

- Problem
- Constraints
- Design decisions
- Technologies used
- Lessons learned

## Blog

Support Markdown-based blog posts.

Requirements:

- Tags
- RSS feed
- Syntax highlighting
- Reading time
- Previous / next navigation

## Design

Design goals:

- Engineering-focused
- Professional
- Minimalist
- Content-first
- No unnecessary animations
- No hero images
- No marketing language

Inspiration:

- Personal websites of experienced software engineers
- Technical blogs
- Academic homepages

## Deployment

- GitHub Pages
- GitHub Actions workflow
- Custom domain support
- Automatic deployment on push to main

## Initial Migration

Create placeholder content and import the existing blog and resume later.

Focus first on:

1. Site structure
2. Resume data model
3. HTML resume rendering
4. PDF generation pipeline
5. GitHub Pages deployment

Keep the architecture simple and maintainable.
