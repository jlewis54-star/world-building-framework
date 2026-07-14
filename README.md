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
    Cloneable studio bible. Build a world once. Ship from the same repo.
    <br />
    <a href="GETTING_STARTED.md"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="examples/demo-world/">View Demo</a>
    &middot;
    <a href="https://github.com/jlewis54-star/world-building-framework/issues/new?template=bug_report.yml">Report Bug</a>
    &middot;
    <a href="https://github.com/jlewis54-star/world-building-framework/issues/new?template=documentation.yml">Request Docs Fix</a>
  </p>
</div>



<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



## About The Project

Guided worldbuilding framework (context-as-code: instructions, workflows, constraints). Covers fictional universes, brand worlds, creator IP, and tabletop settings. Same canon feeds stories, scripts, products, merch, marketing, social, games, and interactive work.

Primary user: small creative team / studio ops. Tone: dense reference docs. See [`WRITING.md`](WRITING.md) (prefer [`ai/skills/writing-standard`](ai/skills/writing-standard/SKILL.md)).

**Why this shape**

* One `world/` fill path for all world types, with fiction/TTRPG track options
* Thick `templates/` for process; thin `world/` stubs for canon (never copy scaffolds into canon)
* Downstream `projects/` inherit from `world/` without duplicating lore
* AI prompts and review agents live under `ai/`; humans own final canon
* Validation (`make validate`) gates merges on public `main`

Public `main` ships empty root `world/` stubs. Keep filled canon off this remote: [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Markdown][Markdown.com]][Markdown-url]
* [![Python][Python.org]][Python-url]
* [![Bash][Bash.org]][Bash-url]
* [![Make][Make.org]][Make-url]
* Cursor agent kit under [`ai/`](ai/) ([`AGENTS.md`](AGENTS.md))

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Getting Started

Clone, validate, then follow phases P0 through P5 in [`GETTING_STARTED.md`](GETTING_STARTED.md).

### Prerequisites

* bash
* python3
* ripgrep (`rg`)
* make (optional; for `make validate`)

```sh
# Debian/Ubuntu example
sudo apt update && sudo apt install -y bash python3 ripgrep make
```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/jlewis54-star/world-building-framework.git
   cd world-building-framework
   ```
2. Run validation
   ```sh
   make validate
   # or: ./scripts/validate.sh
   ```
3. Read [`GETTING_STARTED.md`](GETTING_STARTED.md). Start at **P0**.
4. If you will fill real canon, set a private remote first:
   [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).

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

### Golden rule

Never create a new document if an edit to an existing one works. New docs only for distinct shipping outputs under `projects/`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Roadmap

- [x] Thin `world/` stubs + thick `templates/` split
- [x] Guided phases P0 through P5 ([`GETTING_STARTED.md`](GETTING_STARTED.md))
- [x] Fiction / TTRPG tracks
- [x] AI prompts, agents, and writing-standard skill
- [x] `make validate` CI on pull requests
- [x] Public-repo governance and private-world workflow
- [ ] More demo density and spinout examples
- [ ] Contributor-facing docs polish from GitHub issues

See the [open issues](https://github.com/jlewis54-star/world-building-framework/issues) for proposed work and known gaps.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Contributing

Framework changes: branch → PR → green `validate` → squash merge. Details: [`CONTRIBUTING.md`](CONTRIBUTING.md).

Do not open PRs that fill root `world/` with private canon. Use [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md).

### Clone, fork, or collaborator?

| Method | What it is | Who uses it | Can they change this repo's `main`? |
| --- | --- | --- | --- |
| **Clone** | Copy to your machine (`git clone`). Work locally. | You, teammates, anyone building a private world | Only if you gave them **Write** access |
| **Fork** | Your own copy on GitHub, linked to upstream. | Open-source contributors, strangers | No. They push to **their** fork and open a **pull request** to you |
| **Collaborator** | You invite their GitHub account in Settings → Collaborators. | Teammate with Write access | Yes, but only through a **PR** (branch protection). Force-push to `main` is blocked |

**Recommended for most contributors:** clone (or duplicate into a private repo). Grant Write collaborator access only when someone needs to merge framework changes here.

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

Josh - [jlewis54-star](https://github.com/jlewis54-star) - j.lewis5451@gmail.com

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

[Markdown.com]: https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white
[Markdown-url]: https://www.markdownguide.org/
[Python.org]: https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white
[Python-url]: https://www.python.org/
[Bash.org]: https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white
[Bash-url]: https://www.gnu.org/software/bash/
[Make.org]: https://img.shields.io/badge/Make-A81D33?style=for-the-badge&logo=cmake&logoColor=white
[Make-url]: https://www.gnu.org/software/make/
