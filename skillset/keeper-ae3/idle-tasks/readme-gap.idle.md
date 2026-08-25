Look for a package (an `ae3.*`/`ae3-*` Eclipse project, or a notable sub-package within one) that has no README (or a near-empty one) and would benefit from one, using the same "read and actually understood" standard as `file-comment-gap.md` — don't write it until you can say something true and specific about the package. Write a short README covering what the package is and why it's distinct from its siblings (e.g. what part of the `sys.pkg.*` taxonomy it fills, what it depends on or is depended on by) — not a full manual.

This is specifically about READMEs. A missing CLAUDE.md next to an *existing* README is a separate, already-covered convention — filled in gradually and incidentally as a side-effect of other work, never as a dedicated sweep — don't conflate the two or use this task to backfill CLAUDE.md instead.

One package per day, cumulative; don't re-touch one already logged in `processed/`.
