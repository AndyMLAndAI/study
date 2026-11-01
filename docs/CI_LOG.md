# CI_LOG.md

Log of the last 10 GitHub Actions CI runs for **Study**.

| Date | Commit SHA | Result | First Error / Notes |
|---|---|---|---|
| 2026-11-01 | 52b172d | FAIL | `xcodegen generate`: Decoding failed at "path": Nothing found (fixed: added explicit Info.plist files and info.path) |
| 2026-11-01 | 96af439 | FAIL | Swift 6 region isolation error on `activity.end` in `ContentView.swift` (fixed: simplified `startFocus` to direct request) |
| 2026-11-01 | 545dbb0 | FAIL | `Run Unit Tests`: Simulator failed to install app due to missing `CFBundleExecutable` in Info.plist (fixed: added `CFBundleExecutable` and bundle package types) |
| 2026-11-01 | 698ee83 | FAIL | `Run Unit Tests`: App extension placeholder failed due to bundle ID casing mismatch (fixed: aligned `bundleId` across targets, set dynamic bundle IDs) |
| 2026-11-01 | 9016f7e | FAIL | `Run Unit Tests`: App extension placeholder failed (`extensionDictionary must be set`) because `info.path` in XcodeGen regenerated and wiped out plist keys (fixed: replaced `info:` with `INFOPLIST_FILE` and `PRODUCT_BUNDLE_IDENTIFIER`) |
