# MAGIC.md — util.repository-ae3

Team-owned (magic-* team), read/write. Repo-specific findings for `util.repository-ae3` itself — see this directory's own `README.md`/`CLAUDE.md` for human/other-team content, read-only to us by default.

## For keeper-ae3

- **Package role**: `project.inf` declares `Type: ae3.Package`, `Info: Repository actions package (with repository installer)`. It declares a `distro-image-sync:source-prepare-pull` hook against its own remote (`git@github.com:A-E-3/util.repository-ae3.git`), pointing at `sh-data/repository/remotes-list-ae3.txt` as the checkout list and `sh-scripts/sync-all-sources-ae3.sh` as the async sync runner — same `myx.distro-*` pipeline-integration shape as `util.repository-ndm`/`util.repository-mel`. `sh-scripts/install-ae3-repository.sh` and `sh-scripts/install-myx.ae3-devel-workspace.sh` are the standalone bootstrap installers for an unprepared machine.
- **Checkout-list composition** (`sh-data/repository/remotes-list-ae3.txt`, 48 lines): three namespace roots, not just `ae3` — 20 `ae3/*` repos (org `A-E-3`), plus 4 `myx/clean-java.*` repos and 3 `lib/lib.*` repos. The 20 `ae3/*` entries match exactly the directories checked out under `source/ae3/` in this workspace.
- **Ownership split**: `keeper-ae3` owns the `ae3/*` portion of this repo/workspace — the 20 repos this file's `ae3/` section lists (Domain anchor: `ws-myx.ae3-devel` entry, Namespace family `ae3`). The `myx/clean-java.*` and `lib/lib.*` entries this same file also syncs belong to other namespaces' own stewards, not `keeper-ae3`.
