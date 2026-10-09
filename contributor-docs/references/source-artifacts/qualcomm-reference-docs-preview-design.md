---
page_type: reference
---

# Qualcomm Reference Docs Preview Design

This reference defines the complete interaction design for the Qualcomm
reference-docs preview, refinement, run authorization, staged generation,
output acceptance, destination write, and handoff workflow. It is
implementation input for `DEVD-1568` and later build work. It does not
implement the app.

The design is based on:

- the parent outcome and acceptance boundary in `DEVD-1554`;
- the shipped implementation plan in the `devdocsorg/docs-first` source
  repository at revision
  `637a5bc400f7abb104bf98d07b92e737dc098157`;
- the user, accessibility, trust, and scale research in `DEVD-1565`; and
- the preview-app build boundary in `DEVD-1561`.

## Repository Authority

`devdocsorg/docs-first` is the source repository and the authority for page
types, ontology, contribution rules, review rules, and documentation
architecture. The target-facing rules in this artifact and the corrected
implementation plan are derived from exact protected source revision
`637a5bc400f7abb104bf98d07b92e737dc098157`.

`reference-docs-spec` is the distinct target repository under Jackson's GitHub
account. It consumes those source-repository rules and owns its
product-specific workflow, skills, tutorials, references, verification
contracts, and architecture. It is not an alias or replacement for
`devdocsorg/docs-first`. Delivery evidence records the target repository's own
immutable revision separately from the exact source-repository revision above.

## Product Decision

The preview is a snapshot-bound representative review artifact, not a small
execution run and not a promise that uninspected files will produce the same
output. The interface keeps these actions visibly and technically distinct:

1. authorize read access to a source;
2. freeze a source revision;
3. inventory and classify the repository;
4. generate proposals only for representative files;
5. inspect and refine a representative proposal revision;
6. save selected preferences as durable inputs;
7. authorize staged generation for an exact input manifest;
8. generate, truth-audit, and render broader outputs without destination
   writes;
9. inspect the exact generated output set and preservation ledger;
10. accept additive outputs and, separately, any correction subset;
11. acquire separate destination write authority; and
12. write only the accepted output manifest.

These decisions use four different product objects:

- A **representative proposal revision** contains generated output only for the
  selected representative files. Its counts and renders are review evidence,
  not estimates or implicit approval for other files.
- A **broad run authorization** binds a frozen source SHA, complete inventory,
  exact input file manifest, exclusions, documentation profiles, reviewed
  rules, durable preferences, destination identity, and actor. It permits
  isolated generation and audit only. It does not assert or approve per-file
  additions, corrections, truth results, or rendered routes that do not exist
  yet.
- A **generated output set** contains the exact per-file additions, correction
  proposals, truth results, rendered routes, failures, exclusions, and
  preservation-ledger revision produced by the authorized staging run.
- An **output acceptance record** binds an inspected generated output set to
  the exact additions and separately selected corrections that may be written
  to the destination.

A file whose output has already been generated and inspected can proceed
directly to output acceptance. Profile and repository choices authorize staged
generation from their exact input manifests. They never imply acceptance of
unseen output.

When staged generation finds a false or stale existing comment in a
non-representative file, the proposed correction is quarantined from automatic
writes. The UI shows the original comment, location, evidence, proposed
replacement, and affected generated output. The source repository always
remains unchanged. The destination copy retains the original wording unless
that correction is separately selected and accepted. Excluding it is a recorded
decision, not a silent drop; accepting it later creates a new correction-only
acceptance record and write manifest.

The source repository remains read-only throughout. For Qualcomm source
repositories, the destination must have a different repository identity. A
branch in the source repository is not an allowed destination.

The global safety label is always visible:

> Preview only | Source read-only | No commits or branches will be created

The label uses text and an icon, not color alone. It remains present through
setup, inventory, representative proposal review, refinement, and run
authorization. During staged generation it changes to:

> Authorized staging run | Source read-only | No destination writes

Only after output acceptance and destination authorization does it change to:

> Approved destination run | Source remains read-only

## Users And Decisions

| User | Decision | Required visible evidence |
| --- | --- | --- |
| Repository maintainer | Is the sample representative enough to authorize staged generation, and is the generated output acceptable to write? | Frozen source SHA, complete inventory, exclusions, sample rationale, exact input manifest, generated output set, preservation ledger, exact write manifest |
| Code or API reviewer | Is each proposed statement true and idiomatic? | Existing comment, symbol signature, implementation, tests or docs, framework rule, truth disposition |
| Documentation reviewer | Is every output reachable and useful in rendered docs? | Build state, affected route, sidebar placement, links, before and after render |
| Repository administrator | Are access and writes bounded correctly? | Acting identity, installation, selected repositories, effective permissions, retention, source-safety proof |
| Delivery operator | Can staging and writing be recovered without widening scope? | Proposal, run-authorization, generated-output, output-acceptance, and write IDs; per-file states; cancel boundary; retry manifest; destination commit |

## Design Language

This is a quiet operational tool for repeated repository review. It uses the
existing Qualcomm or DevDocs product shell and component library at
implementation time.

- Prefer dense lists, tables, inspectors, split panes, and drawers over
  decorative cards.
- Keep page sections unframed. Use cards only for repeated file results,
  dialogs, and genuinely bounded tools.
- Use familiar icons with accessible names for copy, filter, expand, close,
  retry, cancel, history, and external-link actions.
- Use an icon and text for accepted, corrected, excluded, unresolved, stale,
  warning, and failed states.
- Use segmented controls for diff mode and output mode, checkboxes for file
  selection, toggles for binary filters, menus for option sets, and text
  buttons only for explicit commands.
- Keep control and panel dimensions stable while content loads or statuses
  change.
- Use no marketing hero, illustration, or atmospheric decoration. The first
  viewport is the working surface.

## Core Records

The interface treats the following records as immutable or revisioned. Names
are product labels, not required implementation type names.

| Record | Visible identity and content |
| --- | --- |
| Source snapshot | Repository ID, URL, ref, resolved commit SHA, visibility, acting user, installation, effective read permission |
| Inventory revision | Source snapshot ID, traversal completeness, profile counts, classifications, exclusion evidence, manual overrides |
| Documentation profile | Language or file kind, framework, source root, config evidence, comment convention |
| Representative selection | Profile, selected file, score or rationale, replacement history |
| Representative proposal revision | Source snapshot, inventory revision, representative files only, changed files, evidence, truth results, rendered impact, preference inputs, preservation-ledger revision |
| Preference ledger entry | Key, value, scope, temporary or durable status, source conversation, actor, proposal revision, revocation state |
| Existing-comment preservation ledger | Immutable ledger revision, source snapshot, one entry per discovered existing comment, source location and hash, evidence links, disposition events, actor, related proposal or output IDs |
| Broad run authorization | Representative proposal, source SHA, inventory revision, file or profile or repository scope, exact input manifest and exclusions, reviewed rules, durable preferences, destination identity, actor, policy checks, timestamp |
| Generated output set | Run authorization, exact output revision and hashes, per-file additions, correction proposals, truth results, rendered routes, preservation-ledger revision, failures, exclusions |
| Output acceptance record | Generated output set, preservation-ledger revision, exact accepted additions, separately accepted corrections, explicit exclusions, write-manifest hash, destination identity, actor, policy checks, timestamp |
| Staging run | Run-authorization ID, idempotency key, per-file analysis, generation, audit, render, cancellation and retry state; no destination commit |
| Destination write run | Output-acceptance ID, idempotency key, immutable accepted manifest, exact completed, active, failed or rolled-back, and unstarted output partitions, cancellation request and result, configured commit or rollback boundary, destination commits, reduced resume manifest, branch or PR, source-safety proof |
| Artifact lifecycle record | Artifact class, retention period, deletion request and state, legal-hold status and ID, held scope, authority, effective time, release or review path, and related audit event IDs |

Every screen that can change the user's decision shows the current source SHA
and the applicable proposal, run-authorization, generated-output, or
output-acceptance revision. Truncated SHAs retain a full accessible name and
copy action.

For scope and traceability, a **file-type scope** means one documentation
profile. A profile includes the file type plus its language, framework, source
root, and configuration evidence. If one file type uses conflicting frameworks
or source-root rules, the inventory creates separate profiles. This preserves
the requested one-file-type authorization and acceptance choices while
preventing one extension-level choice from hiding materially different
conventions.

### Preservation Ledger Contract

The preservation ledger is immutable and append-only by revision. It is not a
summary reconstructed from the final diff. Analysis creates one entry for every
existing source comment encountered in an authorized file, including comments
that produce no proposed change.

Each entry contains:

- stable comment and ledger-entry IDs;
- source snapshot, file path, symbol or configuration key, line or span, and
  original text hash, with authorized access to the original text;
- evidence links used to understand the comment, including implementation,
  signature, tests, existing docs, and language or framework rule;
- a disposition event of `retained`, `incorporated`,
  `correction proposed`, or `excluded`, with reason, actor or agent, and
  related change ID;
- later review events that accept or exclude a correction without replacing
  the original discovery event; and
- links to the representative proposal, broad run authorization, generated
  output set, output acceptance, destination result, and completion handoff
  where applicable.

Per-file and aggregate views show total discovered comments and counts for each
disposition. Before broad authorization, representative files have complete
ledger entries and every other input file is visibly marked `Not yet analyzed`.
After staged analysis, the generated output set cannot enter output acceptance
until every analyzed input file has a settled ledger coverage state. A
correction proposal is always a separately reviewed subset. If it is excluded,
the original comment remains unchanged and the ledger records who excluded it,
why, and which generated output was withheld.

## Information Architecture

The desktop shell has four persistent regions:

1. **Context header:** source repository, ref, frozen SHA, destination, acting
   identity, and safety label.
2. **Workflow stepper:** Access, Inventory, Preview, Refine, Authorize,
   Generate, Accept, Write.
3. **Primary workspace:** the active task for the current step.
4. **Evidence inspector:** details for the selected file, change, preference,
   preservation entry, authorization, output acceptance, or run event.

The Preview and Refine steps use a stable three-pane arrangement at wide
desktop sizes:

```text
File and profile navigator | Diff or render workspace | Evidence or agent panel
```

The agent conversation never replaces the diff. It opens beside or over the
evidence inspector, and every content-changing response creates a proposal
revision that returns the user to an inspectable diff.

## End-To-End Flow

```text
[New preview]
      |
      v
[Validate URL, access, ref, destination policy]
      | error -------------------------------> [Repair setup]
      v
[Freeze source SHA and disclose private-content handling]
      |
      v
[Inventory and classify repository]
      | partial/truncated -------------------> [Retry or limit scope]
      v
[Select one representative file per documentation profile]
      | no viable sample --------------------> [Choose file or exclude profile]
      v
[Generate proposal revision and rendered projection]
      | file failure ------------------------> [Retry file or exclude]
      v
[Review representative additions, corrections, truth evidence, rendered impact]
      | ask/refine --------------------------> [Agent response]
      |                                         |
      |<------------ [New inspectable proposal revision]
      |
      v
[Optionally promote explicit preferences to durable ledger]
      |
      v
[Choose file, profile, or repository scope]
      | file output already inspected ------> [Review exact output acceptance]
      | stale/incomplete/rule unresolved ---> [Resolve blocking condition]
      v
[Review exact input manifest, exclusions, rules, and preferences]
      |
      v
[Authorize staged generation; no destination writes]
      v
[Analyze, generate, truth-audit, render, and complete preservation ledger]
      | cancel ------------------------------> [Cancelled boundary]
      | partial failure ---------------------> [Retry failed/unstarted files]
      v
[Review exact generated outputs and correction quarantine]
      | reject output -----------------------> [Exclude or regenerate output]
      | correction not accepted ------------> [Record exclusion; keep original]
      v
[Accept exact additions and separate correction subset]
      |
      v
[Acquire separate destination write authority]
      | denied/expired ----------------------> [Repair destination access]
      | stale source before write ----------> [Return to acceptance or preview]
      v
[Write accepted output manifest only]
      | cancel ---------------------------> [Cancel at configured boundary]
      |                                         |
      |<---------------- [Cancelled: commits and accepted remainder]
      | partial failure --------------------> [Retry accepted remainder]
      v
[Destination commit, branch, PR, docs build, ledger, and safety proof]
      |
      +--------------------------------------> [Return to preview]
```

