Changelog
==========

<!--
Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->


## [0.1.2-rc] - 2021-10-30
### Added
- Support to AWS remote cromwell configuration (sandbox testing)
### Changed
- Refactored tasks freebayes, alignment and merge to be place into the wdl-tasks submodule
- Changes in CI to support latest version of mini-wdl
- Changes in CI to supress warnings on runtimekeyerror warnings at miniwdl check
- Updates on wdl-tasks and wdl-structs submodules
- Code style refactorings according to WDL specs

## [0.1.1-rc] - 2021-10-21
### Added
- Germline Varcall Pipeline WDL (Merge Fastqs, Alignment and Varcall)
- Test Suite for Pipeline
- Docs updated
## [0.1.0] - 2021-10-08
### Added
- Hello-World Pipeline WDL
- CIs (Publish Docs, Release, Build Test)
- BumpVersion integrated
- Tests suites integrated
- Docs integrated

## [0.1.0-rc] - 2021-10-06
### Added
- First draft of the wdl pipeline architecture.
