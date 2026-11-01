# DECISIONS.md

Architectural, design, and workflow decisions for **Study**.

### 2026-11-01: App Rename from StudyOS to Study
- **Context:** Project name simplified from placeholder "StudyOS" to "Study".
- **Decision:**
  - Display Name: "Study" (stored in `Core/DesignSystem/AppInfo.swift`).
  - Target Names: `Study` (main app), `StudyWidgets` (widgets & Live Activity), `StudyTests` (unit tests).
  - Bundle Identifiers: `com.andyml.study` and `com.andyml.study.widgets`.
  - App Group: `group.com.andyml.study`.
  - Deep-link URL Scheme: `study://focus`.
  - CI Artifact: `Study-unsigned-ipa`.
  - Source Directory: `Study/` (entry: `Study/App/StudyApp.swift`).
  - **Module Collision Guard:** No Swift type (class, struct, actor, enum) will ever be named literally `Study` to avoid colliding with the Swift module namespace.

### 2026-11-01: Typography & Font Strategy
- **Context:** Font handling across iOS target and Windows local environment.
- **Decision:** Fonts: system SF in-app, Inter fallback on Windows, nothing bundled.
  - In-App (iOS): SF Pro and SF Rounded are system-provided on iPhone (`Font.system(...)`, `.fontDesign(.rounded)`, `.monospacedDigit()`). Zero font files (`.ttf`, `.otf`, `.woff2`) are bundled into the app targets, preserving the <40 MB size limit and avoiding font registration failures.
  - Windows Tools & Previews: Falls back to Inter (SIL OFL) -> `system-ui` -> Segoe UI. No font hunting or macOS installer scraping on Windows.

### 2026-11-01: Skill Translations and Precedence Overrides
- **Precedence Hierarchy:** `DESIGN.md` (visuals) > `AGENTS.md` (rules & workflow) > Prompt (scope/psychology).
- **Hairlines vs. Anti-Slop Ban:** `taste-skill` bans thin rules and hairlines. Overridden by `DESIGN.md` which mandates 1 pt hairline dividers (`#D2D2D7` light / `#333333` dark) for spatial separation without cards. `taste-skill`'s anti-slop discipline (no gradients, no shadows, no vanity numbers, no fake card grids) is strictly enforced.
- **Visual Styles in UI/UX Pro Max:** Generic styling recommendations (bento grids, glassmorphism, shadows) overridden by `DESIGN.md`'s strict flat surfaces, zero elevation, and 8 pt / Capsule radius system. Touch targets (44×44 pt) and contrast ratios (4.5:1) adopted.
- **Native iOS HIG (`ios.md`):** System navigation stack, tab bar (4 tabs), system modal sheets, and standard system controls adopted directly.

### 2026-11-01: Color Tokens and Chromatic Exceptions
- **Dark Mode Mapping:** AMOLED true black (`#000000` canvas, `#1D1D1F` wash, `#333333` pebble, `#A1A1A6` ash) approved for battery efficiency and high contrast.
- **Subject Dots:** 10 pt system circle dots represent the only chromatic element outside of the blue system, used strictly for identification.
- **Today's Chart Bar:** Rendered in `appleBlue` as an active/selected state; past bars use neutral `pebble`.
- **Semantic Feedback:** `success` and `error` colors are strictly limited to feedback glyphs and text, never applied to buttons, fills, or borders.

### 2026-11-01: XcodeGen Info.plist Handling and Target Build Settings
- **Context:** During Phase 0 CI pipeline setup, `xcodegen generate` with `info: path: <file>` generated blank plist templates, overwriting checked-in `Info.plist` files and stripping custom keys like `NSExtension` (causing simulator test failure `extensionDictionary must be set in placeholder attributes`).
- **Decision:** Do not use `info:` block in `project.yml`. Instead, declare `INFOPLIST_FILE: <path>` and explicit `PRODUCT_BUNDLE_IDENTIFIER: <bundleId>` under `settings: base:` for every target (`Study`, `StudyWidgets`, `StudyTests`). Dynamic build variables `$(PRODUCT_BUNDLE_IDENTIFIER)` and `$(PRODUCT_BUNDLE_PACKAGE_TYPE)` are maintained in the checked-in `Info.plist` files.

### 2026-11-01: Scheme Test Target Isolation and Primary Button Contrast
- **Context:** Automated screenshots required a dedicated UI test target `StudyUITests` without impacting or risking the passing `build.yml` workflow.
- **Decision:**
  - In `project.yml`, `Study` target explicitly declares `scheme: testTargets: [StudyTests]`. This guarantees `build.yml` running `xcodebuild test -scheme Study` executes only unit tests and never runs UI tests.
  - `StudyUITests` target declares `scheme: testTargets: [StudyUITests]` for dedicated screenshot runs in `.github/workflows/screenshots.yml`.
  - Visual review of dark mode simulator screenshots revealed that dynamic `Color.appWash` (`#1D1D1F`) on `appleBlue` (`#0071E3`) reduced contrast to failing levels. `Color.primaryButtonText` (`#F4F8FB`) was defined to guarantee 4.6:1 WCAG AA contrast across both light and dark appearances.