## Preview And Run Authorization State Machine

```text
setup
  -> validating
  -> source_frozen
  -> inventory_running
  -> inventory_ready
  -> proposal_generating
  -> proposal_ready
  -> run_authorization_review
  -> broad_run_authorized

Any state before broad_run_authorized:
  -> stale_source
  -> authorization_required
  -> recoverable_error

proposal_ready:
  -> refinement_running
  -> proposal_ready(new revision)
  -> output_acceptance_review(file output already generated)

run_authorization_review:
  -> blocked_by_scope_condition
  -> broad_run_authorized(immutable inputs, rules, and destination identity)

Changing source, inventory rules, representative files, proposal content,
durable preferences, or destination after run authorization:
  -> run_authorization_invalidated
  -> proposal_ready or run_authorization_review
```

## Staged Generation, Output Acceptance, And Write State Machine

```text
broad_run_authorized
  -> queued
  -> analyzing
  -> generating
  -> auditing
  -> rendering
  -> generated_output_ready

auditing:
  -> correction_quarantined(false or stale existing comment)
  -> auditing

generated_output_ready
  -> output_acceptance_review
  -> output_accepted(exact additions and separate correction subset)
  -> destination_authorizing
  -> destination_write_queued
  -> writing_destination
  -> completed

queued through rendering:
  -> cancelling
  -> cancelled

analyzing through rendering:
  -> partially_failed
  -> retry_ready
  -> queued(reduced input retry manifest under same authorization)

output_acceptance_review:
  -> output_excluded
  -> correction_excluded(original remains unchanged)
  -> regenerated_output(new generated output revision)

destination_write_queued or writing_destination:
  -> destination_write_cancelling

destination_write_cancelling:
  active accepted outputs settle at the configured commit or rollback boundary
  no unstarted accepted output begins
  -> destination_write_cancelled

destination_write_cancelled:
  -> retry_ready
  -> destination_write_queued(reduced remaining accepted manifest under the
     same output-acceptance idempotency tuple)
  -> completed(cancelled disposition, exact retained commits, exact remainder)

writing_destination:
  -> partially_failed
  -> retry_ready
  -> writing_destination(reduced accepted write manifest)

Before first destination write:
  -> stale_source
  -> output_acceptance_invalidated

Any destination write or source-safety invariant failure:
  -> safety_halt
```

Staging retry never widens the authorized input scope. Write retry never
reopens completed writes or adds output that was not accepted. A changed input
manifest requires a new run authorization. A changed generated output set,
accepted correction subset, or destination requires a new output acceptance
record. An excluded correction can be accepted later only through a new
correction-only acceptance record and write manifest. Destination-write
cancellation does not mutate the output acceptance or its accepted manifest.
It records an immutable write-run checkpoint with exact completed, active, and
unstarted partitions; retained destination commits; the configured commit or
rollback boundary applied to active work; and the reduced remaining manifest
eligible for idempotent resume.

## Annotated Wireframes

The wireframes define hierarchy, control choice, persistent context, and
responsive behavior. They do not prescribe final visual tokens.

### W1: Source Setup

```text
+----------------------------------------------------------------------------+
| Reference docs preview                                      [User menu v]  |
| Preview only | Source read-only | No commits or branches will be created   |
+----------------------------------------------------------------------------+
| Access ---- Inventory ---- Preview ---- Refine ---- Authorize ---- Accept   |
+----------------------------------------------------------------------------+
| Start a preview                                                            |
|                                                                            |
| Source repository                                                          |
| [ https://github.com/qualcomm/example________________________ ] [Validate]  |
| Branch or ref                                                              |
| [ main_______________________________________________________ ]             |
|                                                                            |
| Destination for accepted work                                              |
| (o) Select later   ( ) Existing fork   ( ) Review repository               |
| [ Select destination repository_______________________________________ v ] |
| [ Review branch name___________________________________________________ ]  |
|                                                                            |
| Access summary                                                             |
| Source: Contents read | Metadata read     Destination: Not requested        |
| Acting as: Jackson via Qualcomm GitHub App installation                    |
| Private content: retained [policy value] [View data handling]              |
| Legal hold: {none or hold ID and scope}                         [View hold] |
|                                                                            |
| [Cancel]                                             [Inventory repository] |
+----------------------------------------------------------------------------+
```

Annotations:

1. `Validate` performs format, installation, repository, ref, visibility, and
   eligibility checks without starting inventory.
2. Destination selection is optional for representative preview but required
   before run authorization. A Qualcomm source repository cannot be selected as
   its own destination.
3. Private-repository data handling is disclosed before `Inventory repository`
   becomes available. The disclosure includes retention, deletion eligibility,
   and any legal hold that prevents deletion for a named artifact class.
4. Validation errors appear beneath the affected field and in an error summary
   linked to that field. Entered values remain intact.
5. Successful submission resolves the ref to a commit and moves focus to the
   frozen-source summary on W2.

### W2: Inventory And Representative Files

```text
+----------------------------------------------------------------------------+
| Preview only | Source read-only | qualcomm/example | main @ 9b42e18 [copy] |
| Destination: Not selected                           Inventory 3,842 / 3,842 |
+----------------------------------------------------------------------------+
| Access - [Inventory] - Preview - Refine - Authorize - Generate - Accept     |
+----------------------+-----------------------------------------------------+
| Profiles             | Repository inventory                                |
| [Search paths____]    | Complete | 3,842 files | 5 documentation profiles  |
| [x] Included  1,204   |                                                     |
| [x] Excluded  2,590   | Type/Profile  Included Excluded Unsupported Sample |
| [x] Unsupported  36   | C++/Doxygen       411      920       0       1      |
| [x] Unclassified 12   | Python/Google     233       71       0       1      |
|                      | YAML/config        127      205       0       1      |
| v C++ / Doxygen       | Other              0        0      36       -      |
|   src/api/client.cpp  |                                                     |
|   Representative     | Selected sample                                     |
| v Python / Google     | src/api/client.cpp                                  |
|   tools/build.py      | Public API | existing comments | tests found       |
|   Representative     | Rationale: highest evidence coverage in normal path |
|                      | [Choose another file] [View classification evidence]|
+----------------------+-----------------------------------------------------+
| Exclusions: generated 1,802 | vendored 531 | lock/minified 201 | other 56 |
| [Review exclusions]                    [Generate representative previews]   |
+----------------------------------------------------------------------------+
```

Annotations:

1. Inventory completeness is a named state: complete, partial, or truncated.
2. Counts never imply completeness when traversal failed or reached a provider
   limit.
3. Profiles combine language or file kind, framework, source root, and explicit
   repository configuration. Extension alone does not define a profile.
4. Exclusion rows expose the classification rule and evidence, including
   repository overrides. Manual inclusion is per run and explicit.
5. Each detected supported file type has at least one selected representative.
   Conflicting conventions create separate profiles and therefore additional
   representatives. A profile without a candidate shows an explicit reason.
   Replacing a sample does not change inventory classification.
6. Full-repository run authorization is unavailable until inventory and
   classification are complete.
7. Representative proposal counts apply only to the selected samples. W2 never
   predicts broad additions, corrections, truth results, preservation
   dispositions, or rendered routes for files that have not been analyzed.

### W3: Proposal Review

```text
+----------------------------------------------------------------------------+
| Preview only | qualcomm/example | main @ 9b42e18 | Proposal r4             |
| 5 samples only | 18 additions | 1 correction | 2 unresolved                |
+----------------------------------------------------------------------------+
| Inventory -- [Preview] -- Refine -- Authorize -- Generate -- Accept         |
+--------------------+-----------------------------------+-------------------+
| Files and profiles | [Unified|Side by side] [Code|Docs]| Truth evidence    |
| [Filter_______ v]  |                                   | Accepted           |
| [Search paths____] | src/api/client.cpp                | Symbol: Client::x |
|                    | @@ Client::connect               | Framework: Doxygen |
| v C++  1/1 reviewed| - // Connects the client.         |                   |
|   client.cpp       | + /** Connects to the configured | Evidence           |
|     3 additions    | +  * endpoint.                    | [signature]        |
|     1 correction   | +  * @param timeout ...          | [implementation]   |
| v Python  1/1      | +  * @return ...                 | [test]             |
|   build.py         | +  */                             | [existing docs]    |
| v YAML  1/1        |                                   |                   |
| ... 2 profiles     |                                   |                   |
|                    | [Previous change] [Next change]   | Idiom: passed      |
| Tabs               |                                   | Contradiction: none|
| [Additions 18]     | Existing comment                 | Disposition        |
| [Corrections 1]    | "Connects the client."            | [Reviewed]         |
| [Unresolved 2]     | Proposed correction is separate  |                   |
| [Preservation 14]  |                                   | Documentation      |
|                    |                                   | Purpose: present   |
|                    |                                   | Parameters: 1      |
|                    |                                   | Errors: 1          |
|                    |                                   | Return: Session    |
|                    |                                   | Example: allowed   |
+--------------------+-----------------------------------+-------------------+
| Existing comments: 14 | Retained 10 | Incorporated 3 | Correction proposed 1|
| [Open immutable preservation ledger for client.cpp]                       |
+----------------------------------------------------------------------------+
| [Mark file reviewed] [Ask agent] [Open preference ledger] [Review scope]   |
+----------------------------------------------------------------------------+
```

Annotations:

1. The file navigator is stable across code diff, rendered docs, additions,
   corrections, and unresolved queues.
2. Additions and corrections are separate tabs and filters. A correction shows
   original text, why it is false or stale, source evidence, and replacement.
3. Truth evidence is attached to the selected change, not summarized only at
   the file level.
4. Purpose, parameter, error, return, and example metadata is visible for the
   selected symbol. An included or omitted example names the governing rule.
5. `Needs human review` is not a passing state and blocks any scope containing
   that change.
6. The Docs mode shows build status, route, sidebar placement, links, and a
   before and after render when an existing page is available.
7. `Mark file reviewed` records review progress only. It is neither run
   authorization nor output acceptance.
8. The Preservation tab lists every existing comment found in the selected
   representative file, including comments retained without a proposed diff.
   Each row shows source location, original hash and authorized text, evidence,
   disposition, and related change. Counts link to the immutable ledger
   revision.

### W4: Agent Refinement And Preference Ledger

```text
+----------------------------------------------------------------------------+
| Proposal r4                                         [History] [Close panel] |
+--------------------------------------------+-------------------------------+
| Current diff remains visible               | Ask the reference-docs agent  |
|                                            | Scope [client.cpp_________ v] |
| src/api/client.cpp                         |                               |
| @@ Client::connect                         | You                           |
| + /** Connects to...                       | "Use shorter purpose lines."  |
|                                            |                               |
| Affected by draft preference               | Agent                         |
| Purpose sentence length: concise           | I can revise 3 comments in    |
| Scope: this preview                         | client.cpp. Evidence remains  |
|                                            | unchanged.                    |
| [View proposed revision r5]                |                               |
|                                            | [message draft_____________] |
|                                            | [Send]                        |
+--------------------------------------------+-------------------------------+
| Preference ledger                                                          |
| Preference       Value     Scope         Status       Source                |
| Purpose length   concise   client.cpp    Preview only chat turn 18         |
| Example policy   spec      repository    Durable      approved rule         |
|                                                                            |
| [Undo draft] [Save as durable preference] [Compare r4 and r5]              |
+----------------------------------------------------------------------------+
```

Annotations:

1. Chat is scoped to named files or profiles. The scope control cannot silently
   default to the full repository.
2. An explanatory response may make no change. A content-changing response
   creates a new inspectable proposal revision.
3. The current run-authorization candidate does not change until the user opens
   and accepts the proposed revision.
4. `Save as durable preference` is a separate action with scope, actor, and
   revocation details. Chat agreement never saves a durable preference.
5. Applying a changed preference invalidates review, run authorization,
   generated output, and output acceptance only for affected files. The UI
   lists those files before applying it.
6. Proposal history supports restore. Only one revision is the current
   run-authorization candidate.

### W5: Broad Run Authorization

