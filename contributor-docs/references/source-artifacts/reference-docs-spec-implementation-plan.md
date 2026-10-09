---
page_type: reference
---

# Reference Docs Spec Implementation Plan

This plan defines the first executable specification for the
`reference-docs-spec` repository. It translates the accepted member request,
the Docs Coding Framework in the source repository `devdocsorg/docs-first`,
and the Aptos reference-docs notebook into a target repository and reusable
agent-skill workflow.

The Aptos notebook is only workflow inspiration. It demonstrates useful phases:
scan source files, model symbols and imports, preserve a reviewable copy,
categorize files for navigation, and connect inline comments to a rendered
reference site. The new workflow must not copy its API-style comment generation
approach, must not hard-code Aptos categories, and must not delete existing
comments as a normal update strategy.

## Authority And Boundaries

`devdocsorg/docs-first` is the source repository and the authority for the page
types, ontology, contribution rules, review rules, and documentation
architecture used by this plan. The target-facing rules in this plan are
derived from exact protected source revision
`637a5bc400f7abb104bf98d07b92e737dc098157`.

`reference-docs-spec` is the distinct target repository under Jackson's GitHub
account. It consumes the source-repository contracts above and owns only the
accepted reference-docs product workflow, reusable skills, tutorials,
references, verification contracts, and product-specific architecture. It is
not an alias for `devdocsorg/docs-first`, the intake repository for raw
examples, or an implementation repository for a single target codebase.

Keep these authorities separate:

- Source examples, full notebook copies, chat transcripts, and proof-repository
  observations belong in intake or contributor-only provenance records.
- Current accepted product-specific behavior belongs in the Jackson-owned
  `reference-docs-spec` target repository.
- Code changes to a Qualcomm QLI proof repository happen only in a fork or
  review branch outside the source repository.
- Cross-product page-type, ontology, contribution, review, and documentation
  architecture rules stay in the `devdocsorg/docs-first` source repository
  unless they are specific to the reference-docs product.

## Repository Layout

Create `reference-docs-spec` with this layout:

```text
reference-docs-spec/
|-- README.md
|-- product-docs/
|   |-- index.md
|   |-- workflows/
|   |   |-- index.md
|   |   |-- add-inline-reference-docs.md
|   |   `-- build-static-reference-site.md
|   `-- concepts/
|       |-- index.md
|       `-- reference-docs-workflow.md
|-- contributor-docs/
|   |-- index.md
|   |-- repository-scope.md
|   |-- architecture/
|   |   |-- index.md
|   |   |-- source-analysis-model.md
|   |   |-- docs-site-output-model.md
|   |   `-- skill-execution-contract.md
|   |-- skills/
|   |   |-- index.md
|   |   |-- inline-reference-docs/
|   |   |   |-- index.md
|   |   |   |-- SKILL.md
|   |   |   `-- references/
|   |   |       |-- language-framework-matrix.md
|   |   |       |-- inline-comment-rules.md
|   |   |       `-- truth-audit-checklist.md
|   |   `-- sphinx-markdown-site/
|   |       |-- index.md
|   |       |-- SKILL.md
|   |       `-- references/
|   |           |-- docs-folder-layout.md
|   |           |-- sidebar-render-checks.md
|   |           `-- readme-link-requirement.md
|   |-- tutorials/
|   |   |-- index.md
|   |   |-- bootstrap-docs-folder.md
|   |   |-- add-inline-comments-to-codebase.md
|   |   |-- document-env-and-config-files.md
|   |   |-- build-sphinx-markdown-site.md
|   |   `-- languages/
|   |       |-- index.md
|   |       |-- typescript-and-javascript.md
|   |       |-- python.md
|   |       |-- java.md
|   |       |-- kotlin.md
|   |       |-- swift.md
|   |       |-- csharp.md
|   |       |-- go.md
|   |       |-- rust.md
|   |       |-- c-and-cpp.md
|   |       |-- ruby.md
|   |       |-- php.md
|   |       |-- scala.md
|   |       |-- lua.md
|   |       `-- shell.md
|   |-- references/
|   |   |-- index.md
|   |   |-- accepted-source-summary.md
|   |   |-- extension-language-detection.md
|   |   |-- verification-commands.md
|   |   `-- qualcomm-qli-proof-strategy.md
|   `-- audits/
|       |-- index.md
|       |-- inline-comment-truth-audit.md
|       |-- sidebar-render-audit.md
|       `-- proof-fork-audit.md
`-- examples/
    |-- index.md
    `-- minimal-repository/
        |-- README.md
        `-- docs/
            |-- tooling/
            `-- content/
```

