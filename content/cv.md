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

Engineer with an electrical engineering background, originally specialized in embedded software and digital signal processing.

Over time I branched into broader backend, cloud, infrastructure, and full-stack engineering.
I focus on product-facing platforms where technical design, operational reliability, and domain understanding all matter.

I like to analyze systems, take them apart, design them, and build them up again.
I am a developer and maker at heart, with a practical drive to solve problems end to end.

## Experience

### [Codabox By Wolters Kluwer](https://codabox.com)

**Senior Software Engineer**
August 2018 - present

Codabox provides accounting-data feeds for accountants and bookkeepers.
The platform integrates with source providers such as banks, payroll offices, credit card providers, and e-invoicing solutions.[^peppol]
It handles both sourcing and delivery of accounting data, as well as the consent flows required to make those end-to-end data exchanges possible.
My work has moved across backend and frontend development, analysis, architecture, cloud infrastructure, and technical leadership on several of these systems.

Selected projects and achievements:

#### 2025-2026: Sourcery And CODA Domain Tooling

- Worked on a new solution for generating historical bank statements from open-banking data.[^open-banking]
- Helped steer the team toward a Go-first implementation model for new services.
- Built the monorepo foundation for multiple services, combining application code, infrastructure code, and CI pipelines in a single versioned context.
- Designed and built the serverless-first infrastructure foundation, using AWS Lambda as the main runtime platform for new services.
- Developed optimized CODA bank-statement parsing and generation code with minimal allocations and memory usage.
- Introduced LLM-assisted tooling and project context to make team workflows easier to navigate.

#### 2023-2025: Partner SFTP And Bank Connectivity

- Onboarded and stabilized file exchange with banks, social offices, and external partners.
- Worked directly on network-level integrations using SFTP, VPNs, allowlisted IPs, credentials, and partner-specific validation.
- Set up connectivity and supporting infrastructure with infrastructure-as-code according to security requirements and operational best practices.
- Helped prevent silent data loss, failed transfers, and manual troubleshooting.

#### 2023: CARO / Credit Card Statement Activation Flows

- CARO is Codabox's credit card statement offering to accountants.
- Our team inherited an initial Java implementation and wanted to migrate it toward a Go-based stack.
- At the same time, there was a business requirement to onboard an additional source provider.
- Helped set up an approach to migrate the implementation endpoint-by-endpoint from Java to Go while keeping both systems operational in production.
- Helped fulfill the extra source provider requirement during the migration instead of treating modernization and delivery as separate tracks.

#### 2021-2022: Consent And Mandate Signing Platform

- Clients of accountants need to consent that banks can share their data with Codabox and that Codabox can share that data with their accountant.
- Helped replace a largely paper-based mandate process with a digital signing flow during the onboarding of a new bank.
- Integrated a third-party digital signing provider with the existing Codabox systems to support a fully digital process for both mandates.
- Built the solution as a reusable production flow that most integrated banks later adopted, and that remains in use for digital mandate signing.

#### 2018-2020: Faster CODA Processing

- The core Codabox system had issues delivering sourced CODA files from banks to customers on time.
- Reworked the intermediate batch-processing steps so file processing could run in parallel.
- Increased overall throughput and helped ensure customers received their files before 8h00 in the morning.

#### Ongoing: MyCodabox And Support Visibility

- Worked beyond backend and infrastructure on customer-facing portals and internal support tooling.
- Contributed to [MyCodabox](https://www.mycodabox.com/), the main portal accountants use to manage mandates and subscriptions.
- Worked on MyConsent, an onboarding tool for accountants' clients to safely activate integrations such as credit card statements according to [PCI](https://www.pcisecuritystandards.org/standards/pci-dss/) guidelines.
- Did the groundwork for an [Electron](https://www.electronjs.org/)-based desktop delivery client where local customer workflows required a dedicated application.
- Built and improved internal support tooling, including Django-admin-based and React-based interfaces.
- Added visibility for activation, registration, reconnect, CARO, reporting, and failure states across customer-facing and support-facing flows.

#### Ongoing: Cloud, CI, And Security Modernization

- Work in a DevOps model where the team runs and manages its own infrastructure.
- Manage infrastructure through infrastructure-as-code, mostly with Terraform.
- Worked mostly on GCP-based systems before leading the team's transition toward AWS.
- Bring hands-on experience selecting appropriate cloud technologies, from VMs and Kubernetes deployments to serverless runtimes such as GCP Cloud Run and AWS Lambda.
- Manage and improve CI pipelines across CircleCI, GitHub Actions, and GitLab CI.
- Keep production services always deployable, auditable, and aligned with security expectations.

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
- Developed software development practices around version control, build processes, and release management.
- Represented the company at technical, academic, and commercial conferences, including direct interactions with potential partners and customers.

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

- M.Sc. thesis, with Hans Van Herck: ["Integrated Stereo Acoustic Echo Cancellation and Speech Coding for Tele-/videoconferencing Applications"](/cv/Hemeryck_Martijn_masterproef_2009-2010.pdf), KU Leuven, 2010.

### Publications

- Dries Berckmans, Martijn Hemeryck, Daniel Berckmans, Erik Vranken, and Toon van Waterschoot: "Animal Sound...Talks! Real-time Sound Analysis for Health Monitoring in Livestock", Animal Environment and Welfare, 2015.
- Ilaria Fontana, Emanuela Tullo, Martijn Hemeryck, and Marcella Guarino: "Using Broiler Sound Frequency to Model Weight", Animal Environment and Welfare, 2015.
- Martijn Hemeryck, Dries Berckmans, Erik Vranken, Emanuela Tullo, Ilaria Fontana, Marcella Guarino, and Toon van Waterschoot: ["The Pig Cough Monitor in the EU-PLF project: results and multimodal data analysis"](http://www.eu-plf.eu/index.php/events/event/ec-plf-2015/), Precision Livestock Farming '15, 2015.
- Martijn Hemeryck and Dries Berckmans: ["Pig cough monitoring in the EU-PLF project: first results"](http://old.eaap.org/Previous_Annual_Meetings/2014Copenhagen/Papers/Published/S11_04.pdf), Precision livestock farming applications, 2014.
- Marko Topalovic, Vasileios Exadaktylos, Anneleen Peeters, Johan Coolen, Walter Dewever, Martijn Hemeryck, Pieter Slagmolen, Karl Janssens, Daniel Berckmans, Marc Decramer, and Wim Janssens: ["Computer quantification of airway collapse on forced expiration to predict the presence of emphysema"](http://dx.doi.org/10.1186/1465-9921-14-131), Respiratory Research, 2013.

### Presentations And Posters

- "SoundTalks and the Pig Cough Monitor", Flanders Agrotronics, Leuven, Belgium, 2015.
- "Model based image analysis for robust quantification of COPD on thorax CT", poster, Paleis der Academiën, Brussels, Belgium, 2011.
- "Model based liver segmentation for surgery planning", oral presentation, Jesús Usón Minimally Invasive Surgery Centre, Cáceres, Spain, 2011.

## Selected Projects

- [Personal home automation system](/tags/home-automation/): Designed, built, and maintain a whole-home automation setup integrating wired controls, UniPi hardware, Modbus, DALI, MQTT, Home Assistant, and custom Go/Python services.
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

[^peppol]: [PEPPOL](https://peppol.org/) is the European e-invoicing network.
[^open-banking]: Open banking in this context builds on the [Payment Services Directive](https://en.wikipedia.org/wiki/Payment_Services_Directive).
[^stievie]: Stievie was a Belgian online streaming platform and predecessor to [VTM GO](https://www.vtmgo.be/).
