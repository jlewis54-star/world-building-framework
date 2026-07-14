<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![CI][ci-shield]][ci-url]



<br />
<div align="center">
  <h3 align="center">World-Building Framework</h3>

  <p align="center">
    Cloneable studio bible: treatise, playbook, and empty <code>world/</code> stubs you fill.
    Build a world once. Ship stories, brand, games, and products from the same repo.
    <br />
    <a href="GETTING_STARTED.md"><strong>Start with Getting Started »</strong></a>
    <br />
    <br />
    <a href="examples/demo-world/">Sample world (Harbor Line)</a>
    &middot;
    <a href="https://github.com/jlewis54-star/world-building-framework/issues/new?template=bug_report.yml">Report Bug</a>
    &middot;
    <a href="https://github.com/jlewis54-star/world-building-framework/issues/new?template=documentation.yml">Docs issue</a>
  </p>
</div>



<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#what-this-is-not">What this is not</a></li>
        <li><a href="#kit">Kit</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#clone">Clone</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#status">Status</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



## About The Project

Guided worldbuilding framework (context-as-code: instructions, workflows, constraints). You fill thin stubs under `world/`. Process lives in `playbook/` and `templates/`. Research cited from `theory/`. Shipping instances live under `projects/` and inherit from `world/` without duplicating lore.

Covers four world types: fictional universe, brand/business world, creator IP, tabletop setting. Same canon can feed stories, scripts, products, merch, marketing, social, games, and interactive work.

Primary user: small creative team / studio ops. Tone: dense reference docs. See [`WRITING.md`](WRITING.md) (prefer [`ai/skills/writing-standard`](ai/skills/writing-standard/SKILL.md)).

**How the kit is shaped**

* One `world/` fill path for all world types, with fiction/TTRPG track options
* Thick `templates/` for process; thin `world/` stubs for canon (never copy scaffolds into canon)
* Downstream `projects/` inherit from `world/` by link/cite, not lore paste
* AI prompts and review agents live under `ai/`; humans own final canon
* Validation (`make validate`) gates framework PRs on public `main`

Public `main` ships empty root `world/` stubs. Keep filled canon off this remote: [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).

### What this is not

* Not an app, CMS, or npm package you install and run
* Not a filled sample IP on `main` (Harbor Line is under [`examples/demo-world/`](examples/demo-world/) only)
* Not a place to open PRs that upload your private canon

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Kit

Markdown docs plus optional local checks. No runtime server.

* Markdown canon and process (`world/`, `playbook/`, `templates/`, `theory/`)
* bash + python3 + ripgrep validation ([`VALIDATION.md`](VALIDATION.md), `make validate`)
* Cursor / agent kit under [`ai/`](ai/) ([`AGENTS.md`](AGENTS.md))

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Getting Started

Clone the repo, then follow phases P0 through P5 in [`GETTING_STARTED.md`](GETTING_STARTED.md). Fiction or TTRPG: read [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md) first.

### Prerequisites

Needed only if you run validation (recommended before framework PRs):

* bash
* python3
* ripgrep (`rg`)
* make (optional; `make validate` wraps `./scripts/validate.sh`)

World builders who only fill docs can skip the tooling until they need CI parity.

### Clone

1. Clone the repo
   ```sh
   git clone https://github.com/jlewis54-star/world-building-framework.git
   cd world-building-framework
   ```
2. Read [`GETTING_STARTED.md`](GETTING_STARTED.md). Start at **P0**.
3. If you will fill real canon, set a private remote first:
   [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).