Every Markdown page must declare a `page_type`. Use:

- `overview` for folder routing pages.
- `tutorial` for procedures that produce a result.
- `concept` for explanatory models readers need before choosing actions.
- `reference` for exact rules, matrices, commands, checklists, schemas, and
  reusable skill contracts.

Do not publish raw provenance or source-history notes as product-facing pages.
If a source summary is useful to contributors, keep it concise and link from
contributor documentation rather than product documentation.

## Reusable Skill Shape

The repository must define reusable DevDocs skill source, not a one-off script.
Each skill directory contains:

- `SKILL.md` with the entry contract, when to use it, required inputs, output
  artifacts, verification commands, and stop conditions.
- `references/` files for rules the skill must load progressively.
- tutorial links showing a human or agent how to perform the workflow manually.
- audit checklists that make completion falsifiable.

The inline-reference-docs skill must accept:

- repository path or GitHub repository URL;
- target revision or branch;
- language scope, or `all-supported-languages`;
- generated/vendor exclusion rules;
- docs-site destination policy;
- whether a fork, branch, or local-only result is required.

The skill must output:

- changed files or a review branch;
- source inventory;
- existing-comment preservation ledger;
- generated or authored inline documentation;
- truth-audit results;
- docs-site routing map;
- verification command results.

The Sphinx/Markdown static-site skill must accept:

- repository path;
- docs title and landing-page label;
- source reference-doc paths to expose;
- sidebar grouping policy;
- README link destination.

It must output:

- `docs/tooling` Sphinx/MyST setup;
- `docs/content` generated site output;
- README file-path link to the rendered output;
- render, sidebar, and link-check evidence.

## Language And Framework Matrix

Use this default matrix unless the target repository already documents a
different idiomatic framework.

| Language or file kind | Default framework | Primary file detection |
| --- | --- | --- |
| TypeScript | TSDoc with TypeDoc-compatible tags | `.ts`, `.tsx` |
| JavaScript | JSDoc | `.js`, `.jsx`, `.mjs`, `.cjs` |
| Python | PEP 257 docstrings with Sphinx Napoleon Google-style sections | `.py` |
| Java | Javadoc | `.java` |
| Kotlin | KDoc | `.kt`, `.kts` |
| Swift | Swift Markup / DocC-compatible comments | `.swift` |
| C# | XML documentation comments | `.cs` |
| Go | Go doc comments and package docs | `.go` |
| Rust | rustdoc | `.rs` |
| C | Doxygen-compatible comments | `.c`, `.h` |
| C++ | Doxygen-compatible comments | `.cpp`, `.cc`, `.cxx`, `.hpp`, `.hh`, `.hxx` |
| Ruby | YARD | `.rb` |
| PHP | PHPDoc | `.php` |
| Scala | Scaladoc | `.scala`, `.sc` |
| Lua | LuaLS / EmmyLua annotations | `.lua` |
| Shell | shdoc-style function headers and plain comments | `.sh`, `.bash`, `.zsh`, `.fish` |
| Environment and config files | Plain inline comments above keys | `.env`, `.env.example`, `.yaml`, `.yml`, `.toml`, `.ini`, `.json`, `.conf` |

Detection rules:

1. Prefer explicit repository configuration when it identifies a language or
   documentation framework.
2. Use extensions as the default signal.
3. Let shebangs override extension for executable scripts.
4. Treat generated, vendored, lock, minified, and build-output files as excluded
   unless a task explicitly includes them.
5. For unknown languages, preserve existing comments and record a framework gap
   instead of inventing syntax.

When a language framework already exposes parameter, return, or error types
from the source signature, do not duplicate trivial type text solely to satisfy
a template. The rendered reference page must still make the parameter, return,
and error type discoverable.

## Inline Comment Rules

Apply these rules to every supported language:

1. Preserve existing inline comments by default.
2. Incorporate existing comments into the new framework when they are true and
   still helpful.
3. Never delete or overwrite an existing comment unless source evidence proves
   it is false, stale, or contradictory.
