---
executors: keeper-ae3
maintainers: magic-coordinator, magic-librarian, magic-architect
invitees: none
---
# keeper-ae3.file-comment-gap.routine — the actual procedure

# Summary

`keeper-ae3`'s idle-run routine that adds one grounded file-header comment to an understood AE3-framework class that lacks one.

## Goals

- Pick one class in the AE3 framework tree that has been read and actually understood but lacks a good comment, and add a short file-header comment stating *why this file is distinct from all the others* — its specific reason for existing, the non-obvious thing about it — never how it works line-by-line and never a restatement of the interface it implements. One file per pass, cumulative.

## Scope

- Does:
  - Add one grounded distinctness comment per pass to a genuinely-understood class.
- Doesn't:
  - Comment how the file works line-by-line, restate the interface it implements, or re-touch a file already logged in `processed/`.
  - Advance or block the separate, longer-term legacy-migration effort outside this keeper's own scope — purely about legibility of the current, still-live tree.

# Steps

Exact instructions. Execute in order, every step, literally as written — not less, not more. If a step cannot execute as written: escalate, or fail loud.

1. **pick-understood-class**: Pick one class in the AE3 framework tree that has been read and actually understood, lacks a good comment, and is not already logged in `processed/`, rules:
   - Understanding comes from reading the class and its own dependencies, never from its name or its package's taxonomy position.
   - A class that cannot be described in one specific, true sentence is not understood — pick another.
2. **add-distinctness-comment**: Add a short file-header comment stating *why this file is distinct from all the others* — its specific reason for existing, the non-obvious thing about it — never line-by-line mechanics and never a restatement of the interface it implements.

# Closure steps

1. **log-outcome**: Log the activity and its outcome as a new dated file under `processed/` — `processed/<board-item-type>-<date>-<short-topic>.md`, a real board-item type, never an invented word. Then run this member's own post-activity reflection (`--member-inbox-reflection-upsert`), per `keeper-ae3.armed.md`.

# Routine's local procedures

Named procedure blocks. Steps above call them by name. Not separate routines — not visible outside this file.

None currently defined.

# Routine's local rules

All statements apply at the same time, always. These rules override a participant's own general `.armed.md` rules while this routine is active.

- This routine's own executor (`keeper-ae3`) is permitted and obliged to execute every step exactly as written.
- Participants obey this routine's own rules over their normal `.armed.md` rules while participating.
- The comment lands in the `/Volumes/workspace/myx` legacy checkout only, never in an `ae3/*` code-project checkout under `ws-myx.ae3-devel`, per `keeper-ae3.armed.md`'s own edit boundary.
- Each pass advances to a new file — coverage keeps growing, never stalls on a repeat.
- Idle-run scheduling (`weight`, `min-interval`, `scope`) is not set here — it lives in `keeper-ae3.armed.md`'s `## Idle-Tasks` section, which the `daily-idle-task` procedure reads.

# Routine-specific tooling

Every `magic-tooling` operation this routine uses. Full syntax and behavior here. Steps use its name only.

## DistroAgentsTools magic-tooling operations

- `--console-start [--override-workspace <path>] [--console DistroSourceConsole.sh|DistroDeployConsole.sh] [--ttl <seconds>]` (**pick-understood-class**: batch the reads)
- `--console-send <channel> [-- <command...>]` (**pick-understood-class**)
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

- The comment states the class's reason for existing, never line-by-line mechanics; one class per pass, never a repeat.
- A comment is written only from source actually read — an unread class is never described.

## Verbatim-tests (benchmarks)

- No understood, un-commented class found this pass is a valid, reportable outcome.
- A class whose purpose is inferred from its package-taxonomy name alone is rejected as a candidate.

## Librarian Comments

### Reference

- `keeper-ae3.armed.md`'s `## Idle-Tasks` section — the scheduling policy governing when this routine fires.
- `keeper-ae3.armed.md`'s `ws-myx.ae3-devel` edit boundary — which checkout a comment may land in.

### Conventions

- None beyond this file's own Local rules.