```text
+----------------------------------------------------------------------------+
| Authorize staged generation                                          [x]   |
| Proposal r5 | Source main @ 9b42e18 | Inventory i2                         |
+----------------------------------------------------------------------------+
| Scope                                                                      |
| ( ) Current file output -> Review output acceptance                        |
| (o) C++ / Doxygen profile   ( ) Full repository                            |
|                                                                            |
| Planned destination identity                                               |
| jackson/qualcomm-example-docs | refs/heads/reference-docs/2026-09-12       |
| Write access will be requested only after output acceptance.               |
|                                                                            |
| Exact input manifest                                                       |
| 411 files | C++ / Doxygen | Inventory complete | [Download manifest]       |
| [v] src/api/client.cpp               Representative proposal available     |
| [v] src/api/session.cpp              Not yet analyzed                      |
| [v] src/device/controller.cpp        Not yet analyzed                      |
| ... 408 more files                                                         |
|                                                                            |
| Known before authorization                                                 |
| Excluded: generated 920 | unsupported 0 | manual overrides 0 [Review]       |
| Rules: inline-doc spec v3 | Doxygen profile p2 [View]                      |
| Durable preferences: 2 [View] | Preservation: 1 complete, 410 pending      |
| Source safety: source and destination repository IDs differ [Passed]       |
|                                                                            |
| Not generated yet                                                          |
| Additions, corrections, truth results, preservation dispositions, and      |
| rendered routes for 410 non-representative files.                          |
|                                                                            |
| Acknowledgement                                                            |
| [ ] I authorize staged generation for only the 411 input files listed.     |
| [ ] I understand this does not approve generated output or destination     |
|     writes. Corrections found later remain excluded until separately       |
|     accepted.                                                              |
|                                                                            |
| [Back to preview]                           [Authorize staged generation]   |
+----------------------------------------------------------------------------+
```

Annotations:

1. Selecting a current file whose exact output has been generated and inspected
   routes to W9. If the file has not been generated, it uses the same
   input-authorization model for one file.
2. Profile and repository scope load exact input manifests, not output
   manifests. The full path list and exclusions are inspectable and
   downloadable; counts alone are insufficient.
3. Before broad authorization, the user sees the frozen source SHA, inventory
   revision and completeness, exact input files, exclusions and overrides,
   documentation profiles and rules, representative proposal evidence, durable
   preferences, planned destination identity, actor, and policy checks.
4. The UI explicitly labels all non-representative additions, corrections,
   truth results, preservation dispositions, and routes as not generated. It
   never fills those fields with estimates or representative extrapolations.
5. The representative proposal remains linked as evidence for authorizing the
   rules and preferences. Its metrics are labeled `Samples only`.
6. Broad run authorization permits isolated analysis, generation, truth audit,
   preservation-ledger completion, and rendering. It never permits destination
   writes or accepts a later correction.
7. Authorization is disabled with visible reasons when the source is stale,
   inventory is incomplete for the selected scope, an input is unsupported,
   representative evidence leaves a rule decision unresolved, the destination
   identity is invalid, or a required policy review has not passed.
8. If policy requires a second reviewer for repository scope, the policy and
   current review state appear before the acknowledgement. No second reviewer
   is assumed by default.

### W6: Authorized Staging Progress And Recovery

```text
+----------------------------------------------------------------------------+
| Authorized staging run | Source read-only | No destination writes          |
| Authorization ra17 | Proposal r5 | qualcomm/example @ 9b42e18              |
+----------------------------------------------------------------------------+
| Run 17 | 38 of 411 files settled | 2 failed | 371 queued                   |
| [Analyzing] [Generating] [Auditing] [Rendering]                            |
|                                                                            |
| File                         State              Action                      |
| src/api/client.cpp           Output ready       [View result]              |
| src/api/session.cpp          Truth audit failed [View evidence] [Retry]    |
| tools/build.py               Rendering          [View log]                 |
| src/device/controller.cpp    Correction found   [Review quarantine]        |
|                                                                            |
| Status log                                                                 |
| 14:42 Truth audit stopped session.cpp: unsupported behavior claim          |
| 14:41 Existing comment correction quarantined in controller.cpp            |
|                                                                            |
| Preservation ledger: 38 complete | 373 pending | 1 correction quarantined  |
| [Open ledger] [View 373-file retry manifest]                               |
| [Cancel remaining work]                               [Retry eligible files]|
+----------------------------------------------------------------------------+
```

Annotations:

1. Progress identifies settled, active, failed, cancelled, and unstarted files
   by phase. A single percentage is not the only status.
2. The persistent label and phase list make clear that no destination write is
   possible during staging.
3. Cancellation stops future work, preserves completed staged artifacts, and
   reports the exact boundary. It does not create partial destination output.
   The dialog focuses descriptive text or `Keep running`, not cancellation.
4. Retry shows the reduced immutable input manifest before starting. It
   excludes settled files, stays under the same run authorization, and cannot
   widen scope.
5. A false or stale existing comment discovered outside the representative set
   enters a visible correction quarantine. The generated output set excludes
   the correction by default, links its evidence and preservation entry, and
   requires W9 review.
6. Logs show IDs, hashes, counts, classifications, and bounded redacted
   excerpts. They do not show credentials, secrets, full private files, or full
   prompts.
7. Source-safety, destination-identity, or authorization invariant failure
   halts staging and removes ordinary retry until the invariant is restored.

### W7: Completion And Handoff

```text
+----------------------------------------------------------------------------+
| Run completed with exceptions                                    [Partial] |
| Authorization ra17 | Output acceptance oa22 | Generated set g8             |
| Proposal r5 | Source main @ 9b42e18                                        |
+----------------------------------------------------------------------------+
| Destination output                                                         |
| Repository  jackson/qualcomm-example-docs                         [Open]    |
| Branch      reference-docs/run-17                                 [copy]    |
| Commit      8d113a0                                                 [copy]  |
| Pull request #42                                                   [Open]   |
| Rendered docs preview                                             [Open]   |
|                                                                            |
| Results                                                                    |
| 411 inputs | 409 destination files | 1 correction excluded | 2 unresolved  |
| [Accepted outputs] [Truth audit] [Rendered routes] [Preservation ledger]   |
| Existing comments: 1,432 retained | 289 incorporated | 3 corrections       |
| Correction decisions: 2 accepted | 1 excluded with original unchanged      |
|                                                                            |
| Source-safety proof                                                        |
| Source repository ID  1182 | Permission Contents: read                     |
| Frozen source SHA     9b42e18                                               |
| Destination ID       8914 | Commit 8d113a0                                 |
| Source write test    Rejected                                               |
| Source ref readback  Unchanged by this run                                 |
| [Download authorization, acceptance, ledger, and safety records]           |
|                                                                            |
| Durable preferences retained: 2 [Manage]                                   |
| Retention {policy} | Deletion {state} | Legal hold {state}    [Manage data] |
| [Return to preview]                                  [Start another preview]|
+----------------------------------------------------------------------------+
```

Annotations:

1. Completion separates authorized inputs, accepted outputs, completed writes,
   excluded corrections, failures, and unresolved items. It does not label a
   partial result as wholly successful.
2. Destination repository, branch, commit, PR, render, and audit records are
   linked separately.
3. Source-safety proof correlates repository IDs, SHAs, permissions, the
   rejected write test, destination output, and source-ref readback.
4. `Return to preview` preserves the frozen snapshot and proposal history in
   read-only form. A new source snapshot creates a new preview lineage.
5. The completion handoff links the exact run authorization, generated output
   set, output acceptance, preservation ledger, correction decisions, and
   destination write result. An excluded correction remains visible with its
   evidence and unchanged-original disposition.
6. A user-cancelled destination write uses the distinct heading
   `Destination write cancelled`, not `Partial failure`. The handoff links every
   retained destination commit, the exact accepted outputs not written, the
   unchanged output acceptance and accepted-manifest hashes, the configured
   commit or rollback boundary, and either `Review resume manifest` or
   `Finish with cancelled remainder`.

### W8: Narrow Viewport

```text
+--------------------------------------+
| Preview only | Source read-only      |
| qualcomm/example @ 9b42e18 [copy]    |
| Preview 3 of 8                 [menu]|
+--------------------------------------+
| [Files 5] [Changes 21] [Evidence]    |
|                                      |
| src/api/client.cpp                   |
| C++ / Doxygen | 4 changes            |
|                                      |
| [Unified diff]                       |
| @@ Client::connect                   |
| - // Connects the client.            |
| + /** Connects to the configured     |
| +  * endpoint.                       |
| +  * @param timeout ...              |
| +  */                                |
|                                      |
| [Previous]                 [Next]     |
+--------------------------------------+
| [Ask agent]      [Review file output]|
+--------------------------------------+
```

Annotations:

1. Under 768 CSS pixels, the interface uses one primary pane. Files, changes,
   evidence, and agent chat open as tabs or full-height sheets.
2. Mobile defaults to unified diff. Only the bounded code region may scroll
   horizontally; the page itself reflows in one dimension.
3. The sticky action row never covers focused content. Focus scroll padding
   accounts for the context header and action row.
4. Exact manifests open as a full-screen review sheet, not a compressed dialog.
5. At 320 CSS pixels and 200 percent zoom, text wraps, long tokens remain within
   their code region, and actions remain reachable without page-level
   horizontal scrolling.

### W9: Generated Output Acceptance

```text
+----------------------------------------------------------------------------+
| Review generated output set g8                                       [x]   |
| Authorization ra17 | Source 9b42e18 | 411 input files | Staging complete   |
+----------------------------------------------------------------------------+
| [Additions 1,284] [Corrections 3] [Excluded 3] [Preservation 1,724]         |
|                                                                            |
| Exact generated output                                                     |
| File                        Truth     Render     Preserve         Decision  |
| src/api/client.cpp           Passed    Ready      4 incorporated   Include  |
| src/api/session.cpp          Passed    Ready      7 retained       Include  |
| src/device/controller.cpp    Passed    Ready      1 correction     Review > |
|                                                                            |
| Correction quarantine                                                      |
| [ ] controller.cpp:42 "Always retries."                                    |
|     Evidence contradicts the existing comment. Original remains unchanged. |
|     [Original and evidence] [Proposed replacement] [Accept correction]      |
|                                                                            |
| Output excluded from this acceptance                                       |
| 1 correction not selected | 2 unresolved claims | [Review exclusions]      |
|                                                                            |
| Acknowledgement                                                            |
| [ ] I accept the 1,284 additive outputs and exact routes in set g8.         |
| [ ] I separately accept 2 selected existing-comment corrections.           |
|                                                                            |
| [Back to generated results]       [Accept output and request write access]  |
+----------------------------------------------------------------------------+
```

Annotations:

1. W9 is the first broad decision point that shows exact per-file additions,
   correction proposals, truth results, preservation dispositions, and rendered
   routes. It binds all values to one generated output set revision.
2. Additive outputs and correction proposals are separate tabs, counts,
   filters, acknowledgements, and accepted subsets. Corrections are unselected
   and excluded from automatic writes by default.
3. A correction found outside the representative preview shows the original
   source location and text, evidence of false or stale content, proposed
   replacement, affected route, and preservation-ledger entry. The user can
   accept it separately or leave it excluded with the original unchanged.
4. An unresolved claim, failed truth audit, failed required render, or
   incomplete preservation-ledger coverage cannot enter the accepted write
   manifest. The UI records the exclusion and its reason instead of silently
   omitting the item.
5. Acceptance may include all reviewed additive output and any separately
   selected correction subset. The confirmation shows exact output IDs, file
   paths, hashes, routes, exclusions, destination identity, and policy checks.
6. Changing or regenerating output invalidates acceptance only for affected
   output IDs and creates a new generated output set revision. It cannot mutate
   an existing acceptance record.
7. Accepting a previously excluded correction later creates a new
   correction-only acceptance record. The user reviews the same evidence again,
   and the resulting write run contains only that accepted correction subset.
8. Destination write authority is requested only after output acceptance.
   Activating the command never writes before authorization succeeds.

### W10: Destination Write Cancellation

