---
executors: keeper-ae3
maintainers: magic-coordinator, magic-librarian, magic-architect
invitees: none
---
# keeper-ae3.readme-gap.routine — the actual procedure

## Contents

- Summary
  - Goals
  - Scope
- Steps
- Closure steps
- Routine's local procedures
- Routine's local rules
- Routine-specific tooling
  - DistroAgentsTools magic-tooling operations
  - `--console-start` Operation Reference
  - `--console-send` Operation Reference
  - `--member-inbox-reflection-upsert` Operation Reference
- Maintainer Notes
  - Verbatim-goals (intents)
  - Verbatim-tests (benchmarks)
  - Librarian Comments
    - Reference
    - Conventions

# Summary

`keeper-ae3`'s idle-run routine that writes one short, grounded README for an understood AE3 package that has none.

## Goals

- Find a package — an `ae3.*`/`ae3-*` Eclipse project, or a notable sub-package within one — that has no README, or a near-empty one, and would benefit from one. The bar is the same "read and actually understood" standard `keeper-ae3.file-comment-gap.routine` applies: nothing is written until something true and specific can be said about the package. The README covers what the package is and why it is distinct from its siblings — which part of the `sys.pkg.*` taxonomy it fills, what it depends on or is depended on by — never a full manual. One package per pass, cumulative.

## Scope

- Does:
  - Write one short README per pass for a genuinely-understood package that lacks one.
- Doesn't:
  - Write a full manual, or re-touch a package already logged in `processed/`.
  - Backfill a missing `CLAUDE.md`. A missing `CLAUDE.md` beside an *existing* README is a separate convention, filled gradually and incidentally as a side-effect of other work and never as a dedicated sweep — the two are not conflated, and this routine is not used to do that instead.

# Steps

Exact instructions. Execute in order, every step, literally as written — not less, not more. If a step cannot execute as written: escalate it, and never skip it silently.

1. **pick-undocumented-package**: Pick one `ae3.*`/`ae3-*` Eclipse project, or a notable sub-package within one, that has no README or a near-empty one, would benefit from one, and is not already logged in `processed/`.
2. **establish-understanding**: Read the package's own source until something true and specific can be said about it, rules:
   - A package whose purpose is only inferable from its name or its taxonomy position is not understood — pick another.
   - Nothing is written before this step's own bar is met.
3. **write-short-readme**: Write a short README covering what the package is and why it is distinct from its siblings — which part of the `sys.pkg.*` taxonomy it fills, what it depends on or is depended on by — never a full manual.

# Closure steps

1. **log-outcome**: Log the activity and its outcome as a new dated file under `processed/` — `processed/<board-item-type>-<date>-<short-topic>.md`, a real board-item type, never an invented word. Then run this member's own post-activity reflection (`--member-inbox-reflection-upsert`), per `keeper-ae3.armed.md`.

# Routine's local procedures

Named procedure blocks. Steps above call them by name. Not separate routines — not visible outside this file.

None currently defined.

# Routine's local rules

All statements apply at the same time, always. These rules override a participant's own general `.armed.md` rules while this routine is active.

- This routine's own executor (`keeper-ae3`) is permitted and obliged to execute every step exactly as written.
- Participants obey this routine's own rules over their normal `.armed.md` rules while participating.
- The README this routine writes is its own sanctioned output: `keeper-ae3.armed.md`'s read-only-by-default posture for `README.md` does not block **write-short-readme**, and nothing else in the touched package is edited under it.
- The README lands in the `/Volumes/workspace/myx` legacy checkout only, never in an `ae3/*` code-project checkout under `ws-myx.ae3-devel`, per `keeper-ae3.armed.md`'s own edit boundary.
- Each pass advances to a new package — coverage keeps growing, never stalls on a repeat.
- Idle-run scheduling (`weight`, `min-interval`, `scope`) is not set here — it lives in `keeper-ae3.armed.md`'s `## Idle-Tasks` section, which the `daily-idle-task` procedure reads.

# Routine-specific tooling

Every `magic-tooling` operation this routine uses. Full syntax and behavior here. Steps use its name only.

## DistroAgentsTools magic-tooling operations

- `--console-start [--override-workspace <path>] [--console DistroSourceConsole.sh|DistroDeployConsole.sh] [--ttl <seconds>]` (**pick-undocumented-package**, **establish-understanding**: batch the reads)
- `--console-send <channel> [-- <command...>]` (**pick-undocumented-package**, **establish-understanding**)
- `--member-inbox-reflection-upsert <member> <item-filename> [--from-file <path>|--edit-patch-from-stdin]` (**log-outcome**)

## `--console-start` Operation Reference

`DistroAgentsTools.fn.sh --console-start [--override-workspace <path>] [--console DistroSourceConsole.sh|DistroDeployConsole.sh] [--ttl <seconds>]` — starts (or reuses) a Keep-Alive console session. Default `--ttl`: 3600 seconds.

## `--console-send` Operation Reference

`DistroAgentsTools.fn.sh --console-send <channel> [-- <command...>]` — sends one command line into an open channel's FIFO. Command-only, not a data-transport.

## `--member-inbox-reflection-upsert` Operation Reference

`DistroAgentsTools.fn.sh --member-inbox-reflection-upsert <member> <item-filename> [--from-file <path>|--edit-patch-from-stdin]` — files a `reflection-*` item into `<member>`'s own inbox.

# Maintainer Notes

Used to check this file's own definitions against its own goals when it is updated, assessed, or tested — resolved against the whole skillset, not this file alone. **IMPORTANT**: not applied during normal work!

## Verbatim-goals (intents)

- A README written here says what the package is and why it is distinct from its siblings, never how it works as a manual would.
- Nothing is written about a package until its source has actually been read.
- This routine is about READMEs alone; a `CLAUDE.md` gap is a different convention and is not closed here.

## Verbatim-tests (benchmarks)

- No understood, README-less package found this pass is a valid, reportable outcome.
- A package with an existing README and no `CLAUDE.md` is not a candidate for this routine.

## Librarian Comments

### Reference

- `keeper-ae3.armed.md`'s `## Idle-Tasks` section — the scheduling policy governing when this routine fires.
- `keeper-ae3.file-comment-gap.routine.md` — the "read and actually understood" bar this routine reuses.

### Conventions

- None beyond this file's own Local rules.
