# AE3 testing conventions

Testing/workflow conventions specific to `keeper-ae3`'s own domain (Eclipse AE3 framework work) — not a generic team-wide rule.

## Ad-hoc test-variant copies are deleted within the same task

An ad-hoc test variant — a parallel copy of a real file/folder created purely to validate a change in isolation — is deleted once it has served its purpose, within the same task: copy, change, test, delete. It is never left in the repository as a standing artifact.

The normal/recurring test mechanism tests a file's own real, uncommitted working-tree changes directly, not a separate permanent parallel test-variant copy. Where an ad-hoc isolated copy is genuinely needed for safe A/B validation, its deletion is part of that task's own definition of done — not something left for the human-owner to notice and request separately.

Confirmed gap (2026-08-24): a full parallel copy of `show.xsl.tpl` was created at `ae3.sys.pkg.l2.tgt.xml/ae3-packages/ae3.sys.l2.tgt.xml/resources/skin/skin-standard-xml/skin-test-xhtml-method/`, to validate `<xsl:output method="xhtml"/>` as the fix for a void-element self-closing bug (`<br>` etc. not self-closing under `method="html"`, breaking strict XML/XHTML parsing). The copy correctly proved the fix, but was never deleted once the fix was ready to promote to production — the human-owner, finding the leftover copy later, lost real time untangling why the test copy carried the fix while production did not, when the only actual cause was the missing cleanup step.