```text
+----------------------------------------------------------------------------+
| Approved destination run | Source remains read-only | Cancelling           |
| Write dw31 | Acceptance oa22 | Accepted manifest 409 outputs                |
+----------------------------------------------------------------------------+
| Configured boundary: {policy value from AR-09}                 [View policy]|
|                                                                            |
| Write disposition                                                          |
| Completed 180 | Active 1 | Unstarted 228 | Failed or rolled back 0          |
| [Completed commits 7] [Active output] [Unstarted accepted outputs]          |
|                                                                            |
| Active: src/device/controller.cpp                                          |
| Settling at the configured boundary; no new accepted output will start.     |
|                                                                            |
| Acceptance oa22 and accepted manifest 4ab9... remain immutable.             |
| Source safety: read-only source | Different destination | Proof available   |
| [View acceptance] [View commits] [Open source-safety proof]                 |
| [Cancelling - unavailable]                                  [Keep waiting] |
+----------------------------------------------------------------------------+

After active work settles:

+----------------------------------------------------------------------------+
| Destination write cancelled | Source remains read-only             [Done]  |
| Completed 181 | Remaining accepted 228 | Failed or rolled back 0            |
+----------------------------------------------------------------------------+
| Retained destination commits: 7 | Latest 8d113a0                [Open all]  |
| Remaining accepted manifest: 228 outputs | hash 17cd...          [Download] |
| Boundary applied: {configured commit or rollback boundary}       [Details]  |
| Acceptance oa22 unchanged | Accepted manifest 4ab9... unchanged             |
| Source ref unchanged | Rejected source write recorded             [Proof]   |
|                                                                            |
| [Cancellation complete - unavailable]                                      |
| [Finish with cancelled remainder]                  [Review resume manifest] |
+----------------------------------------------------------------------------+
```

Annotations:

1. Confirming `Cancel unstarted writes` closes the confirmation dialog and
   returns focus to the invoking command in its stable action slot. The same
   button DOM node remains focused, changes its label to `Cancelling`, sets
   `aria-disabled="true"`, and ignores repeated activation. It is not removed or
   natively disabled while focused.
2. A concise polite live-region update announces that no unstarted accepted
   output will begin. Focus does not move to the status heading or any progress
   row. If focus was elsewhere when cancellation was requested, it remains
   there.
3. When cancellation settles, the same action slot reports
   `Cancellation complete`. If the pending button still has focus, it remains
   as an aria-disabled control until the user tabs away; the settled view does
   not move focus. A later render may remove that inactive control after focus
   has left it.
4. The cancelling view partitions every accepted output into exact completed,
   active, unstarted, and failed or rolled-back sets. Counts link to file-level
   lists, and completed output links to the exact destination commits already
   created.
5. Active work settles only to the commit or rollback boundary configured by
   architecture input AR-09. The UI displays that value and its policy source;
   it never chooses an atomic, batch, file, or rollback default.
6. The output acceptance and full accepted manifest remain immutable.
   Cancellation adds a write-run checkpoint and dispositions; it does not
   remove accepted output or convert unstarted work into rejection.
7. The cancelled state has no active work. It shows retained commits, any
   failed or rolled-back active unit, and the exact remaining accepted outputs
   that were not written.
8. `Review resume manifest` opens a reduced manifest containing only remaining
   accepted outputs. Confirmation resumes through the same output-acceptance
   idempotency tuple; completed outputs cannot run again and no new output can
   enter the manifest.
9. `Finish with cancelled remainder` creates the W7 completion handoff with a
   cancelled disposition, exact retained commits, exact remaining manifest,
   and a later resume link. It is not reported as partial failure.
10. The source-read-only label and source-safety proof remain visible throughout
   cancelling, cancelled, resume review, and completion.

## Detailed State Inventory

Every state below has a defined entry condition, available actions, and exit
condition. Product copy is refined in the Interaction Copy section.

### Access And Source States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| AC-01 | New preview: no source submitted | Enter URL, ref, optional destination; cancel | Submit starts AC-02 |
| AC-02 | Validating: submitted fields are syntactically valid | Cancel validation | All checks pass to AC-09; a failed check routes to AC-03 through AC-08 |
| AC-03 | Invalid repository URL: provider or path cannot be parsed | Edit URL; view accepted format | Valid resubmission to AC-02 |
| AC-04 | Authorization required: no installation or user grant covers source | Connect GitHub; choose installation; cancel | Grant returns to AC-02 |
| AC-05 | Inaccessible repository: source is missing, hidden, or outside selected installation | Change repository; choose installation; request admin access | Successful access to AC-02 |
| AC-06 | Insufficient source permission: metadata is visible but contents are not readable | Reauthorize with read permission; change source | Effective read permission to AC-02 |
| AC-07 | Invalid ref: ref does not resolve to a commit | Edit ref; choose default branch; cancel | Resolved ref to AC-02 |
| AC-08 | Unsupported provider or repository form: the workflow cannot safely inventory it | Change source; view supported forms; copy diagnostic ID | Supported source to AC-02 |
| AC-09 | Private-content disclosure required: source is private and policy has not been acknowledged | View data handling; acknowledge; cancel | Acknowledgement to AC-10 |
| AC-10 | Source frozen: repository and ref resolve to immutable SHA | Start inventory; edit setup; copy source identity | Start to IN-01; edit invalidates snapshot and returns AC-01 |
| AC-11 | Empty repository: traversal finds no files at frozen SHA | Change ref or repository; close preview | New valid source to AC-02 |
| AC-12 | Destination invalid: destination is the source repository, inaccessible, or disallowed | Choose another destination; preview without destination | Valid destination keeps AC-10; defer allows inventory but blocks run authorization |
| AC-13 | Source authorization expired after freeze | Reauthorize read access; preserve frozen identity; cancel | Same repository and SHA access resumes prior state |
| AC-14 | Source moved: symbolic ref no longer points to frozen SHA | Continue reviewing frozen SHA; re-inventory latest ref; close preview | Frozen choice restores prior state; refresh creates new snapshot lineage |

### Inventory And Classification States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| IN-01 | Inventory queued: snapshot is valid and work has not started | Cancel; view source identity | Worker starts IN-02 |
| IN-02 | Inventory running: traversal or classification is active | Cancel; view phase and counts | Complete to IN-03; interruption to IN-04 or IN-05 |
| IN-03 | Inventory complete: all reachable entries are classified | Review profiles, exclusions, and samples; generate previews | Samples valid to RP-01 |
| IN-04 | Inventory partial: a bounded traversal, parser, or permission segment failed | Retry failed segment; narrow source root; continue preview with limitations; cancel | Full retry to IN-03; limited result remains IN-04 and blocks repository run authorization |
| IN-05 | Inventory truncated: provider limit or configured cap prevents complete coverage | Resume chunked traversal; narrow source root; cancel | Complete traversal to IN-03 |
| IN-06 | Rate limited: provider rejects further inventory calls | Retry when available; preserve completed pages; cancel | Successful retry to IN-02 |
| IN-07 | Unsupported repository: no supported documentation profile has a viable file | Review unsupported files; change source; close preview | Supported source to AC-02 |
| IN-08 | Mixed supported and unsupported profiles | Review reasons; preview supported profiles; request support separately | Supported samples proceed to RP-01; unsupported files remain excluded |
| IN-09 | Generated or vendor exclusions present | Review classification evidence; temporarily include an eligible file; restore default | Accepted rules to IN-03 or IN-04 |
| IN-10 | Unclassified files present | Inspect signals; classify for this run; exclude with reason | All files classified to IN-03 |
| IN-11 | No representative candidate for a profile | Choose an eligible file; exclude profile; repair access or evidence | Selected sample to IN-03; exclusion keeps profile visible |
| IN-12 | Representative selected automatically | View rationale; choose another file; accept sample | Accepted sample contributes to RP-01 |
| IN-13 | Representative replaced manually | Compare rationale; restore prior choice; accept replacement | Accepted replacement updates representative selection only |
| IN-14 | Manual inclusion warning: user includes generated, vendor, or atypical file | Confirm per-run inclusion; cancel | Confirmed inclusion returns IN-03 and records override |
| IN-15 | Inventory cancelled | Resume from preserved checkpoint; start over; close preview | Resume to IN-02; restart to IN-01 |

### Representative Proposal States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| RP-01 | Proposal queued: accepted representative set is ready | Cancel; view sample manifest | Worker starts RP-02 |
| RP-02 | Proposal generating: source analysis or authoring is active | Cancel; view per-file phase | All files settle to RP-03, RP-04, or RP-05 |
| RP-03 | Proposal ready: all selected files have inspectable results | Review additions, corrections, evidence, render, and preservation entries | Review remains RP-03; refinement to RF-01; broad authorization to AP-01; inspected file acceptance to OA-01 |
| RP-04 | Proposal partial failure: some representative files failed | Retry failed files; replace sample; exclude profile; inspect successful files | All required samples settle to RP-03 |
| RP-05 | Proposal cancelled | Resume eligible files; regenerate; return to inventory | Resume to RP-02; inventory to IN-03 |
| RP-06 | Additive comment selected | Mark reviewed; ask agent; view evidence; navigate | Selection changes or proposal revises; write acceptance remains OA-02 |
| RP-07 | Existing-comment correction selected | View original, reason, evidence, and replacement; mark reviewed candidate; ask agent; exclude from proposal | Candidate reviewed, revised, marked unresolved, or excluded; write acceptance remains OA-03 |
| RP-08 | Truth audit accepted | Review evidence; change disposition with reason | Revision changes or selection changes |
| RP-09 | Truth audit corrected | Compare earlier wording and repaired wording; inspect evidence | Revision changes or selection changes |
| RP-10 | Needs human review: evidence cannot support a confident statement | Ask agent; edit scope; exclude change; provide approved evidence | Resolved disposition or exclusion |
| RP-11 | Truth audit excluded: unsupported or unsafe output is not in scope | View reason; restore for review if evidence changes | New proposal revision may re-enter review |
| RP-12 | Render queued or building | Continue code review; view build phase | Success to RP-13; failure to RP-14 |
| RP-13 | Render ready | Open route, sidebar projection, links, before and after view | New proposal invalidates affected render |
| RP-14 | Render failed | View bounded log; retry render; continue code review | Successful retry to RP-13; selected scope remains blocked |
| RP-15 | Non-previewable file: binary, LFS, symlink, submodule, malformed, or too large | View reason; exclude; choose representative replacement | Replacement to RP-02; exclusion remains visible |
| RP-16 | Long or large diff | Filter symbols; collapse unchanged regions; use next change; open full-screen | Navigation or filter changes; never changes proposal content |
| RP-17 | Preservation entry selected: an existing representative-file comment is in the ledger | View source location, original text and hash, evidence, disposition events, and related output | Selection changes or a disposition review creates a new ledger event |
| RP-18 | Representative preservation ledger incomplete: at least one discovered comment lacks location, evidence, or disposition | Open missing entries; retry analysis; exclude representative file with reason | Complete entries return to RP-03; replacement returns to IN-13 |

### Refinement And Preference States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| RF-01 | Agent panel open with explicit file or profile scope | Enter question or instruction; change scope; close panel | Send to RF-02 |
| RF-02 | Agent responding | Cancel response; keep reviewing current proposal | Explanation to RF-03; content change to RF-04; failure to RF-05 |
| RF-03 | Explanation only: response proposes no content change | Continue conversation; close; cite evidence | New message to RF-02; close to RP-03 |
| RF-04 | Candidate revision ready: response changes content or preferences | View diff; compare; accept revision; reject revision | Accept to RF-06; reject to RP-03 |
| RF-05 | Agent error, timeout, or rate limit | Retry same scoped turn; edit prompt; cancel | Retry to RF-02; cancel to RF-01 |
| RF-06 | New proposal revision accepted | Review affected files; inspect invalidated states; undo | Review to RP-03; undo creates restored revision |
| RF-07 | Draft preference identified | Edit value; keep preview-only; start durable save; remove | Preview-only remains; save to RF-08 |
| RF-08 | Durable preference confirmation | Choose an allowed policy scope; review affected files; confirm; cancel | Confirm to RF-09; cancel to RF-07 |
| RF-09 | Durable preference saved | View provenance; revoke; supersede; apply to proposal | Apply creates new proposal revision and selective invalidation |
| RF-10 | Durable preference not permitted: actor or scope lacks authority | Keep preview-only; choose permitted scope; request policy owner | Permitted choice to RF-08 |
| RF-11 | Preference conflict: two active values overlap | Choose precedence; narrow scope; revoke one; cancel change | Resolved ledger creates new revision |
| RF-12 | Review, run authorization, or output acceptance invalidated by refinement | View affected files and reason; re-review; restore prior revision | All affected records replaced or prior revision restored |
| RF-13 | Conversation draft interrupted by navigation or reload | Restore draft; discard; return to target file | Decision returns RF-01 |

