+++
title = "CV"
subtitle = "Martijn Hemeryck"
+++

## Profile

I'm Martijn, a software developer with an electrical engineering background.

During my studies, I specialized in embedded software and digital signal processing.

Over time I branched into broader backend, cloud, infrastructure, and full-stack software development.
I focus on product-facing platforms where technical design, operational reliability, and domain understanding all matter.

I like to analyze systems, take them apart, design them, and build them up again.
I am a developer and maker at heart, with a practical drive to solve problems end-to-end.

## Experience

### [Codabox By Wolters Kluwer](https://codabox.com)

**Senior Software Engineer**
August 2018 - present

Codabox provides accounting data for accountants and bookkeepers.
The platform integrates with source providers such as banks, payroll offices, credit card providers, and e-invoicing solutions.[^peppol]
It handles both sourcing and delivery of accounting data, as well as the consent flows required to make those end-to-end data exchanges possible.
My work has moved across backend and frontend development, analysis, architecture, cloud infrastructure, and technical leadership on several of these systems.

Selected projects and achievements:

#### 2025-2026: Sourcery And CODA Domain Tooling[^coda]

Accountants need a full overview of their clients' bank statements data, even if the banks cannot provide it directly.

- Helped build services that generate historical bank statements from open-banking data.[^open-banking]
- Steer the (sourcery) team toward a Go-first implementation model.
- Built the monorepo foundation for application code, infrastructure code and CI pipelines.
- Designed a serverless-first AWS Lambda infrastructure foundation.
- Developed low-allocation CODA bank-statement parsing and generation code.
- Introduced LLM-assisted tooling and project context to make team workflows easier to navigate.

#### 2023-2025: Partner SFTP And Bank Connectivity

Our team needed to take direct responsibility for VPN-based banking and payroll connectivity, where reliable file exchange depends on both network setup and partner-specific validation.

- Onboarded and stabilized SFTP-based file exchange with banks, payroll offices, and external partners.
- Worked through network-level integration details such as VPNs, allowlisted IPs, credentials, partner validation, and operational handover.
- Provisioned connectivity and supporting infrastructure with infrastructure-as-code according to security and operational requirements.
- Reduced the risk of silent data loss, failed transfers, and manual troubleshooting in partner integrations.

#### 2023: CARO / Credit Card Statement Activation Flows

Codabox needed to onboard a new credit-card statement source provider while the team was moving new development toward a Go-first implementation model.

- Helped migrate the implementation endpoint by endpoint from Java to Go while keeping both systems operational in production.
- Supported the new source-provider onboarding as part of the migration path.
- Helped combine business delivery and modernization instead of treating them as separate tracks.

#### 2021-2022: Consent And Mandate Signing Platform

Codabox needed a digital mandate signing flow while onboarding a new source bank, replacing a process that still depended largely on paper mandates.

- Helped design and implement the consent and mandate signing flow for clients of accountants.
- Integrated a third-party digital signing provider with existing Codabox systems.
- Supported fully digital processing for both sharing mandates.
- The resulting production flow was later adopted by most integrated banks and remains in use.

#### 2018-2020: Faster CODA Processing

Codabox needed to deliver bank-sourced CODA files[^coda] to customers before the start of the working day, but intermediate batch processing limited throughput.

- Reworked batch-processing steps so file processing could run in parallel.
- Increased throughput and helped ensure customers received their files before 8h00.

#### Ongoing: MyCodabox And Support Visibility

Codabox needed customer-facing and support-facing tools that made activation, mandate, subscription, and delivery states visible across operational workflows.

