# ITIL 5 Foundation — knowledge reference

Consolidated from two study guides in `C:\dev\Reference\mindsetup\books\`:

- **01_ITIL-5-Foundation-Guidebook.pdf** — instructor version. Everything below, plus the
  qualification scheme, transition pathways, and exam logistics sections.
- **02_ITIL-5-Foundation-Student_Guidebook.pdf** — student version. Same core content
  organized as Modules 1–7; adds utility/warranty, XLAs, relationship models, sustainability.

**Provenance (label it when teaching):** these are third-party study guides (author "James",
Felixent, 2026), synthesized from PeopleCert announcements and industry blogs accessed
February 2026 — not official PeopleCert publications. ITIL Version 5 released early 2026;
for authoritative claims cite peoplecert.org directly. The "Value Equation" appears only as
an image in both PDFs (formula not extractable); teach it conceptually as below.

## What ITIL 5 is

ITIL Version 5 (released early 2026) unifies digital **product** development and **service**
management into one framework, aimed at Industry 5.0: human–technology collaboration,
systemic resilience, environmental sustainability. Composition: ~40% carried from ITIL 4,
36% new material, 24% modified. It positions itself as the "operating system" of a modern
org — the governance layer that lets Agile, DevOps, Lean, and PRINCE2 work together.

| Characteristic | ITIL v3 | ITIL 4 | ITIL 5 |
|---|---|---|---|
| Primary focus | Processes & service lifecycle | Value co-creation & practices | Digital product & AI management |
| Core model | Service Lifecycle (5 stages) | Service Value System (SVS) | Unified Product & Service Lifecycle |
| Operational approach | Linear, rigid | Holistic, flexible | Adaptive, complexity-ready, AI-ready |
| Customer interface | Service level delivery | Co-creation of value | Total Digital Experience (customer + employee) |
| Technology role | Infrastructure support | Business enabler | AI-native foundation & automation |
| Governance style | Centralized bureaucracy | Integrated governance | Guided decision-making & AI ethics |

## Key terms

- **Product**: a configuration of an organization's resources designed to offer value.
- **Service**: the means of enabling value co-creation by facilitating outcomes the customer
  wants, without the customer managing the specific costs and risks.
- **Digital product / digital service**: same pair, built on digital technology. Teaching
  example: the bank's mobile app is the product (the engine); a secure instant transaction
  at midnight is the service (the trip).
- **Value**: not a package delivered — the *perceived* benefit, usefulness, and importance
  realized through interaction. The Value Equation: a service is valuable only when its
  positive effects (outcomes, removed costs/risks) outweigh its negative ones (imposed
  costs/risks). Value is subjective and stakeholder-dependent.
- **Utility**: what the service does — fitness for purpose. Must support performance or
  remove constraints.
- **Warranty**: how the service performs — fitness for use: availability, capacity, security,
  continuity. In v5, warranty assurance is increasingly automated via SRE and AI-driven
  observability.
- **Total Experience (TX)**: Customer Experience + Employee Experience, designed with
  human-centered design. **XLAs** (Experience Level Agreements) evolve beyond SLAs to
  measure qualitative sentiment and journey seamlessness.
- **Transformation vs BAU**: transformation = sustainable, non-linear shifts in operating
  model (people + process + technology); distinguished from business-as-usual.

## Stakeholders, offerings, relationships

Three customer-side personas: **Sponsor** (authorizes budget; cares about ROI),
**Customer** (defines requirements, accountable for outcomes), **User** (day-to-day use;
cares about UX and reliability).

Service offerings combine three components: **transfer of goods** (ownership moves — a
corporate laptop), **access to resources** (right to use for a period — SaaS, 5G), and
**service actions** (provider performs work — service desk, password resets).

Three relationship models, by depth of integration: **Basic** (standard, independent),
**Cooperative** (coordinated activities), **Collaborative** (one team, shared goals,
integrated value streams). The **Service Journey** maps end-to-end touchpoints to find
friction. Core insight: a technically perfect product creates *no* value if the consumer
can't use it ("value lock") — hence collaborative onboarding and real-time feedback loops.

## The four dimensions (+ PESTLE)

Every service-management activity must balance all four — excellence in one can't cover a
deficiency in another:

1. **Organizations & People** — roles, structure, culture; in v5, human–AI collaboration.
2. **Information & Technology** — knowledge, data, platforms; explicitly AI, cloud,
   microservices.
3. **Partners & Suppliers** — multi-party vendor ecosystems.
4. **Value Streams & Processes** — workflow orchestration; VSM and end-to-end flow.

External factors via **PESTLE**: Political, Economic, Social, Technological, Legal
(incl. AI ethics regulation), Environmental (sustainability, e-waste). A change in any
external factor ripples across all four dimensions.

## The ITIL Value System

(Renamed from ITIL 4's SVS.) Transforms inputs — Opportunity and Demand — into Value.
Five components:

1. **Guiding Principles** — enduring compass (below).
2. **Governance** — direct and control via the Evaluate–Direct–Monitor (EDM) cycle.
3. **Service Value Chain** — the operating model of key activities responding to demand.
4. **Management Practices** — 34 practices, now grouped in specialization clusters.
5. **Continual Improvement** — recurring at all levels.

### Seven guiding principles (v5 framing)

1. **Focus on Value** — every activity links to stakeholder value.
2. **Start Where You Are** — no rip-and-replace; observe directly (Gemba walks).
3. **Progress Iteratively with Feedback** — small chunks, rapid adjustment.
4. **Collaborate and Promote Visibility** — kill silos; Kanban-style visible work.
5. **Think and Work Holistically** — nothing operates in isolation.
6. **Keep It Simple and Practical** — design for the happy path; cut non-value steps.
7. **Optimize and Automate** — optimize *before* automating, or you amplify inefficiency;
   reserve humans for genuine judgment.

## Product and Service Lifecycle Model (PSLM)

The headline structural change: one unified eight-activity lifecycle replacing the linear
service lifecycle. Activities combine flexibly into value streams; digital solutions are
never "finished."

| Activity | Purpose | Key outputs |
|---|---|---|
| Discover | Align roadmaps and offerings with market needs and strategy | Feasibility studies, updated roadmaps |
| Design | Plan solutions via prototypes and specs (functionality + UX) | Service design packages, technical blueprints |
| Acquire | Secure resources — buy, build, or hire | Acquired assets, service components |
| Build | Code, configure, assemble, test | Built and tested digital products |
| Transition | Introduce into live environments safely | Operational products ready for use |
| Operate | Monitor and maintain for reliability | Performance records, health monitoring data |
| Deliver | Manage access and fulfillment requests | Services delivered; SLA/XLA reports |
| Support | Resolve incidents and problems, restore operation | Restored operations, root-cause analyses |

Discover→Build lean product-side; Deliver/Support lean service-side; Transition and
Operate are the bridge.

## Value stream mapping (Lean in v5)

A value stream = the actual combination of activities answering one type of demand
(process = the idealized model; value stream = messy reality). VSM method: map the
**as-is** at the Gemba (where work happens, not the org chart's story) → identify waste
(bottlenecks, wait states, duplicate entry, redundant approvals) → design the **to-be** →
benchmark with Cycle Time, Lead Time, First Pass Yield.

## AI-native governance and the 6C model

Governance shifts from central control to guided decision-making, with AI ethics,
transparency, accountability, and compliance embedded from the start. The **6C AI
Capability Model** identifies which AI capabilities a value stream needs:

| Capability | Description | Strategic application |
|---|---|---|
| Creation | Generating content, code, designs | Accelerating development and creative tasks |
| Curation | Managing/filtering vast datasets | Knowledge management, retrieval |
| Clarification | Explaining complex or ambiguous data | Incident/problem diagnostics |
| Cognition | High-level reasoning, pattern recognition | Predictive analytics, demand/risk forecasting |
| Communication | Natural-language interaction | AI support agents, virtual assistants |
| Coordination | Orchestrating across distributed systems | Automating multi-team workflows and releases |

## 34 practices, three specialization clusters

Practices are the "how" — applied complexity-ready, not as rigid procedure. The Practice
Manager designation requires Foundation + Transformation + one cluster:

1. **MSF — Monitor, Support and Fulfil** (operational stability): Service Desk, Incident
   Mgmt, Problem Mgmt, Service Request Mgmt, Monitoring & Event Mgmt.
2. **PIC — Plan, Implement and Control** (change/asset governance): Change Enablement,
   Deployment Mgmt, Release Mgmt, Service Configuration Mgmt, IT Asset Mgmt.
3. **CAI — Collaborate, Assure and Improve** (strategic quality/relationships):
   Relationship Mgmt, Supplier Mgmt, Service Level Mgmt, Continual Improvement,
   Information Security Mgmt.

## Framework integration

- **Agile/DevOps**: the "ITIL vs Agile" debate is resolved by native integration — change
  management plugs into CI/CD; standard low-risk changes pre-authorized for automated
  release; normal changes via guided decision-making, not approval layers.
- **Lean**: embedded via VSM and non-value-step elimination.
- **PRINCE2**: compatible, especially across Acquire/Build/Transition — project methods
  deliver the implementation; ITIL provides the operating model around it.

## Qualification scheme (2026) — instructor guidebook only

| Designation | Required modules | Career target |
|---|---|---|
| ITIL Foundation | ITIL 5 Foundation exam | All digital/IT professionals |
| Practice Manager (PM) | Foundation + Transformation + one cluster (MSF/PIC/CAI) | Hands-on practitioners |
| Managing Professional (MP) | Foundation + Transformation + Product + Service + Experience | Mid/senior product & delivery leaders |
| Strategic Leader (SL) | Foundation + Transformation + Strategy | Senior leaders, digital strategists |
| ITIL Master | PM + MP + SL completed | Holistic mastery |

The **Transformation** module is the universal core for all advanced designations; its
credit applies across streams. **AI Governance** is currently the only official extension
module (former ITIL 4 extensions absorbed into core).

Transition pathways: ITIL 4 Foundation holders need not retake Foundation (optional
one-day Bridge course from Feb 26, 2026); ITIL 4 PM/SL upgrade via the Transformation
module alone; ITIL 4 MP/Master and v3 Expert/Master take the Managing Professional
Transition (MPT) course. v3 Foundation/Intermediate no longer count as prerequisites —
retake Foundation.

## Exam format (Foundation)

Multiple choice, 40 questions, pass at 65% (26 correct), 60 minutes, closed book,
scenario-based, initially English. Training not mandatory but recommended (36% of
content is new). Official eBooks and mocks via PeopleCert ATOs.

## Teaching notes for pacBOT

- Use the **student guidebook's Module 1–7 structure** as the course skeleton; pull the
  qualification/transition/exam material from the instructor guidebook for the "what's
  next" close of a course.
- This is NEUTRAL-voice territory by default (professional certification audience), but
  the arcade mapping works if the room is frens: guiding principles = house rules,
  value streams = level routes, the service desk = the attendant's counter.
- Natural bridges to arcade curriculum: "Optimize and Automate" pairs with the
  don't-trust-verify ethos; AI-native governance pairs with the Knowledge Engine work;
  utility vs warranty maps cleanly onto "what a wallet does" vs "whether it keeps working
  when you need it."