4. Optional: confirm the clone is healthy
   ```sh
   make validate
   # or: ./scripts/validate.sh
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Usage

### Five-minute start

1. Thin stubs already sit in `world/`. Replace `_fill_` sections. Do **not** copy thick `templates/` into `world/` to reset.
2. Root `world/` is **your** empty stubs. Do **not** copy prose from [`examples/demo-world/`](examples/demo-world/) (Harbor Line) into `world/`. Read the demo for fill density only.
3. **P0:** Set world profile in [`world/00_governance/01_governance_ledger.md`](world/00_governance/01_governance_ledger.md) (type, hard/soft dial, owners).
4. **P1:** Fill [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md) and [`world/10_foundations/12_lore_canon.md`](world/10_foundations/12_lore_canon.md).
5. **P2 to P3:** Identity systems, then brand and channel (fiction/TTRPG may defer P3: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)).
6. **P4:** Copy scaffold to `projects/YYYY-MM-slug/`. Examples: [`examples/demo-project/`](examples/demo-project/).

Doc triad (stub, template, prompt): [`world/README.md`](world/README.md).

AI workflows: [`AGENTS.md`](AGENTS.md) and [`ai/`](ai/).

### Reset a world doc

Restore the committed thin stub (git checkout / discard local changes). Templates stay thick for process. World stays thin for canon.

### What lives where

| Path | Role |
| --- | --- |
| `theory/` | Research treatise. Cite. Not your canon. |
| `playbook/` | Process: world types, sequencing, shipping audit, notes→canon. |
| `templates/` | Thick scaffolding: Purpose, APPLIES, Theory, Example, prompt links, Review Checklist. Never fill as lasting canon. |
| `world/` | Thin stubs you fill. Where filled canon will live. Frontmatter + fill sections only. |
| `projects/` | Shipping outputs. Inherit from `world/`. Do not duplicate lore. |
| `ai/` | Prompts, agents, vendored skills. |
| `examples/` | Demo world and notes scratch (non-authoritative). |
| `WRITING.md` | Writing standard entry point. |
| `reference/voice.md` | Shared prose rules (interaction + drafting). |
| `CONVENTIONS.md` | Naming, canon versioning, contribution, spinoffs. |
| `VALIDATION.md` | Markdown validation before merge. |
| `CONTRIBUTING.md` | How to PR; keep your world IP private. |
| `SECURITY.md` | Vulnerability reporting. |
| `playbook/public-repo-governance.md` | GitHub Settings checklist for maintainers. |
| `playbook/private-world-workflow.md` | Keep filled canon off public `main`. |

### Reading track (new collaborators)

1. [`GETTING_STARTED.md`](GETTING_STARTED.md) and [`playbook/world-types.md`](playbook/world-types.md)
2. [`world/README.md`](world/README.md): empty stubs; do not paste demo prose into `world/`
3. [`examples/demo-world/README.md`](examples/demo-world/README.md), then [`examples/demo-world/`](examples/demo-world/) for fill density only (Harbor Line is sample-only)
4. [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md) (your stub to fill)
5. Fiction/TTRPG: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)
6. Theory: [`theory/`](theory/) when playbook cites it (not day one)

Orientation lives here and in `GETTING_STARTED.md`. Not duplicated into each world doc.

### Golden rule

Never create a new document if an edit to an existing one works. New docs only for distinct shipping outputs under `projects/`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Status

Shipped on public `main`:

- [x] Thin `world/` stubs + thick `templates/` split
- [x] Guided phases P0 through P5 ([`GETTING_STARTED.md`](GETTING_STARTED.md))
- [x] Fiction / TTRPG tracks
- [x] AI prompts, agents, and writing-standard skill
- [x] `make validate` CI on pull requests
- [x] Public-repo governance and private-world workflow
- [x] Harbor Line sample under [`examples/demo-world/`](examples/demo-world/)

Proposed work and docs gaps: [open issues](https://github.com/jlewis54-star/world-building-framework/issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contributing

Framework changes: branch → PR → green `validate` → squash merge. Details: [`CONTRIBUTING.md`](CONTRIBUTING.md) and [`playbook/public-repo-governance.md`](playbook/public-repo-governance.md).

Do not open PRs that fill root `world/` with private canon. Use [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).

### Clone, fork, or collaborator?

| Method | What it is | Who uses it | Can they change this repo's `main`? |
| --- | --- | --- | --- |
| **Clone** | Copy to your machine (`git clone`). Work locally. | You, teammates, anyone building a private world | Only if you gave them **Write** access |
| **Fork** | Your own copy on GitHub, linked to upstream. | Open-source contributors, strangers | No. They push to **their** fork and open a **pull request** to you |
| **Collaborator** | You invite their GitHub account in Settings → Collaborators. | Teammate with Write access | Yes, but only through a **PR** (branch protection). Force-push to `main` is blocked |

**Recommended for most contributors:** clone (or duplicate into a private repo). Grant Write collaborator access only when someone needs to merge framework changes here.

**Recommended for maintainers:** branch → PR → merge when `validate` CI is green. Same gate as everyone else.

**Outside contributors:** fork → PR. Review and merge when CI is green.

```sh
# Framework contributor flow
git checkout -b fix/short-description
# edit, then:
make validate
git add -A && git commit -m "Clear why message."
git push -u origin HEAD
# open a PR on GitHub against main
```

### Top contributors

<a href="https://github.com/jlewis54-star/world-building-framework/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=jlewis54-star/world-building-framework" alt="contributors" />
</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contact

Josh - [jlewis54-star](https://github.com/jlewis54-star)

Project Link: [https://github.com/jlewis54-star/world-building-framework](https://github.com/jlewis54-star/world-building-framework)

Security reports: [`SECURITY.md`](SECURITY.md) (prefer GitHub private vulnerability reporting).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Acknowledgments

* [Best-README-Template](https://github.com/othneildrew/Best-README-Template) (README structure)
* [Img Shields](https://shields.io)
* [contrib.rocks](https://contrib.rocks)
* Harbor Line demo under [`examples/demo-world/`](examples/demo-world/) (sample density only)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/jlewis54-star/world-building-framework.svg?style=for-the-badge
[contributors-url]: https://github.com/jlewis54-star/world-building-framework/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jlewis54-star/world-building-framework.svg?style=for-the-badge
[forks-url]: https://github.com/jlewis54-star/world-building-framework/network/members
[stars-shield]: https://img.shields.io/github/stars/jlewis54-star/world-building-framework.svg?style=for-the-badge
[stars-url]: https://github.com/jlewis54-star/world-building-framework/stargazers
[issues-shield]: https://img.shields.io/github/issues/jlewis54-star/world-building-framework.svg?style=for-the-badge
[issues-url]: https://github.com/jlewis54-star/world-building-framework/issues
[license-shield]: https://img.shields.io/github/license/jlewis54-star/world-building-framework.svg?style=for-the-badge
[license-url]: https://github.com/jlewis54-star/world-building-framework/blob/main/LICENSE
[ci-shield]: https://img.shields.io/github/actions/workflow/status/jlewis54-star/world-building-framework/validate.yml?branch=main&style=for-the-badge&label=validate
[ci-url]: https://github.com/jlewis54-star/world-building-framework/actions/workflows/validate.yml
