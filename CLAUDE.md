# CLAUDE.md — util.repository-ae3

Tooling for managing the AE3 monorepo-of-repos: each AE3 unit (`ae3.sdk`, `ae3.sys.pkg.base`, `ae3.sys.pkg.l2.tgt.xml`, etc.) is its own separate git repository under the `A-E-3` GitHub org, not a single monolithic repo. This unit is the tooling that clones/manages which of those repos are checked out into a given workspace.

## Where the repo list lives

`sh-data/repository/remotes-list-ae3.txt` — the authoritative list of `<local-path> <git-remote-url>` pairs for a given workspace. Only a *subset* of the full `A-E-3` org's repos are listed here for the `ws-myx.ae3-devel` workspace (e.g. `ae3.sys.pkg.l2.tgt.dhtml`, `ae3.sys.pkg.l2.tgt.html`, and several other `l2.tgt.*`/`i3.*` units seen in the IDE are *not* in this list — they exist as separate repos under the same GitHub org but aren't checked out here). To find or add a repo not currently present in `source/ae3/`, check this file first before assuming it doesn't exist anywhere.

## Consequence for cross-repo investigation

When a class can't be found anywhere under `source/ae3/` (e.g. `ru.myx.ae3.l2.xhtml.XhtmlDomTargetContext`, referenced by `ae3.sys.pkg.i3.web`'s `WebContextXhtml` but not present in any checked-out unit), check `remotes-list-ae3.txt` before concluding it's missing/broken — it very likely just lives in a same-org repo that isn't part of this particular workspace's checkout.