4. Record every correction to an existing comment in the preservation ledger,
   including the original text location, reason, source evidence, and new text.
5. Give each documented symbol one sentence that states what the symbol is for.
6. Document parameters, errors or exceptions, and return values in the idiomatic
   framework for the language.
7. Include examples only for nontrivial fields such as strings, arrays, small
   objects, enums, and numbers.
8. Do not include examples for booleans.
9. Do not include examples for large composed objects such as classes that
   compose other classes.
10. Do not include full working-code samples with imports, setup, credentials,
    or environment bootstrapping.
11. Do not invent product behavior, business rules, side effects, permissions,
    error causes, performance promises, or security guarantees.
12. Prefer shorter comments when the code signature already carries the detail.
13. Keep examples local to the symbol and small enough to inspect in the
    rendered reference page.
14. For `.env`, `.env-example`, and config files, use simple comments near the
    key. Do not force a language reference-doc framework onto config files.

## Source Analysis Workflow

The reusable skill implements a source-first workflow:

1. Freeze the target revision and record repository, branch, commit, and
   exclusion rules.
2. Inventory files by language and generated/vendor status.
3. Parse with structured tooling when available: language services,
   Tree-sitter, compiler metadata, doc generators, or repository-native tools.
   Regex may supplement discovery but must not be the sole authority when a
   structured parser is available.
4. Extract symbols, signatures, exports, imports, public interfaces, classes,
   functions, methods, fields, errors, and existing comments.
5. Build a source model that links each comment candidate to the exact symbol
   and evidence used to write it.
6. Categorize files into docs-site groups from repository structure and explicit
   configuration, not from hard-coded product names.
7. Author or update comments from the source model while preserving existing
   comments.
8. Run the truth audit before declaring inline docs complete.
9. Generate or refresh the docs-site inputs and rendered output.
10. Run render, sidebar, README-link, and link checks.

This workflow may use an agent to author comments, but completion depends on the
source model and truth audit. It must not send raw code to an API prompt and
accept generated comments without evidence, review, and audit.

## Truth-Audit Gate

Inline docs are incomplete until the truth audit passes.

For each added, retained, moved, or changed comment, record:

- file path and symbol;
- original comment text when one existed;
- final comment text;
- source evidence used: signature, implementation branch, tests, existing docs,
  configuration, or human-approved rule;
- framework idiom check;
- contradiction check against existing comments and code;
- disposition: `accepted`, `corrected`, `needs-human-review`, or `removed-as-false`.

The audit passes only when:

- every comment says only true things supported by source evidence;
- every comment is idiomatic for the language and documentation framework;
- no comment invents business behavior absent from code or accepted
  specification;
- no comment contradicts another retained comment or the code;
- every removed or overwritten existing comment has documented false/stale
  evidence;
- unresolved comments are excluded from completion and surfaced as follow-up
  work.

## Sphinx And Markdown Static Site Workflow

The static-site skill creates a Sphinx site that uses Markdown authoring through
MyST or an equivalent Sphinx-compatible Markdown parser.

Target repository layout:

```text
docs/
|-- tooling/
|   |-- pyproject.toml
|   |-- conf.py
|   |-- Makefile
|   |-- source/
|   |   |-- index.md
|   |   |-- overview.md
|   |   |-- reference.md
|   |   |-- configuration.md
|   |   `-- api/
|   |       `-- index.md
|   `-- scripts/
|       |-- check_sidebar.py
|       |-- check_readme_docs_link.py
|       `-- export_reference_inputs.py
`-- content/
    |-- index.html
    `-- ...
```

`docs/tooling` owns setup, configuration, authoring source, dependencies, and
build scripts. `docs/content` owns the rendered static output produced by the
build.

Minimum pages:

- `index.md` routes the documentation site.
- `overview.md` explains what the project exposes.
- `reference.md` routes generated or extracted reference material.
- `configuration.md` documents environment and config-file rules.
- `api/index.md` routes language/framework-generated pages.

README requirement:

- The repository root `README.md` must link to the generated docs output by file
  path after the build, for example `docs/content/index.html`.
- The README must also name the command that refreshes that output.
- The README link check must fail when the file path is absent after a build.

Sidebar and render checks:

- Sphinx build exits successfully.
- `docs/content/index.html` exists.
- The sidebar contains `Overview`, `Reference`, `Configuration`, and each
  generated API/reference group.
