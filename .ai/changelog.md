# Changelog

## 2026-04-11
### Added
- [Feature] Added `firstWhereByPriority` extension to `List<T>` to find the first element matching a list of predicate priorities.
- [Test] Added unit tests for `firstWhereByPriority` covering multiple priority scenarios.
- [Refactor] Renamed `findByPriority` to `firstWhereByPriority`.

## 2026-04-06
### Added
- [Feature] Added `toMoney` and `formatMoney` extensions to `num` and `String` for convenient financial formatting, supporting custom prefixes and variable decimal places.
- [Test] Added unit tests for `toMoney` and `formatMoney` with decimal control.
- [Infra] Initialized `.ai/` directory for project context and maintenance.