- Contributed to [MyCodabox](https://www.mycodabox.com/), the main portal accountants use to manage mandates and subscriptions.
- Worked on MyConsent, an onboarding tool for accountants' clients to activate integrations such as credit card statements according to [PCI](https://www.pcisecuritystandards.org/standards/pci-dss/) guidelines.
- Did the groundwork for an [Electron](https://www.electronjs.org/)-based desktop delivery client where local customer workflows required a dedicated application.
- Built and improved internal support tooling, including Django-admin-based and React-based interfaces.
- Added visibility for activation, registration, reconnect, reporting, and failure states across customer-facing and support-facing flows.

#### Ongoing: Cloud, CI, And Security Modernization

The team needed cloud infrastructure, CI, and security practices that kept services deployable and auditable while the platform evolved across GCP and AWS.

- Worked in a DevOps model where the team runs and manages its own infrastructure.
- Managed infrastructure through infrastructure-as-code, mostly with Terraform.
- Worked mostly on GCP-based systems before leading the team's transition toward AWS.
- Selected appropriate cloud technologies, from VMs and Kubernetes deployments to serverless runtimes such as GCP Cloud Run and AWS Lambda.
- Managed and improved CI pipelines across CircleCI, GitHub Actions, and GitLab CI.
- Kept production services deployable, auditable, and aligned with security expectations.

### [Unleashed](https://unleashed.be) / [Mobile Vikings](https://mobilevikings.be)

**Software Engineer / Analyst**
July 2016 - July 2018

Unleashed was the digital product and engineering organization behind [Mobile Vikings](https://mobilevikings.be), [Jim Mobile](https://jimmobile.be), and Stievie.[^stievie]
I worked across full-stack development and analysis roles for customer-facing telecom and media products.

Selected projects and responsibilities:

#### 2017-2018: Marketing Automation Squad

Mobile Vikings, Jim Mobile, and Stievie needed shared marketing automation capabilities across customer-facing telecom and media products.

- Worked on cross-brand full-stack development across the three brands.
- Helped analyze and shape backend REST API architecture for marketing automation flows.

#### 2016-2017: Mobile Vikings Get And Retain Squad

Mobile Vikings needed to adapt customer registration and retention flows while Belgian telecom regulation and backend platform changes reshaped core customer journeys.

- Worked on prepaid registration flows after Belgian regulation required prepaid SIM cards to be linked to verified identity.
- Built and maintained full-stack marketing campaign features for Mobile Vikings.
- Helped analyze marketing backend changes for a full mobile virtual network operator (MVNO) migration and customer SIM-swap migration.

### [SoundTalks](https://www.soundtalks.com/en/)

**Research Engineer**
September 2012 - July 2016

SoundTalks is a KU Leuven spin-off developing acoustic monitoring technology for livestock health.
I joined as the first employee, working in a small early-stage company where research, software development, field deployment, customer contact, and commercial support were closely connected.

Selected responsibilities and achievements:

SoundTalks needed to turn acoustic livestock-health research into an operational product in a small early-stage company.

- Led research and development work for the Pig Cough Monitor algorithm and supporting software.
- Handled on-site installations, maintenance, data collection, and customer-facing technical follow-up.
- Managed data storage and database work needed for algorithm development, validation, and product operation.
- Developed software practices around version control, build processes, and release management.
- Represented the company at technical, academic, and commercial conferences with partners and customers.

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

## Education

### M.Sc. Engineering: Electrical Engineering, KU Leuven

2008 - 2010

- Specialization in multimedia and signal processing.
- Graduated cum laude.
- Thesis: see [Selected Academic Work](cv#Selected Academic Work).

### B.Sc. Engineering: Electrical Engineering, KU Leuven

2004 - 2008

- Specialization in industrial management.

## Selected Academic Work

### Thesis

- M.Sc. thesis, with Hans Van Herck: ["Integrated Stereo Acoustic Echo Cancellation and Speech Coding for Tele-/videoconferencing Applications"](https://mhemeryck.github.io/cv/Hemeryck_Martijn_masterproef_2009-2010.pdf), KU Leuven, 2010.

### Publications

- Dries Berckmans, Martijn Hemeryck, Daniel Berckmans, Erik Vranken, and Toon van Waterschoot: "Animal Sound...Talks! Real-time Sound Analysis for Health Monitoring in Livestock", Animal Environment and Welfare, 2015.
- Ilaria Fontana, Emanuela Tullo, Martijn Hemeryck, and Marcella Guarino: "Using Broiler Sound Frequency to Model Weight", Animal Environment and Welfare, 2015.
- Martijn Hemeryck, Dries Berckmans, Erik Vranken, Emanuela Tullo, Ilaria Fontana, Marcella Guarino, and Toon van Waterschoot: "The Pig Cough Monitor in the EU-PLF project: results and multimodal data analysis", Precision Livestock Farming '15, 2015.
- Martijn Hemeryck and Dries Berckmans: "Pig cough monitoring in the EU-PLF project: first results", Precision livestock farming applications, 2014.
- Marko Topalovic, Vasileios Exadaktylos, Anneleen Peeters, Johan Coolen, Walter Dewever, Martijn Hemeryck, Pieter Slagmolen, Karl Janssens, Daniel Berckmans, Marc Decramer, and Wim Janssens: ["Computer quantification of airway collapse on forced expiration to predict the presence of emphysema"](http://dx.doi.org/10.1186/1465-9921-14-131), Respiratory Research, 2013.

### Presentations And Posters

- "SoundTalks and the Pig Cough Monitor", Flanders Agrotronics, Leuven, Belgium, 2015.
- "Model based image analysis for robust quantification of COPD on thorax CT", poster, Paleis der Academiën, Brussels, Belgium, 2011.
- "Model based liver segmentation for surgery planning", oral presentation, Jesús Usón Minimally Invasive Surgery Centre, Cáceres, Spain, 2011.

## Selected Projects

- Personal home automation system: Designed, built, and maintain a whole-home automation setup integrating wired controls, UniPi hardware, Modbus, DALI, MQTT, Home Assistant, and custom Go/Python services.
  - [nest](https://github.com/mhemeryck/nest): Go-based home automation codebase for consolidating personal automation services.
  - [modbridge](https://github.com/mhemeryck/modbridge): Go service for polling Modbus and Modbus TCP devices and publishing updates over MQTT.
  - [evok2mqtt](https://github.com/mhemeryck/evok2mqtt): Python bridge that listens to the UniPi EVOK API over websockets and publishes device events to MQTT.
  - [covers](https://github.com/mhemeryck/covers): MQTT-based home automation helper for mapping button input events to matching cover controls.
  - [hausmaus](https://github.com/mhemeryck/hausmaus): Rust-based home automation tooling.
- [iac](https://github.com/mhemeryck/iac): Terraform and Kubernetes setup for self-hosted services, including k3s, TLS automation, and service manifests.

## Skills

- Selected experience includes backend and systems work with Python, Go, Rust, C, C++, and shell scripting.
- Web and API development with Django, Flask, FastAPI, REST / RPC APIs, HTML, CSS, JavaScript, HTMX and Vue.js.
- Cloud and infrastructure work across AWS, GCP, Terraform, Pulumi, Kubernetes, Docker, and AWS CDK.
- Data and integration work involving PostgreSQL, SQL, Pub/Sub, SFTP, MQTT, Modbus, and DALI.
- Delivery and operations tooling including Git, CI/CD, Linux, Nix, Nushell, Vim, Helix, and LaTeX.

## Certifications

- [AWS Certified Solutions Architect - Associate](https://www.credly.com/badges/9cf26a0f-3ac9-475e-b679-493e624ae948/public_url), April 2026.
- [Google Cloud Associate Cloud Engineer](https://www.credly.com/badges/21b41ca0-4671-4ad6-9da9-0d96cb74e5d9/public_url), February 2024.
- [LFS258: Kubernetes Fundamentals](https://www.credly.com/badges/e8cc322c-c59c-4f0c-a7bd-6348c48d7b10/public_url), July 2020.

## Languages

- Dutch: native.
- English: professional working proficiency.
- French: intermediate working proficiency.
- German: basic proficiency.
- Japanese: basic proficiency.

## Interests

- Endurance training, especially running and indoor rowing, with a focus on long-term consistency.
- Personal engineering projects around home automation, document handling, and self-hosted infrastructure.
- Technical writing and learning, including systems design, cloud architecture, Nix/NixOS, and Go.
- Science and physics, through books, podcasts, and general curiosity.
- Music and culture, with a particular interest in electronic music.

## Links

- Location: [Tongeren-Borgloon, Belgium](geo:50.7865,5.4174)
- GitHub: [mhemeryck](https://github.com/mhemeryck)
- LinkedIn: [martijn-hemeryck](https://linkedin.com/in/martijn-hemeryck-67896245)
- Blog: [Martyn's musings](https://mhemeryck.github.io/posts/)

[^peppol]: [PEPPOL](https://peppol.org/) is the European e-invoicing network.
[^open-banking]: Open banking in this context builds on the [Payment Services Directive](https://en.wikipedia.org/wiki/Payment_Services_Directive).
[^coda]: [CODA](https://febelfin.be/en/themes/digitalization-innovation/regulations/a-coda-file-what-is-it-and-what-can-you-use-it-for), or "geCOdeerd DAgafschrift", is a coded bank statement file type used in Belgium.
[^stievie]: Stievie was a Belgian online streaming platform and predecessor to [VTM GO](https://www.vtmgo.be/).