### Run Authorization States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| AP-01 | Scope selector open from a reviewable representative proposal | Choose file, profile, or repository | Generated file routes to AP-02; profile to AP-03; repository to AP-04 |
| AP-02 | File scope selected | Review existing generated output; or inspect one-file input, rules, exclusions, and preferences | Inspected output routes to OA-01; ungenerated file routes to AP-08 |
| AP-03 | Documentation-profile input manifest ready | Inspect or download exact paths, exclusions, representative evidence, rules, preferences, pending ledger coverage, and destination identity | Valid acknowledgement to AP-08 |
| AP-04 | Repository input manifest ready and inventory complete | Inspect or download every exact input path, profile, exclusion, override, rule, preference, pending ledger coverage, and destination identity | Valid acknowledgement to AP-08 |
| AP-05 | Authorization blocked by stale source | Review frozen SHA; refresh source; cancel | Explicit frozen-SHA choice or new inventory returns AP-01 |
| AP-06 | Authorization blocked by incomplete inventory, unsupported input, or unresolved representative rule decision | Open each blocker; reduce input scope; repair; cancel | No blockers returns AP-01 |
| AP-07 | Planned destination identity missing, same as source, inaccessible, or disallowed | Select a different repository; return to preview | Valid different destination returns selected input manifest |
| AP-08 | Staged-generation authorization confirmation ready | Review known inputs and explicit unknown outputs; check both acknowledgements; authorize; back | Authorization creates AP-09 |
| AP-09 | Broad run authorization recorded against immutable source, inventory, input manifest, rules, preferences, destination identity, and actor | Start staging; view or download record; revoke before staging | Staging starts EX-01 |
| AP-10 | Second review required by enterprise policy | Request eligible reviewer; view verdict; cancel authorization | Passing review to AP-08; changes required to RP-03 |
| AP-11 | Run authorization invalidated: source, inventory, input manifest, profile rule, durable preference, destination identity, or policy changed | View cause and affected inputs; re-review; restore prior state | New valid authorization to AP-09 |
| AP-12 | Duplicate authorization request for an identical immutable tuple | Open existing authorization; continue existing staging run; close | Existing record becomes authoritative |
| AP-13 | Broad-scope output fields requested before generation | View representative sample; view exact known inputs; continue authorization; cancel | User returns to AP-03 or AP-04 without invented output values |

### Output Acceptance States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| OA-01 | Exact generated output is ready for one inspected file or a staged generated output set | Review additions, corrections, truth results, routes, exclusions, hashes, and preservation coverage | Selection opens OA-02 through OA-06 |
| OA-02 | Additive output selected | View diff, truth evidence, route, output hash, and preservation links; include or exclude | Decision updates OA-07 summary |
| OA-03 | Correction quarantine selected | View original location and text, evidence, proposed replacement, route, and ledger history; select correction separately or exclude | Selection updates correction subset; exclusion keeps original unchanged |
| OA-04 | Generated item unresolved or failed | View evidence or log; exclude; regenerate affected output; return to staging retry | Exclusion updates OA-07; regeneration creates a new generated output set |
| OA-05 | Preservation ledger review open | Filter by file and retained, incorporated, correction-proposed, or excluded disposition; open source and evidence | Complete coverage returns OA-01; missing coverage routes to OA-06 |
| OA-06 | Output acceptance blocked by incomplete ledger, failed required render, stale truth evidence, or unresolved included output | Open blocker; exclude item; regenerate; cancel | All included items valid to OA-07 |
| OA-07 | Exact output acceptance summary ready | Inspect accepted additions, separately selected corrections, explicit exclusions, routes, hashes, destination, and acknowledgements | Confirm additions to OA-08; selected corrections also to OA-09 |
| OA-08 | Additive output subset accepted | View immutable subset; add valid correction selection; request destination access; cancel before write | With final correction decision to OA-10 |
| OA-09 | Existing-comment correction subset separately accepted | View evidence and immutable correction subset; revoke before write | Combined with additive decision to OA-10 |
| OA-10 | Output acceptance record created with exact write-manifest hash | Request destination write authority; download record; revoke before write | Destination authorization starts EX-11 |
| OA-11 | Output acceptance invalidated by generated-output revision, accepted subset, destination, or policy change | View affected output IDs; re-review changed output; restore prior generated set | New valid acceptance to OA-10 |
| OA-12 | Correction excluded or deferred | View unchanged original and exclusion reason; finish additive acceptance; start later correction-only review | Additive write proceeds via OA-10; later review creates a new correction-only OA-10 |

### Execution, Recovery, And Handoff States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| EX-01 | Staging run queued with run-authorization idempotency key | Cancel; view exact input manifest and queue state | Worker starts EX-02 |
| EX-02 | Analyzing authorized input files and discovering existing comments | Cancel remaining work; view per-file status and ledger coverage | Next phase EX-03 or settled failure EX-07 |
| EX-03 | Generating outputs in isolated staging | Cancel remaining work; view per-file status | Next phase EX-04 or settled failure EX-07 |
| EX-04 | Truth auditing outputs and assigning preservation dispositions | Cancel remaining work; inspect evidence and correction quarantine | Next phase EX-05 or settled failure EX-07 |
| EX-05 | Rendering docs and sidebar projection without destination writes | Cancel remaining work; inspect build status | Settled files create EX-06 or EX-07 |
| EX-06 | Generated output set ready with exact outputs, ledger revision, failures, and exclusions | Open W9; download generated set; return to representative preview | Output review starts OA-01 |
| EX-07 | Staging partial failure: some inputs settled and others failed or remain unstarted | View failure evidence; prepare retry; create output set from settled files | Retry review to EX-08; partial set to EX-06 |
| EX-08 | Staging retry manifest review | Inspect failed and unstarted inputs; remove eligible failures; confirm | Retry starts EX-01 under same authorization with reduced manifest |
| EX-09 | Staging cancelling: stop requested while work is active | Keep waiting; view exact boundary | Settled files to EX-10 |
| EX-10 | Staging cancelled: completed staged artifacts preserved and no destination writes exist | View results; prepare retry; create partial generated set; return to preview | Retry to EX-08; partial set to EX-06; preview to RP-03 |
| EX-11 | Destination authorization required after output acceptance | Connect or choose the accepted destination installation; revoke acceptance | Valid least-privilege grant to EX-13; denial to EX-12 |
| EX-12 | Destination authorization denied or expired | Retry authorization; reselect destination through new acceptance; cancel | Same accepted destination grant to EX-13 |
| EX-13 | Destination write queued with output-acceptance idempotency key and exact write manifest | Cancel unstarted writes; view accepted manifest and queue state | Cancel request to EX-21; worker starts EX-14 |
| EX-14 | Writing accepted outputs only with exact completed, active, and unstarted partitions | View write log and exact commits; cancel unstarted writes; view configured commit or rollback boundary | Cancel request to EX-21; all outputs settle to EX-17; system or item failure without user cancellation to EX-15 |
| EX-15 | Destination write partial failure without user cancellation: some accepted outputs completed and others failed or remain unstarted | View commits and failure evidence; review reduced accepted retry manifest; finish with exceptions | Retry starts EX-13 without widening acceptance; finish to EX-17 |
| EX-16 | Safety halt: source write capability, repository identity, accepted manifest, authorization, or acceptance invariant fails | View diagnostic and audit event; cancel run; contact operator | New corrected authorization, acceptance, or credentials required |
| EX-17 | Completion handoff ready for completed, exception, or user-cancelled destination result | Open branch, commits, PR, render, truth audit, preservation ledger, correction decisions, cancellation or failure disposition, remaining accepted manifest, and safety proof | Review remaining accepted resume manifest; return to read-only preview; close |
| EX-18 | Reload or relaunch during staging, acceptance, write, cancelling, or cancelled state | Resume by immutable record or run ID; return to issue list | Exact state and output partitions restore without duplicate generation, acceptance, or write |
| EX-19 | Stale source detected before first destination write | Continue only if acceptance and policy explicitly bind the frozen SHA; re-preview latest; cancel | Policy-valid frozen write resumes; refresh invalidates authorization and acceptance |
| EX-20 | Return to preview after execution | Inspect historical proposal, authorization, generated output, acceptance, ledger, and results; start new lineage | Source or preference change creates a new proposal lineage |
| EX-21 | Destination write cancelling after a user requests cancellation from queued or writing state | Keep waiting; view exact completed, active, unstarted, and failed or rolled-back partitions; open retained commits, immutable acceptance and accepted manifest, configured boundary, actor and timestamp, and source-safety proof | Active outputs settle at the configured boundary and no unstarted output begins; settled checkpoint to EX-22; invariant failure to EX-16 |
| EX-22 | Destination write cancelled with zero active outputs, exact retained commits, and an exact remaining accepted manifest | Review reduced resume manifest; download cancellation and commit records; finish with cancelled remainder; open source-safety proof | Confirmed reduced resume starts EX-13 under the same output-acceptance idempotency tuple; finish creates cancelled EX-17 handoff |

### Global Empty, Loading, Error, Policy, And Preference States

| ID | State and entry condition | Available actions | Exit condition |
| --- | --- | --- | --- |
| GL-01 | Loading known layout: data for a stable panel is pending | Navigate outside modal; cancel when supported | Data or error replaces skeleton without layout shift |
| GL-02 | Empty filter result: current filters match no files or changes | Clear individual filters; clear all | Matching result restores list |
| GL-03 | Empty queue by success: no corrections, unresolved items, or failures exist | Return to all changes | New filter or revision changes result |
| GL-04 | Recoverable panel error: one panel failed while the record remains valid | Retry panel; copy diagnostic ID; continue elsewhere | Successful load restores panel |
| GL-05 | Fatal preview error: source or proposal record cannot be recovered | Retry from checkpoint; export diagnostic; close preview | Recovered checkpoint or closed session |
| GL-06 | Permission changed during session | Reauthorize; continue read-only where allowed; close | Restored permission or safe exit |
| GL-07 | Offline or network interrupted | Retry; continue reading cached non-sensitive state where policy permits | Connectivity restores current record |
| GL-08 | Concurrent update: another authorized actor changes preference or policy | Review change; reload record; keep local draft | Reconciled record restores action |
| GL-09 | Legal hold active: one or more retained artifact classes cannot be deleted under the configured hold | View hold ID, scope, authority, effective time, and release or review path; export the minimal audit record; continue read-only review | Hold release updates the lifecycle record and restores policy-eligible deletion; an active hold remains visible and blocks deletion |
| GL-10 | Reduced-motion preference active at load or changed during the session | Continue every workflow with static status, progress, and focus behavior; use all commands without motion | Preference change updates future nonessential transitions in place without changing records, restarting work, or moving focus |

## Interaction Copy

Copy must state the object, scope, consequence, and recovery. Avoid generic
labels such as `Continue`, `Submit`, `Something went wrong`, or `Run all`.

