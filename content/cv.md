+++
title = "CV"
subtitle = "Martijn Hemeryck"
+++

## Contact

- Location: [Tongeren-Borgloon, Belgium](geo:50.7865,5.4174)
- GitHub: [mhemeryck](https://github.com/mhemeryck)
- LinkedIn: [martijn-hemeryck](https://linkedin.com/in/martijn-hemeryck-67896245)
- Stack Overflow: [martyn](https://stackoverflow.com/users/1393391/martyn)
- Blog: [Martyn's musings](/posts/)

## Profile

TODO

## Experience

### [Codabox By Wolters Kluwer](https://codabox.com)

**Senior Software Engineer**
August 2018 - present

Codabox provides accounting-data feeds for accountants and small and medium-sized enterprises doing their own accounting.
The platform integrates with source providers such as banks, payroll offices, credit card providers, and [PEPPOL](https://peppol.org/).[^peppol]
It handles both sourcing and delivery of accounting data, as well as the consent flows required to make those end-to-end data exchanges possible.
My work has moved across backend development, frontend development, analysis, architecture, cloud infrastructure, and technical leadership on several of these sourcing, delivery, and consent systems.

Selected projects and achievements:

#### 2025-2026: Sourcery And CODA Domain Tooling

- Worked on a new solution for generating historical bank statements from open-banking data.[^open-banking]
- Helped steer the team toward a Go-first implementation model for new services.
- Worked in a monorepo setup supporting multiple services, application code, infrastructure code, and CI pipelines from a single versioned context.
- Helped shape a serverless-first infrastructure direction with AWS Lambda as the main runtime platform.
- Developed an optimized CODA bank-statement parsing and generation with minimal allocations and memory usage.
- Started and improved AI-based tooling and project context for LLM-assisted workflows in the team.

#### 2023-2025: Partner SFTP And Bank Connectivity

- Onboarded and stabilized file exchange with banks, social offices, and external partners.
- Worked directly on network-level integrations using SFTP, VPNs, whitelisted IPs, credentials, and partner-specific validation.
- Set up connectivity and supporting infrastructure with infrastructure-as-code according to security requirements and operational best practices.
- Helped prevent silent data loss, failed transfers, and manual troubleshooting.

#### 2023: CARO / CCS Activation Flows

- CARO is Codabox's credit card statement offering to accountants.
- Our team inherited an initial Java implementation and wanted to migrate it toward a Go-based stack.
- At the same time, there was a business requirement to onboard an additional source provider.
- Helped set up an approach to migrate the implementation endpoint by endpoint from Java to Go while keeping both systems operational.
- Helped fulfill the extra source-provider requirement during the migration instead of treating modernization and delivery as separate tracks.

#### 2021-2022: Consent And Mandate Signing Platform

- Clients of accountants need to consent that banks can share their data with Codabox and that Codabox can share that data with their accountant.
- Helped replace a largely paper-based mandate process with a digital signing flow during the onboarding of a new bank.
- Integrated a third-party digital signing provider with the existing Codabox systems to support a fully digital process for both mandates.
- Helped make the solution generic enough that most integrated banks could later move to the same flow with limited extra effort during the COVID pandemic.

#### 2018-2020: Faster CODA Processing

- The core Codabox system had issues delivering sourced CODA files from banks to customers on time.
- Reworked the intermediate batch-processing steps so file processing could run in parallel.
- Increased overall throughput and helped ensure customers received their files before 8h00 in the morning.

#### Ongoing: MyCodabox And Support Visibility

- Worked beyond backend and infrastructure on customer-facing and internal support tooling frontend development.
- Contributed to [MyCodabox](https://www.mycodabox.com/), the main portal accountants use to manage mandates and subscriptions.
- Worked on MyConsent, an onboarding tool for accountants' clients to safely activate integrations such as credit card statements according to PCI guidelines.
- Did the groundwork for an Electron-based desktop delivery client where local customer workflows required a dedicated application.
- Built and improved internal support tooling, including Django-admin-based and React-based interfaces.
- Added visibility for activation, registration, reconnect, CARO, reporting, and failure states across customer-facing and support-facing flows.

#### Ongoing: Cloud, CI, And Security Modernization

- Work in a DevOps model where the team runs and manages its own infrastructure.
- Manage infrastructure through infrastructure-as-code, mostly with Terraform.
- Worked mostly on GCP-based systems before taking a leading role in the team's transition toward AWS.
- Bring hands-on experience selecting appropriate cloud technologies, from VMs and Kubernetes clusters to serverless runtimes such as GCP Cloud Run and AWS Lambda.
- Manage and improve CI pipelines across CircleCI, GitHub Actions, and GitLab CI.
- Help keep production services deployable, auditable, and aligned with security expectations.

### Unleashed

TODO

### SoundTalks

TODO

### KU Leuven Medical Imaging Research Center

TODO

## Selected Projects

TODO

## Education

### KU Leuven

TODO

### KU Leuven

TODO

## Selected Academic Work

TODO

## Skills

TODO

## Certifications

TODO

## Languages

TODO

## Interests

TODO

[^peppol]: PEPPOL is the European e-invoicing network.
[^open-banking]: Open banking in this context builds on the [Payment Services Directive](https://en.wikipedia.org/wiki/Payment_Services_Directive).
