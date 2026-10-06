---
executors: keeper-ae3
maintainers: magic-coordinator, magic-librarian, magic-architect
invitees: none
---
# keeper-ae3.package-catalog-gap.routine — the actual procedure

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

`keeper-ae3`'s idle-run routine that records one confirmed package-purpose note for a package-taxonomy branch that is not yet catalogued.

## Goals

- The AE3 package taxonomy (`sys.pkg.s4.lcl.*`, `sys.pkg.l2.tgt.*`, `pkg.lib.*`, and the rest) is not catalogued: a package's purpose is learned by reading it, never by pattern-matching its name. When a pass leaves a genuine, grounded understanding of one package's real purpose — not just its name — that understanding is added as a short note to `keeper-ae3.armed.md`'s `# Domain knowledge: confirmed package-purpose notes` section, so the next reader does not rediscover it from scratch. The `ae3.sys.pkg.s4.lcl.jdbc` (`JdbcLocalS4`) entry is the shape: an apparent generic JDBC backend that is in fact unfinished stub code, never wired in.

## Scope

- Does:
  - Add one grounded package-purpose note per pass, drawn from source actually read.
- Doesn't:
  - Record anything inferred from a naming or taxonomy pattern alone.
  - Re-touch a package already logged in `processed/`.

# Steps

Exact instructions. Execute in order, every step, literally as written — not less, not more. If a step cannot execute as written: escalate it, and never skip it silently.

1. **pick-uncatalogued-package**: Pick one package whose real purpose is not yet carried by `keeper-ae3.armed.md`'s `# Domain knowledge: confirmed package-purpose notes` section and is not already logged in `processed/`. A package understood during another pass of this member's own idle work is an equally valid candidate.
2. **establish-purpose-from-source**: Read the package's own source until its real purpose is grounded, rules:
   - A purpose read off the naming pattern or the taxonomy branch alone is not grounded — it is discarded, not recorded with a hedge.
   - Where the source does not settle the purpose, the pass ends with no note rather than a guess.
3. **record-purpose-note**: Add a short note for that package to `keeper-ae3.armed.md`'s `# Domain knowledge: confirmed package-purpose notes` section, naming which class or file carries the fact and what the fact is.

# Closure steps

1. **log-outcome**: Log the activity and its outcome as a new dated file under `processed/` — `processed/<board-item-type>-<date>-<short-topic>.md`, a real board-item type, never an invented word. Then run this member's own post-activity reflection (`--member-inbox-reflection-upsert`), per `keeper-ae3.armed.md`.

# Routine's local procedures

Named procedure blocks. Steps above call them by name. Not separate routines — not visible outside this file.

None currently defined.

# Routine's local rules

All statements apply at the same time, always. These rules override a participant's own general `.armed.md` rules while this routine is active.

- This routine's own executor (`keeper-ae3`) is permitted and obliged to execute every step exactly as written.
- Participants obey this routine's own rules over their normal `.armed.md` rules while participating.
- A note carries its grounding: which class or file the fact was read out of, and what the fact is. Dates, session provenance and verification narration are not written.
- Package-purpose knowledge only grows from source actually read — never invented or guessed to fill a gap.
- Each pass advances to a new package — coverage keeps growing, never stalls on a repeat.
- Idle-run scheduling (`weight`, `min-interval`, `scope`) is not set here — it lives in `keeper-ae3.armed.md`'s `## Idle-Tasks` section, which the `daily-idle-task` procedure reads.

# Routine-specific tooling

Every `magic-tooling` operation this routine uses. Full syntax and behavior here. Steps use its name only.

## DistroAgentsTools magic-tooling operations

- `--console-start [--override-workspace <path>] [--console DistroSourceConsole.sh|DistroDeployConsole.sh] [--ttl <seconds>]` (**pick-uncatalogued-package**, **establish-purpose-from-source**: batch the reads)
- `--console-send <channel> [-- <command...>]` (**pick-uncatalogued-package**, **establish-purpose-from-source**)
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

- A package-purpose note is grounded in source actually read; a taxonomy pattern is never evidence of purpose.
- The catalogue grows one package at a time and never stalls on a repeat.

## Verbatim-tests (benchmarks)

- A pass that reads a package and cannot settle its purpose ends with no note, and that is a valid, reportable outcome.
- A note proposed from the `sys.pkg.*` naming pattern alone is rejected.

## Librarian Comments

### Reference

- `keeper-ae3.armed.md`'s `## Idle-Tasks` section — the scheduling policy governing when this routine fires.
- `keeper-ae3.armed.md`'s `# Domain knowledge: confirmed package-purpose notes` section — where a note lands.

### Conventions

- None beyond this file's own Local rules.