| Situation | Required copy |
| --- | --- |
| Persistent preview label | `Preview only | Source read-only | No commits or branches will be created` |
| Staging label | `Authorized staging run | Source read-only | No destination writes` |
| Destination-write label | `Approved destination run | Source remains read-only` |
| Frozen source | `Previewing {repository} at {short SHA}, resolved from {ref}.` |
| Ref moved | `{ref} now points to {new SHA}. This preview remains frozen at {old SHA}.` |
| Source write boundary | `Accepted output can be written only to {destination}. The source repository remains read-only.` |
| Invalid URL | `Enter a GitHub repository URL in the form github.com/owner/repository.` |
| Authorization required | `Connect a GitHub installation that can read this repository.` |
| Inaccessible repository | `This repository is not available to the selected installation. Choose another installation or repository.` |
| Invalid ref | `We could not resolve "{ref}" to a commit in this repository.` |
| Empty repository | `No files were found at {short SHA}. Choose another ref or repository.` |
| Unsupported repository | `No supported documentation profiles were found. Existing files and comments will not be changed.` |
| Partial inventory | `Inventory is incomplete: {count} paths could not be classified. Full-repository run authorization is unavailable.` |
| Truncated inventory | `Inventory stopped at the provider limit. Resume inventory or narrow the source root before authorizing the repository.` |
| Representative rationale | `Selected because it contains public symbols, existing comments, and source evidence typical of this profile.` |
| Representative limitation | `Sample only | Output exists for {sample count} representative files. Other selected files have not been analyzed or generated.` |
| Preservation coverage pending | `{complete} selected files have complete existing-comment records. {pending} files are not yet analyzed.` |
| Correction label | `Existing comment correction quarantined | Separate review and acceptance required` |
| Discovered broad correction | `A false or stale existing comment was found in {path}. It is excluded from writes unless you separately accept the correction.` |
| Excluded correction | `Correction excluded | The original comment remains unchanged. Review it later through a new correction-only acceptance.` |
| Unresolved truth state | `Needs human review | The available source does not support this statement.` |
| Chat scope | `Agent scope: {files or profile}. This message cannot change other files.` |
| Candidate revision | `Proposal r{n} is ready to inspect. Your current run-authorization candidate has not changed.` |
| Durable preference action | `Save as durable preference` |
| Durable preference confirmation | `Save "{key}: {value}" for {allowed scope}. This affects later proposal runs after review.` |
| Review invalidated | `{count} reviewed files changed in proposal r{n}. Review and affected authorization or acceptance records must be renewed only for those files.` |
| File generation acknowledgement | `I authorize staged generation for only the {count} input file(s) listed above.` |
| Profile run acknowledgement | `I authorize staged generation for the exact {profile} input manifest of {count} files.` |
| Repository run acknowledgement | `I authorize staged generation for the complete {count}-file input manifest at {short SHA}.` |
| Run limitation acknowledgement | `This authorization permits generation and audit only. It does not approve generated output or destination writes.` |
| Run authorization command | `Authorize staged generation` |
| Additive output acknowledgement | `I accept the {count} additive outputs and exact rendered routes in generated set {id}.` |
| Correction acceptance acknowledgement | `I separately accept the {count} selected existing-comment corrections in generated set {id}.` |
| Output acceptance command | `Accept output and request write access` |
| Missing destination | `Select a different destination repository before run authorization. Qualcomm source repositories cannot be used as destinations.` |
| Cancel staging | `Cancel remaining staging work? Completed staged results will remain. No destination files have been written.` |
| Configured write boundary | `Active writes use the configured {commit or rollback boundary}. This interface does not choose a fallback boundary.` |
| Cancel destination write | `Cancel {unstarted} unstarted writes? {completed} completed writes and their listed commits remain. {active} active writes will settle at the configured {boundary}. No new accepted output will start, and acceptance {id} remains unchanged.` |
| Pending cancellation control | `Cancelling` |
| Destination write cancelling | `Cancelling write run {id}. No unstarted accepted output will begin. {active} active writes are settling at the configured {boundary}.` |
| Settled cancellation control | `Cancellation complete` |
| Destination write cancelled | `Write run {id} was cancelled: {completed} accepted outputs were written in {commit count} retained commits; {remaining} accepted outputs remain unwritten. Acceptance {acceptance id} and manifest {hash} are unchanged.` |
| Resume cancelled write | `Resume {remaining} remaining accepted writes from manifest {hash}. {completed} completed writes will not run again, and no new output can be added.` |
| Legal hold active | `Deletion is unavailable for {artifact classes} under legal hold {hold id}. Retention continues for the displayed scope until the configured authority releases the hold.` |
| Legal hold action | `View legal hold and release path` |
| Staging retry summary | `Retry {failed} failed and {unstarted} unstarted inputs. {settled} settled inputs will not run again.` |
| Write retry summary | `Retry {failed} failed and {unstarted} unstarted accepted writes. {completed} completed writes will not run again.` |
| Partial completion | `Write completed with exceptions: {completed} completed, {failed} failed, {excluded} excluded by output acceptance.` |
| Cancelled completion | `Destination write cancelled: {completed} completed, {remaining} accepted outputs not written, {failed or rolled back} failed or rolled back at the configured boundary.` |
| Source-safety pass | `Source safety verified for this run: read-only permission, different destination, rejected source write, and source-ref readback recorded.` |
| Safety halt | `Writes stopped because the authorized source, accepted output, destination, permission, or manifest no longer matches this run.` |
| Return to preview | `Return to preview` |

## Control And Interaction Rules

### Source And Destination

- Repository URL and ref are separate fields. Pasting a tree or commit URL may
  populate both only after showing the parsed result.
- Validation never starts inventory implicitly.
- Destination selection may be deferred during representative preview. A
  destination identity is required for run authorization, while destination
  write permission is requested only after output acceptance.
- Source and destination repository IDs, not names alone, enforce separation.
- Changing source URL, ref, or destination after run authorization invalidates
  that authorization. Changing destination after output acceptance also
  invalidates acceptance.
- The interface shows acting identity and effective permissions before each
  authorization boundary.

### Inventory

- Default filters show all classes and counts. Users can filter the list, but
  no filter changes the inventory record.
- Generated, vendor, lock, minified, build-output, unsupported, unreadable, and
  unclassified files remain visible as named classes.
- A manual inclusion is an explicit per-run override with reason and actor. It
  never becomes a repository default or durable preference silently.
- Virtualized lists retain list position, selected item, total count, and
  accessible position metadata. Search and filters operate on the full result,
  not only rendered rows.
- Replacing a representative file records the former selection and rationale.

### Proposal Review

- Unified and side-by-side diff modes preserve the selected file, change, and
  scroll position where practical.
- The default desktop mode is side-by-side when width permits. The default
  narrow mode is unified.
- Unchanged code is collapsed with an explicit line count and expand command.
- Each proposal change can be linked by proposal revision, file, symbol, and
  change ID.
- Review progress is per file and per proposal revision. It is neither run
  authorization nor output acceptance.
- Corrections cannot be visually merged into additions. Their queue, label,
  evidence, and manifest count remain separate.
- The selected symbol inspector shows purpose, parameter, error, return, and
  example metadata. Omitted examples state whether the value is trivial,
  boolean, a large composed object, or otherwise disallowed by the spec.
- Rendered docs always name the proposal revision that produced them.

### Existing-Comment Preservation

- Representative review shows a complete preservation ledger for each sample,
  including retained comments with no proposed diff.
- Broad authorization shows complete representative coverage and
  `Not yet analyzed` coverage for every other exact input file. It never
  presents pending entries as retained, incorporated, corrected, or excluded.
- Staged analysis creates immutable per-comment entries before generated output
  can be accepted. Counts reconcile from each file to the generated output set.
- A ledger entry exposes source location, original text hash and authorized
  text, evidence, disposition events, related output, and actor.
- `Correction proposed` never becomes `accepted` through a broad run
  authorization. Output acceptance records a separate correction decision.
- Excluding or deferring a correction preserves the original comment, records
  the decision and reason, and keeps a correction-only reapproval path visible.
- Preview, run authorization, staging results, output acceptance, destination
  results, and completion each link the applicable immutable ledger revision.

### Agent Conversation

- The composer requires an explicit scope. The previous scope may be retained
  only while it remains visibly named beside the composer.
- Agent responses cite the evidence records used. Unsupported claims are
  returned as unresolved, not confident text.
- Streaming response text is visually incremental but announced to assistive
  technology only when a coherent response or status is ready.
- Closing the panel preserves unsent drafts per file until the user discards
  them or the source snapshot is deleted.
- A response that changes output creates a candidate proposal revision. The
  user chooses whether it becomes current.

### Durable Preferences

- Every ledger row shows key, value, allowed scope, source conversation, actor,
  created revision, current status, and revoke action.
- `Preview only` is the default status for an inferred or conversational
  preference.
- The server supplies allowed durable scopes based on policy. The UI does not
  assume repository, organization, workspace, or agent scope.
- Applying, superseding, or revoking a durable preference creates a new
  proposal revision when output changes.
- The confirmation lists files whose review, run authorization, generated
  output, or output acceptance will be invalidated.

### Run Authorization And Output Acceptance

- Scope is a radio group with file, documentation profile, and repository
  choices. The narrowest valid scope is selected by default.
- A generated and inspected file routes directly to output acceptance. An
  ungenerated file, profile, or repository routes to run authorization.
- Profile and repository run authorization shows exact input files,
  classifications, exclusions, manual overrides, profile rules, durable
  preferences, source SHA, inventory revision, representative evidence,
  destination identity, actor, and policy checks.
- Broad authorization labels additions, corrections, truth results,
  preservation dispositions, and rendered routes for non-representative files
  as `Not generated`. It does not show placeholder zeroes or estimates.
- Run-scope changes reset the generation acknowledgement. A run authorization
  is immutable and permits staging only.
- Output acceptance shows exact generated additions, quarantined corrections,
  unresolved or failed items, rendered routes, output hashes, preservation
  dispositions, explicit exclusions, and destination identity.
- Corrections are excluded by default and require a separate selection and
  acknowledgement. Additive acceptance can proceed while corrections remain
  excluded and original comments remain unchanged.
- The output acceptance record is immutable. A material generated-output,
  accepted-subset, policy, or destination change creates a new record.
- A previously excluded correction can enter a later correction-only
  acceptance after the evidence and replacement are reviewed again.
- Neither record can be represented by marking files reviewed, sending chat,
  saving a preference, choosing a destination, or completing staging.
- Disabled authorization and acceptance controls have visible blocker lists
  with repair links.
- Repeated identical commands reopen the existing immutable authorization or
  acceptance record instead of creating a duplicate.

### Execution And Repeated Actions

- Staging uses the run-authorization tuple as its idempotency key: source SHA,
  inventory revision, representative proposal, run-authorization ID,
  destination identity, rule and preference revisions, and input-manifest hash.
- Destination writing uses the output-acceptance tuple: generated output set,
  output-acceptance ID, destination ID, and accepted write-manifest hash.
- Double activation, reload, and retry cannot create broader generation,
  unaccepted writes, or duplicate runs.
- Cancellation requests are acknowledged immediately, then show `Cancelling`
  until all active units settle.
- A cancellation command remains in the same DOM node and stable action slot
  while pending. It is relabeled `Cancelling`, uses `aria-disabled="true"`,
  ignores repeated activation, and retains focus when it was the invoking
  control. Cancellation never moves focus to a heading or progress row.
- Staging cancellation preserves settled staged artifacts and writes nothing.
  Write cancellation preserves completed accepted writes and exact retained
  destination commits.
- While destination writing is cancelling, no unstarted accepted output begins.
  The interface shows exact completed, active, unstarted, and failed or
  rolled-back partitions and the configured commit or rollback boundary at
  which each active unit will settle.
- The interface never invents a commit or rollback default. The configured
  AR-09 boundary and its policy source are visible before writing, while
  cancelling, and in the cancelled result. An unset required value blocks the
  write contract rather than falling back at runtime.
- Destination-write cancellation preserves the immutable output acceptance and
  full accepted manifest. The write-run checkpoint records actor, timestamp,
  exact retained commits, per-output dispositions, the applied boundary, and
  the hash of the remaining accepted manifest.
- Staging retry defaults to failed and unstarted inputs under the same
  authorization. Write retry defaults to failed and unstarted accepted output.
  The user reviews each reduced manifest before starting it.
- Resume after user cancellation uses the same output-acceptance idempotency
  tuple and a reviewed reduced manifest containing only accepted outputs not
  already completed. It cannot repeat completed writes, widen acceptance, or
  add newly generated output.
- Finishing without resume produces a distinct `Destination write cancelled`
  completion handoff. It does not reuse the partial-failure status.
- Destination write results identify exact commits per batch if the
  implementation cannot commit atomically.
- Returning to preview after completion opens immutable historical output.

## Hover, Pointer, And Touch Behavior

- No information or command is available only on hover. Hover may preview an
  evidence target or reveal secondary icon controls that are also reachable on
  focus and touch.
- Unfamiliar icons have tooltips that appear on hover and keyboard focus.
  Tooltips do not contain interactive content.
- Diff lines may highlight on hover or focus, but selection is explicit and
  persists after the pointer moves.
- Pointer selection of a file, change, filter, or evidence source does not
  trigger run authorization, output acceptance, durable preference promotion,
  or execution.
- Touch uses the same explicit selection and confirmation sequence as keyboard
  and pointer input. Swipe gestures may supplement tab or sheet navigation but
  never replace visible controls.
- Long press is not required for any command. Context menus have equivalent
  visible menu buttons.
- Hover, pressed, selected, focused, disabled, loading, and error states do not
  resize their controls or shift adjacent content.

## Motion And Reduced-Motion Behavior

