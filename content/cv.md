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

### [Unleashed](https://unleashed.be) / [Mobile Vikings](https://mobilevikings.be)

**Software Engineer / Analyst**
July 2016 - July 2018

Unleashed was the digital product and engineering organization behind [Mobile Vikings](https://mobilevikings.be), [Jim Mobile](https://jimmobile.be), and Stievie.[^stievie]
I worked across full-stack development and analysis roles for customer-facing telecom and media products.

Selected projects and responsibilities:

#### 2017-2018: Marketing Automation Squad

- Worked on cross-brand full-stack development for Mobile Vikings, Jim Mobile, and Stievie.
- Helped analyze and shape backend REST API architecture for marketing automation flows.

#### 2016-2017: Mobile Vikings Get And Retain Squad

- Worked on the Mobile Vikings prepaid registration project, helping the team adapt customer registration flows after Belgian regulation required prepaid SIM cards to be linked to verified identity.
- Built and maintained full-stack marketing campaign features for Mobile Vikings.
- Helped analyze marketing backend changes for a full mobile virtual network operator (MVNO) migration, supporting Mobile Vikings' move from a direct telecom backend integration to a third-party-managed backend and a customer SIM-swap migration.

### [SoundTalks](https://www.soundtalks.com/en/)

**Research Engineer**
September 2012 - July 2016

SoundTalks is a KU Leuven spin-off developing acoustic monitoring technology for livestock health.
I joined as the first employee, working in a small early-stage company where research, software development, field deployment, customer contact, and commercial support were closely connected.

Selected responsibilities and achievements:

- Led research and development work for the Pig Cough Monitor algorithm and supporting software.
- Handled on-site installations, maintenance, data collection, and customer-facing technical follow-up.
- Managed data storage and database work needed for algorithm development, validation, and product operation.
- Improved software development practices around version control, build processes, and release management.
- Represented the company at technical, academic, and commercial conferences, including direct conversations with potential partners and customers.

### [KU Leuven Medical Imaging Research Center](https://www.kuleuven.be/samenwerking/mirc)

**Research Assistant**
September 2010 - August 2012

The Medical Imaging Research Center is a KU Leuven research center applying digital signal processing, machine vision, and image-analysis techniques to medical imaging problems.
This was my first role after completing my master's degree, combining research software development, image analysis, and teaching assistance.

Selected projects and responsibilities:

- Worked on validation of a 3-D volumetric approach to evaluate local bone changes.
- Developed software for integrated registration and segmentation in 2-D and 3-D follow-up analyses of oral and maxillofacial surgery using cone-beam computed tomography.
- Worked on quantification of lung pathology based on computed tomography (CT).
- Worked as a teaching assistant for an undergraduate digital signal processing course.

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
[^stievie]: Stievie was a Belgian online streaming platform and predecessor to [VTM GO](https://www.vtmgo.be/).