- Every generated inline-doc output has a visible route from the sidebar.
- Internal links pass.
- A human or browser automation inspection records that the sidebar renders and
  the linked generated pages are reachable.

## Verification Commands

Define these command groups in `contributor-docs/references/verification-commands.md`.
The exact package manager may change, but the repository must provide command
aliases with these names or clearly documented equivalents.

For `reference-docs-spec` itself:

```text
markdown lint over README.md, product-docs, contributor-docs, and examples
link check over all Markdown links
frontmatter check requiring page_type on every published Markdown page
repository layout check for required skill, tutorial, reference, and audit paths
```

For an applied target repository:

```text
source inventory check
existing-comment preservation ledger check
inline comment truth audit
Sphinx HTML build into docs/content
Sphinx or crawler link check
sidebar route check
README docs file-path check
```

For workspace skill packaging:

```text
devdocs skill get <skill-id> --output json
devdocs agent skills list <agent-id> --output json
fresh managed task invocation that loads the skill and reports its entry checklist
```

For a Qualcomm QLI proof fork:

```text
fork or review branch URL
source repository URL and exact source commit
review branch commit
diff summary
truth-audit artifact
Sphinx build log
docs/content output path
sidebar/render evidence
README file-path evidence
statement that the Qualcomm source repository was not mutated
```

## Tutorial Set

Create these tutorials before packaging the workspace skills:

- Bootstrap a repository `docs/` folder.
- Add inline comments to every code file.
- Preserve, incorporate, and correct existing comments.
- Run the truth audit for inline comments.
- Document `.env`, `.env-example`, and config files.
- Build a Sphinx/Markdown static site.
- Verify sidebar routes and rendered output.
- Add the README docs file-path link.
- Package the inline-reference-docs skill as a DevDocs workspace skill.
- Package the Sphinx/Markdown site skill as a DevDocs workspace skill.
- Apply the workflow to a forked proof repository.
- One tutorial per supported language in the language matrix. Each language
  tutorial links to the shared inline comment rules and adds only the syntax and
  idioms specific to that language.

## Qualcomm QLI Proof Strategy

The proof task validates the workflow on open-source Qualcomm QLI material
without mutating a source repository.

Proof selection:

1. Identify the relevant Qualcomm QLI GitHub organization and repository set at
   execution time.
2. Include at least one repository whose name begins with `qualcomm-meta`.
3. Prefer a repository with active source files, existing comments, and enough
   public structure to exercise language detection, inline comments, and static
   docs-site routing.
4. Record why the selected repository is representative and what it does not
   prove.

Execution:

1. Fork under Jackson's account or an approved review namespace.
2. Work on a review branch.
3. Run the source analysis workflow.
4. Apply inline reference comments while preserving existing comments.
5. Run the truth audit and repair failures before building the docs site.
6. Create `docs/tooling` and `docs/content`.
7. Build the Sphinx/Markdown site.
8. Verify sidebar, rendered pages, links, and README file-path link.
9. Push the fork or review branch for inspection.

Completion evidence:

- source repository, fork URL, branch, source commit, and proof commit;
- list of languages detected and framework choices used;
- existing-comment preservation ledger;
- truth-audit summary with any corrections;
- Sphinx build command and result;
- `docs/content` output path;
- sidebar/render evidence;
- README link evidence;
- statement confirming no commits or branches were pushed to the Qualcomm source
  repository.

## Acceptance Evidence For Later Execution

Later execution work is complete only when the durable record includes:

- the exact `devdocsorg/docs-first` source repository URL and revision from
  which page types, ontology, contribution rules, review rules, and
  documentation architecture were derived;
- `reference-docs-spec` repository URL, default branch, and commit SHA;
- this plan, or its accepted successor, committed in that repository;
- required page list and page-type audit;
- language/framework matrix;
- inline comment rules;
- existing-comment preservation rules;
- truth-audit checklist and passing example;
- Sphinx/Markdown static-site skill;
- `docs/tooling` and `docs/content` layout documentation;
- README file-path requirement;
- sidebar/render checks;
- workspace skill IDs and fresh managed-task verification;
- Qualcomm QLI proof fork evidence.

If an execution task discovers that a required source is unavailable, a target
repository cannot be forked, or a workspace skill cannot be imported, record the
exact external prerequisite and keep the blocked work separate from this plan.