- The interface honors `prefers-reduced-motion: reduce` at initial load and
  reacts to changes during the session.
- With reduced motion active, panel, sheet, drawer, tab, diff-highlight,
  progress, and completion transitions are immediate. Smooth scrolling,
  animated progress stripes, pulsing, parallax, and decorative motion are
  removed.
- Progress remains understandable through phase text, settled counts, and
  semantic status values. Motion is never the only signal for loading,
  cancellation, stale state, retry, completion, or error.
- Reduced motion does not suppress polite live-region updates, visible focus,
  loading skeleton meaning, or state changes.
- A preference change updates future nonessential transitions in place. It
  does not restart work, change an immutable record, move focus, or discard the
  user's reading position.

## Responsive Layout

| Viewport | Layout |
| --- | --- |
| 1200 CSS px and wider | Three panes: 248-304 px navigator, flexible workspace, 320-400 px evidence or agent panel |
| 768-1199 CSS px | Two panes: collapsible navigator plus workspace; evidence and agent use a right drawer |
| Below 768 CSS px | One pane with Files, Changes, Evidence, and Agent tabs; authorization, acceptance, and manifests use full-screen sheets |
| 320 CSS px at 200 percent zoom | Single-column reflow; unified diff; only bounded code regions scroll horizontally |

Responsive behavior:

- Context identity wraps before truncating repository and branch names.
- Long paths use middle truncation visually, retain a full accessible name, and
  provide copy.
- Tables become labeled definition rows or horizontally scrollable bounded
  regions. Authorization and acceptance manifests prefer stacked rows, not a
  page-wide table.
- Sticky headers and actions reserve layout space and do not cover focused
  content.
- Opening a mobile sheet preserves the underlying selected file and returns
  focus to its invoking control when closed.
- Touch targets are at least 24 by 24 CSS pixels with sufficient spacing, and
  primary mobile actions use larger product-system targets.

## Keyboard And Focus Behavior

- A skip link moves to the primary workspace. Landmarks identify header,
  workflow navigation, file navigation, main content, evidence, and agent panel.
- Tab and Shift+Tab follow visual decision order. Focus never enters disabled
  controls.
- A semantic tree, if required, supports Arrow keys, Home, End, Enter, and
  Space according to the ARIA treeview pattern. Use a nested list when tree
  interaction does not add value.
- Diff controls expose previous and next change commands as buttons. They do
  not depend on undocumented shortcuts.
- Opening a dialog or sheet moves focus to its heading or first useful
  descriptive element. Closing returns focus to the invoking control.
- Broad-scope and cancellation dialogs place initial focus on descriptive text
  or the least consequential action.
- Error summaries receive focus only after user submission. Each error links to
  its field or blocker.
- Loading, cancellation, stale-source, retry, and completion updates use a
  polite status live region without moving focus.
- When an activating cancellation control changes to `Cancelling`, the same
  aria-disabled button remains focused in its stable action slot. Settling to
  `Cancellation complete` also does not move focus.
- Safety halts and authorization- or acceptance-invalidating changes use an
  assertive alert once, followed by ordinary navigable detail.
- Focus indicators remain visible and unobscured by sticky context bars,
  drawers, chat composers, or mobile action rows.
- When a focused virtualized row leaves the viewport because of filtering, move
  focus to the filter summary, not an arbitrary row.

## Screen-Reader Semantics

- Safety state, source identity, proposal revision, run-authorization scope,
  generated output set, and output-acceptance scope are text, not decorative
  badges without names.
- Diff lines expose addition, removal, correction, context, file, line, and
  symbol labels. Color is supplemental.
- A concise change summary precedes the raw diff.
- Evidence controls name their source, such as `Open implementation evidence
  for Client.connect`.
- File review progress announces `4 of 7 files reviewed`, not only a progress
  bar value.
- Status announcements are coalesced by phase or meaningful count change.
  Streaming tokens are not individually announced.
- Charts are not required. Counts and status distributions use semantic text
  and tables.
- Truncated visual text retains the complete accessible name.

## Long Content And Scale

- Repository inventory is asynchronous and resumable. Stable totals distinguish
  discovered, classified, failed, and remaining entries.
- Large repositories use chunked traversal. Provider truncation is a blocking
  state, never a success state.
- Large file lists and manifests use virtualization without dropping search,
  selection, review state, or assistive metadata.
- Diffs render a bounded initial region and support symbol, change, and path
  navigation. Large unchanged regions remain collapsed by default.
- Extremely large files, binaries, submodules, symlinks, LFS pointers, and
  malformed files receive explicit non-previewable states.
- Long unbroken tokens wrap where valid or scroll within the code region. They
  never overlap controls.
- Agent and build logs are paginated or streamed in bounded groups, preserve a
  stable reading position, and default to summaries over raw output.

## Loading, Empty, Error, And Interruption Behavior

- Skeletons preserve the final panel dimensions and never substitute for
  status text.
- Known work shows current phase, settled counts, and cancel availability.
- Empty-by-filter and empty-by-success states use different copy and actions.
- Errors preserve form values, chat drafts, selected files, filters, review
  progress, and completed checkpoints where the record remains valid.
- Panel-level errors do not erase valid neighboring evidence.
- Reload and relaunch restore preview, proposal, run authorization, generated
  output, output acceptance, and active runs by immutable IDs. Restoration
  never creates a new generation, acceptance, or write record.
- A changed policy or permission shows the exact affected action and preserves
  read-only inspection where allowed.
- Network interruption does not optimistically report a save, authorization,
  acceptance, cancellation, retry, or write. Pending commands settle visibly
  after reconnection.

## Privacy, Authorization, And Audit

- Source access requests only repository metadata and content read permission.
- Destination write authority is acquired separately after output acceptance.
- Private source, prompts, proposals, renders, and artifacts are tenant
  isolated and available only to authenticated authorized users.
- General logs, analytics, browser console output, errors, and support exports
  exclude tokens, private keys, detected secrets, full private files, and full
  prompts.
- Audit events record access grant and revoke, source freeze, inventory,
  representative replacement, proposal revision, preservation-ledger events,
  preference promotion or revoke, run authorization, staged generation,
  correction quarantine and exclusion, output acceptance, cancellation, retry,
  destination write, completion, and cleanup.
- The UI displays the active retention policy and deletion state for source
  snapshots, prompts, proposals, renders, and audit evidence.
- For every retained artifact class, the UI also displays whether a legal hold
  applies, the hold ID and scope, configured authority, effective time, and the
  configured release or review path. A held artifact's delete action is
  unavailable with the legal-hold reason next to the control; it is never
  reported as deleted or deletion-pending.
- Releasing a legal hold does not delete content automatically. It updates the
  lifecycle record and restores deletion only when the configured retention
  policy otherwise permits it.
- Retained audit evidence uses IDs, SHAs, hashes, counts, classifications, and
  bounded redacted excerpts where possible.

## Architecture Inputs That Must Remain Explicit

The design does not invent defaults for the following policy or system values.
`DEVD-1568` must resolve them. The UI consumes the configured value and displays
it where the user makes the affected decision.

| ID | Architecture input | UI dependency |
| --- | --- | --- |
| AR-01 | Repository, file, diff, and render size limits | Inventory truncation, non-previewable state, scope blockers |
| AR-02 | Private-content retention defaults, deletion SLA, legal-hold authority and scope, and hold release or review workflow | Setup disclosure, artifact management, held-deletion state, completion |
| AR-03 | Qualcomm second-person review policy | Repository-scope run authorization and output acceptance states |
| AR-04 | Allowed durable preference scopes and editors | Preference confirmation and management |
| AR-05 | Authenticated rendered-preview host and asset authorization | Render links, private preview access |
| AR-06 | Source-read and destination-write credential isolation mechanism | Permission summary and source-safety proof |
| AR-07 | Process for adding a new supported documentation profile | Unsupported-profile next action |
| AR-08 | Inventory and representative-preview performance SLOs | Progress status, timeout, and escalation copy |
| AR-09 | Commit batching and rollback boundary | Destination-write progress, cancellation, partial failure, retry, completion |
| AR-10 | Audit export signing and retention | Downloaded run authorization, output acceptance, preservation ledger, and source-safety records |
| AR-11 | Preservation-ledger identity, source-location normalization, evidence retention, and disposition event schema | Per-file ledger, counts, correction quarantine, completion handoff |
| AR-12 | Isolation boundary for staged generation and transaction boundary from output acceptance to destination write | No-write staging label, generated output set, correction-only reacceptance, accepted write manifest |

An unset required architecture value is a build-time contract failure, not a
runtime fallback to a guessed product default.

## Visual Evidence Required From Engineering And QA

Capture the exact revision, account, repository, source SHA, representative
proposal revision, run-authorization ID, staging-run ID, generated-output-set
ID, output-acceptance ID, destination-write-run ID, and preservation-ledger
revision with each applicable evidence set.

Minimum design-conformance evidence:

1. Desktop source setup with source-read and destination-write boundaries.
2. Complete inventory with profile grouping, exclusions, and representative
   rationale.
3. Partial or truncated inventory with full-repository run authorization
   blocked.
4. Representative proposal review labeled `Samples only`, showing an addition,
   a separately labeled correction, truth evidence, and rendered route/sidebar
   impact.
5. Representative per-file preservation ledger showing retained,
   incorporated, correction-proposed, and excluded rows with source locations,
   evidence, and reconciled counts.
6. Agent refinement producing a candidate revision while the current
   run-authorization candidate remains unchanged.
7. Preference ledger before and after explicit durable promotion.
8. Profile and repository run-authorization manifests showing exact inputs,
   exclusions, rules, preferences, pending ledger coverage, destination
   identity, and explicit `Not generated` output fields.
9. File output acceptance and broad generated-output acceptance showing exact
   additions, routes, hashes, truth results, preservation dispositions,
   exclusions, and a separate correction subset.
10. A non-representative false or stale comment moving from staging discovery
    to correction quarantine, exclusion with original unchanged, and later
    correction-only acceptance.
11. Stale source, run-authorization invalidation, and output-acceptance
    invalidation states.
12. Staging running, cancelling, cancelled, partial-failure, and reduced-retry
    states with no destination writes.
13. Destination authorization, writing, partial-failure, cancelling, cancelled,
    and accepted-write resume states, including completed, active, and unstarted
    partitions, exact retained commits, the configured commit or rollback
    boundary, immutable acceptance and accepted-manifest hashes, and the reduced
    resume manifest.
14. Completion with destination branch or PR, linked preservation ledger,
    correction decisions, source-safety proof, and a distinct user-cancelled
    handoff with exact retained commits and remaining accepted outputs.
15. The primary Preview, Authorize, Generate, Accept, and destination-write
    cancellation surfaces at wide desktop, 768 CSS pixels, 320 CSS pixels, and
    200 percent zoom.
16. Keyboard focus on file navigation, diff navigation, agent panel,
    run-authorization and output-acceptance confirmations, correction
    quarantine, cancel dialogs, and return from each modal or sheet.
17. Screen-reader output distinguishing samples, pending analysis, additions,
    corrections, preservation dispositions, exclusions, unresolved truth
    results, phase changes, errors, and completion.
18. Destination cancellation by keyboard showing dialog focus return, the same
    focused control relabeled `Cancelling` and aria-disabled, a concise polite
    announcement, no focus move during settling, and the settled
    `Cancellation complete` action slot.
19. Reduced-motion behavior at initial load and after an in-session media-query
    change, proving that nonessential transitions and animated progress stop
    while status, focus, and every command remain available.
20. Retention and deletion for held and unheld artifact classes, including
    visible hold ID, scope, authority, effective time, release or review path,
    blocked held deletion, hold-release audit event, and restored eligible
    deletion without automatic content removal.

No screenshot of an API response, partial panel, or static mock alone proves the
complete persisted workflow. QA must reload or relaunch and confirm restored
proposal, preference, run authorization, staging run, generated output set,
output acceptance, preservation ledger, and destination-write state through the
product surface.

## Acceptance And Research Traceability

| Requirement | Designed evidence |
| --- | --- |
| Enter and validate repository, ref, and destination | W1; AC-01 through AC-14 |
| Authorization, inaccessible, invalid-ref, empty, and unsupported states | AC-03 through AC-11; interaction copy |
| Inventory languages, files, exclusions, generated and vendor content | W2; IN-01 through IN-15 |
| One representative file per detected type with rationale | W2; IN-11 through IN-13 |
| Existing comments, inline docs, metadata, examples, truth evidence, render and sidebar impact | W3; RP-06 through RP-18 |
| Immutable preservation ledger with source locations, evidence, per-file counts, dispositions, and lineage links | Core Records; Preservation Ledger Contract; W3, W6, W7, and W9; RP-17 and RP-18; OA-05 |
| Agent chat, explanation, preference changes, durable record | W4; RF-01 through RF-13 |
| Additions separated from false or stale corrections | W3 and W9; RP-06 and RP-07; OA-02, OA-03, OA-09, and OA-12; correction copy |
| File, file-type or profile, and repository decisions | W5 and W9; AP-01 through AP-13; OA-01 through OA-12 |
| Exact input files, rules, exclusions, and preferences before broad generation | W5; AP-03, AP-04, AP-08, and AP-09 |
| Exact generated output, routes, truth results, preservation dispositions, and correction subset before writes | W9; OA-01 through OA-10 |
| Progress, cancellation, retry, partial failure, stale source, completion | W6, W7, and W10; EX-01 through EX-22 |
| Fork, branch, PR handoff and return to preview | W7; EX-17 and EX-20 |
| Responsive, keyboard, focus, screen reader, reduced motion, long content, loading, empty, error | W8; GL-10; global states and dedicated behavior sections |
| Retention, deletion, and visible legal-hold exceptions | W1 and W7; GL-09; Privacy, Authorization, And Audit; AR-02 |
| Preview cannot be mistaken for generation or destination writing | Three persistent safety labels; two state machines; separate run authorization, output acceptance, and destination authorization |
| Broad run authorization cannot be mistaken for output acceptance | Product Decision; W5 and W9; AP and OA state families; required acknowledgement copy |
| Scope and source safety are unambiguous | W5, W7, and W9; authorization and acceptance tuples; source-safety proof |
| Truth evidence is visible | W3 and W9; per-change evidence inspector and truth dispositions |
| Durable preferences are unambiguous | W4; preference ledger and explicit promotion |
| Architecture mapping is ready | Core records; state machines; AR-01 through AR-12 |

### Parent Acceptance Matrix

This matrix accounts for every acceptance-boundary item in `DEVD-1554`.
`UI` rows are directly designed here. `Non-UI` rows are explicit delivery
contracts: the named authority, downstream owner, and entry and exit evidence
must survive architecture and build planning even when the preview app does not
render the proof itself.

| ID | Parent criterion and classification | Authoritative artifact | Downstream owner | Required entry evidence | Required exit evidence |
| --- | --- | --- | --- | --- | --- |
| PA-01 | Jackson-owned `reference-docs-spec` target repository, `devdocsorg/docs-first` source-repository page and authority rules, and exact revisions for both repositories; Non-UI | `DEVD-1554`; `devdocsorg/docs-first` contribution and page-type rules at exact source revision `637a5bc400f7abb104bf98d07b92e737dc098157`; implementation plan `Authority And Boundaries` | `DEVD-1568` source and target repository boundary; `DEVD-1557` target repository and spec build | Exact `devdocsorg/docs-first` source and implementation-plan revisions, target GitHub owner, distinct repository identities, page-type map, contribution and review rules | Jackson-owned target repository URL and immutable default-branch SHA, exact consumed `devdocsorg/docs-first` source revision, source-rule validation results, authority map, and independent Stage 4 and Stage 5 evidence |
| PA-02 | One-sentence purpose; idiomatic parameter, error, and return docs; examples only for nontrivial values; no boolean, large composed-object, or full setup examples; Non-UI with UI inspection | Implementation plan `Inline Comment Rules`, `Language And Framework Matrix`, and truth-audit gate; W3 metadata inspector | `DEVD-1557` rules and tutorials; `DEVD-1568` contracts; `DEVD-1571` and `DEVD-1572` verification | Versioned rule IDs, language fixtures, allowed and disallowed example cases, truth-evidence schema | Generated corpus audit by language and framework, negative example results, W3 and W9 inspection proof, exact skill and repository revisions |
| PA-03 | Existing comments preserved or incorporated; every false or stale correction separately evidenced and accepted; UI and Non-UI | Implementation plan existing-comment protection and truth-audit gate; this design's Preservation Ledger Contract | `DEVD-1568` ledger and correction contracts; `DEVD-1557` skill behavior; `DEVD-1561` product surface | Source snapshot, comment identity and location rules, original-text hashing, evidence requirements, disposition schema | Complete immutable per-file ledger, reconciled counts, retained and incorporated proof, separate correction acceptance or exclusion, destination diff, source readback |
| PA-04 | Language and framework defaults, unknown-language handling, generated and vendor exclusions, and language-specific tutorials; UI and Non-UI | Implementation plan `Language And Framework Matrix`, `Reusable Skill Shape`, and `Tutorial Set`; W2 inventory behavior | `DEVD-1568` classification contract; `DEVD-1557` defaults and tutorials; `DEVD-1561` inventory UI | Versioned matrix, framework detection evidence, unknown fallback rule, exclusion taxonomy, tutorial inventory | Supported-language fixtures, unsupported and mixed-repository results, generated and vendor exclusion proof, tutorial links and exact revision |
| PA-05 | Sphinx and Markdown workflow creates `docs/tooling` and `docs/content`, builds, exposes every generated reference route in sidebar navigation, passes links, and provides a working README file-path link; Non-UI with UI render projection | Implementation plan `Sphinx And Markdown Static Site Workflow`; parent acceptance boundary | `DEVD-1569` static-site workflow; `DEVD-1568` render contract; `DEVD-1572` clean verification | Exact repository revision, tooling/content path contract, build and link commands, route-to-output mapping, README target | Fresh-checkout build log, `docs/tooling` and `docs/content` tree, route/sidebar inventory, link-check result, README link readback, browser render evidence |
| PA-06 | Workspace skills are repository-sourced, bound additively, and load in a fresh managed task; Non-UI | Implementation plan `Reusable Skill Shape`; parent staged delivery | `DEVD-1559` packaging and bindings; `DEVD-1572` fresh-task proof | Exact source repository and skill SHAs, package manifest, prior binding inventory, additive update plan | Installed package identity, unchanged prior bindings, fresh managed-task skill discovery and invocation evidence, cleanup or durable installation record |
| PA-07 | Qualcomm QLI proof includes a `qualcomm-meta...` repository, exact source and proof revisions, render/sidebar/truth evidence, and no source mutation; Non-UI with source-safety handoff | Implementation plan `Qualcomm QLI Proof Strategy`; W7 source-safety proof | `DEVD-1560` proof fork; `DEVD-1568` repository safety; `DEVD-1571` and `DEVD-1572` verification | Exact Qualcomm source repository IDs and SHAs, destination repository identities including `qualcomm-meta...`, read-only credentials, proof manifest | Exact proof SHAs, branch or PR, render and sidebar routes, truth-audit and preservation ledger, rejected source write, unchanged source-ref readback |
| PA-08 | Preview validates repository, ref, and destination; inventories scope; previews one representative per type; explains and refines proposals; persists explicit preferences; separates corrections; supports one-file, one-type, and repository decisions; UI | `DEVD-1554`; `DEVD-1565`; this design at its reviewed commit | `DEVD-1568` product architecture; `DEVD-1561` app implementation | Passing independent design commit, source and destination policy, record schemas, AP and OA transitions, configured profile rules | Real product evidence for W1 through W9, exact run authorization and output acceptance records for all three scopes, generated output and preservation readback |
| PA-09 | Invalid access, unsupported language, stale source, generated/vendor files, cancellation, retry, partial failure, long content, responsive, keyboard, screen-reader, reduced-motion, legal-hold, and reload/relaunch states pass; UI | This design's complete state inventory and behavior sections, including W10, EX-21 through EX-22, GL-09, and GL-10; research tests in `DEVD-1565` | `DEVD-1561` implementation; `DEVD-1572` independent clean-environment verification | Test matrix mapped to AC, IN, RP, RF, AP, OA, EX, and GL states; destination-write cancellation partitions, stable focus contract, configured boundary, immutable acceptance, retained commits, reduced resume manifest; assistive technology, reduced-motion, legal-hold, and viewport plan | Persisted product journeys, screenshots and accessibility output, cancelling and cancelled reload/relaunch readback, reduced-motion and held-deletion proof, idempotent remaining-write resume, failure recovery, exact fixture cleanup |
| PA-10 | Required checks green, approved changes merged, exact app revision deployed, and real production workflow verified; Non-UI release gate | `DEVD-1554` Stage 4 through Stage 6 contract and workspace SDLC | `DEVD-1571` assurance, `DEVD-1572` acceptance, `DEVD-1573` release | Exact integrated revisions, independent passing verdicts, green required checks, approved production revision and target | Merge SHA, deployment reference for the same revision, current production preview-to-write verification, source immutability proof, structured delivery evidence |
| PA-11 | Stage 7 documentation and reliability loop closes against shipped behavior; Non-UI closure gate | `DEVD-1554` Stage 7; released product records | `DEVD-1574` durable docs; `DEVD-1575` production observation | Exact deployed revision, production verification, known operational and documentation baselines | Documentation at shipped revision, timestamped production journeys and signals, source-push prevention proof, cleaned fixtures, canonical disposition for every discovered gap |

Research acceptance tests map as follows:

| Research test | Design coverage |
| --- | --- |
| SAFE-1 | W1, W7, AC-12, EX-16, source-safety proof |
| SAFE-2 | AC-14, AP-05, EX-19 |
| INV-1 | W2, IN-08 through IN-10, RP-15 |
| INV-2 | IN-04 and IN-05, AP-06 |
| REP-1 | W2, IN-11 through IN-13 |
| TRUTH-1 | W3, RP-08 through RP-11 |
| COMMENT-1 | W3, W9, RP-06, RP-07, RP-17, OA-03, OA-05, and OA-12 |
| PREF-1 | W4, RF-07 through RF-12 |
| APPROVE-1 | W5, W9, AP-01 through AP-13, OA-01 through OA-12 |
| RECOVER-1 | W6, W10, EX-07 through EX-15, EX-21, and EX-22 |
| PRIV-1 | W1, W7, GL-09, Privacy, Authorization, And Audit, AR-02 |
| A11Y-1 | Keyboard And Focus Behavior; Motion And Reduced-Motion Behavior; GL-10 |
| A11Y-2 | Screen-Reader Semantics |
| RESP-1 | W8 and Responsive Layout |
| HANDOFF-1 | W7, W10, EX-17, EX-20, EX-22, preservation ledger, source-safety proof |

## Independent Review Handoff

`DEVD-1567` reviews this artifact independently. A passing verdict must identify
the exact `devdocsorg/docs-first` source-repository commit and verify:

- every state has an entry condition, action set, and exit condition;
- representative preview, run authorization, staged generation, output
  acceptance, and destination writing cannot be conflated;
- profile and repository authorization show exact known inputs and explicitly
  unknown output fields without expanding the representative preview;
- additive comments and corrections remain separate, and a correction
  discovered outside the representative set cannot reach a write without a
  separate acceptance;
- the immutable preservation ledger is complete, count-reconciled, and linked
  through representative review, authorization, generated output, acceptance,
  and completion;
- source safety, truth evidence, durable preferences, exact input manifests,
  generated output sets, accepted write manifests, and correction exclusions
  are visible at their decision points;
- destination-write cancellation has explicit cancelling and cancelled states
  that preserve immutable acceptance, distinguish completed, active, and
  unstarted outputs, show exact retained commits and the configured commit or
  rollback boundary, support idempotent reduced-manifest resume, and retain
  source-safety proof through completion;
- every parent acceptance criterion is represented in the Parent Acceptance
  Matrix, and each non-UI contract has an authority, downstream owner, and
  required entry and exit evidence;
- responsive, accessibility, long-content, interruption, and recovery behavior
  is implementation-ready, including stable cancellation focus, reduced-motion
  behavior, and visible legal-hold exceptions to deletion; and
- `DEVD-1568` receives explicit records, states, transitions, policy inputs, and
  evidence requirements without an unresolved material interaction decision.

A `changes required` verdict returns bounded corrections to `DEVD-1566`. The
same independent review must repeat against the corrected commit. The Product
Designer does not approve this design.
