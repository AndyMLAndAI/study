# AGENTS.md

Universal rules for every AI agent working in this repo (Gemini, Claude, Codex, Cursor, anything else). `GEMINI.md` just points here. Read this file fully before touching code.

## 1. Project

**Study** is a native iPhone study app for my younger brother (14, Class 8). Name is "Study", kept in one constant (`Core/DesignSystem/AppInfo.swift`). Never create a Swift type named `Study` to avoid colliding with the module name.

- Platform: iPhone 17, iOS 27 (deployment target 27.0), portrait only
- Stack: Swift 6, SwiftUI, SwiftData, ActivityKit, WidgetKit, App Intents, Swift Charts
- Offline-first, no backend, no accounts, no network calls, no paid APIs
- Features, ranked: (1) focus timer with Dynamic Island and Live Activity, (2) study manager (subjects, topics, tasks), (3) flashcards, quizzes and spaced repetition
- Not in v1: AI tutor, social, leaderboards, payments, ads, App Store release, web wrappers, React Native, Flutter, PWA

## 2. Environment (read this twice)

I develop on **Windows 11** with PowerShell 7 and VS Code. There is **no Mac, no Xcode, no Simulator** on my side.

- Never write "open in Xcode", "press Cmd+R", "run in the Simulator" or "Product > Archive".
- Never use macOS-only commands locally: `xcodebuild`, `xcrun`, `simctl`, `plutil`, `PlistBuddy`, `codesign`, `brew`, `open`, `pbcopy`, BSD `sed -i`. They only run on the CI runner.
- Check a tool exists with `Get-Command <name>` before using it. Do not assume anything is installed.
- You cannot compile or preview locally. **GitHub Actions is the compiler. My iPhone 17 is the only real test device.**
- Because of that, write conservative, compile-safe Swift. If you are unsure an iOS 27 API exists, use the older proven API and add `// VERIFY-ON-CI`.
- If a step truly needs a Mac, say so explicitly, explain why, and propose a Windows or CI alternative.

### Build and install loop

1. Edit in VS Code. One feature per commit. Conventional Commits, imperative, under 72 characters.
2. Never hand-edit or commit an `.xcodeproj`. `project.yml` (XcodeGen) defines the targets and CI generates the project.
3. Push a branch, open a PR with `gh pr create --fill`.
4. Watch CI: `gh run watch`, then `gh run view --log-failed`. Fix the **first** compiler error only, push again. Do not rewrite unrelated files.
5. CI runs on `runs-on: xcode-27` (Apple Silicon). It installs XcodeGen, generates the project, builds with `CODE_SIGNING_ALLOWED=NO`, runs unit tests on an iOS 27 simulator, packages an unsigned `.ipa`, uploads the artifact `Study-unsigned-ipa`.
6. Download with `gh run download --name Study-unsigned-ipa --dir .\build`.
7. Sign and install with AltStore Classic (AltServer on Windows) or Sideloadly using a free Apple ID. Free signing expires every 7 days.
8. I test on the phone and report back. Do not claim something works until I have confirmed it on device.

Line endings: `.gitattributes` forces LF for `*.swift`, `*.yml`, `*.yaml`, `*.plist`, `*.pbxproj`, `*.sh`. `.editorconfig`: UTF-8, LF, 4-space indent for Swift.

Free signing may block App Groups, Live Activities or widget extensions. This is tested first (Phase 0). If something is blocked, report it and propose options. **Never silently drop a requested feature.**

## 3. Source of truth and precedence

1. `DESIGN.md` (repo root) wins on anything visual.
2. This file wins on rules, workflow and code style.
3. The main build prompt wins on feature scope and algorithms.

If two of these conflict, follow the higher one and log the override in `docs/DECISIONS.md`. If `DESIGN.md` or `.agents/` is missing, stop and tell me.

## 4. Skills in `.agents/`

Skills in `.agents/` are mandatory, not optional.

- At the start of every session, list them: `Get-ChildItem -Recurse -Filter SKILL.md .agents`
- Before each task, read the full `SKILL.md` of every skill that plausibly applies (SwiftUI, design, testing, CI, debugging, git, accessibility, writing).
- If a skill says to run Xcode or `xcodebuild` locally, translate it to the CI equivalent and note the translation in `docs/DECISIONS.md`. Do not skip the skill.
- Log use in `docs/SKILLS_USED.md`, one line per task: date, task, skill path, how it changed your approach.
- Never claim to have used a skill you did not open.

## 5. Brand kit

`DESIGN.md` is an Apple-style web reference. This section translates it to iOS. Where `DESIGN.md` says `px`, use `pt`.

**Personality:** a white room with a single blue switch. Quiet, precise, typographic. The product (the content and the interactions) is the design; chrome recedes.

### Colors

| Token | Light | Dark | Use |
|---|---|---|---|
| `appleBlue` | `#0071E3` | `#0071E3` | Filled primary buttons and selected/active states only. Never text, borders or decoration. |
| `linkBlue` | `#0066CC` | `#2997FF` | Outlined secondary buttons, inline links |
| `signalBlue` | `#2997FF` | `#2997FF` | Decorative only: icon strokes, subtle emphasis |
| `canvas` | `#F5F5F7` | `#000000` | App background (Surface 0) |
| `wash` | `#F4F8FB` | `#1D1D1F` | Elevated wash (Surface 1) |
| `pebble` | `#E2E2E5` | `#333333` | Secondary button fill, disabled, pressed surfaces (Surface 2) |
| `carbon` | `#1D1D1F` | `#F5F5F7` | Primary text |
| `ash` | `#707070` | `#A1A1A6` | Secondary and muted text |
| `hairline` | `#D2D2D7` | `#333333` | 1 pt dividers and borders |
| `success` | `#248A3D` | `#30D158` | Feedback icons/text only |
| `error` | `#D70015` | `#FF453A` | Feedback icons/text only |

Notes:
- `DESIGN.md` is light only. The dark column, `success`, `error`, and the dark `ash` (`#A1A1A6`, chosen to keep 4.5:1 on black) are my inferred additions. Treat them as proposed, not canonical.
- Dark mode uses true black `#000000` for AMOLED.
- All colors live in the asset catalog and `Core/DesignSystem/Colors.swift`. **No hex literals anywhere else.**
- Subject colors: subjects get a small 10 pt dot (system colors, user selectable) for identification only. Never use a subject color for buttons, text or large fills. One accent per screen.
- Contrast: all text at least 4.5:1 on its surface, both modes.

### Typography

- Use the system font (SF Pro) through Dynamic Type. Use SF Rounded only for timer digits and XP.
- Do not add manual `.tracking()`; the system already applies SF's optical tracking.
- Weights: 300 light for subheads and editorial descriptors, 400 regular for body, 600 semibold for buttons, nav and titles. Never 700 for names or headings.
- Scale: caption 12, body-sm 14, body 17, subheading 21, heading-sm 28, heading 34 (large title), display 40 (onboarding and hero moments only).
- Focus countdown is the one exception: 84 pt SF Rounded semibold, `@ScaledMetric(relativeTo: .largeTitle)`, `.monospacedDigit()`.
- Changing numbers (timers, XP, counts) use `.contentTransition(.numericText())`.
- Must scale to AX5 without clipping.

### Spacing, shape, surfaces

- 4 pt base. Scale: 4, 8, 12, 16, 20, 24, 40, 48, 56. Element gap 12, section gap 40 on phone, screen margin 16 (20 on onboarding).
- **Buttons, tags, pills: fully rounded (`Capsule()`).** Non-negotiable.
- **Cards, images, inputs: 8 pt continuous radius.** These two radius values are the only ones in the system. (This replaces the earlier 12 and 16 pt values.)
- **No shadows** on cards, buttons, nav or sheets. Hierarchy comes from the surface shift (`canvas`, `wash`, `pebble`) and 1 pt hairlines.
- **No cards inside the canvas.** Content sits directly on `canvas`, separated by hairlines and whitespace. Use `.listStyle(.plain)` with hairline separators and clear row backgrounds, not inset-grouped boxes.
- No gradients, glows, blurs or decorative illustrations. `.regularMaterial` is allowed only for Live Activity backgrounds and sheet toolbars.
- Icons: SF Symbols only, 1 to 2 pt stroke weight (`.regular` or `.light`), in `carbon` or `ash`. No emoji as UI.
- Layout: centered, stacked, symmetrical. No asymmetric compositions.

### Components

- **Filled pill button** (primary): `appleBlue` fill, `#F4F8FB` text, Capsule, 17 pt. Min height 44 pt. Only one filled button per view.
- **Outlined pill button** (secondary): 1 pt `linkBlue` border and text, transparent fill. Always pair with a filled primary; never stack two filled buttons.
- **Ghost link** (tertiary): no fill or border, `linkBlue` text.
- **Pebble button** (neutral): `pebble` fill, `carbon` text.
- **Input:** 8 pt radius, 1 pt `hairline` border, `canvas` fill, 2 pt `appleBlue` focus ring.
- **Never mix** the three blues in one interactive element.
- **Empty state:** SF Symbol 48 pt in `ash`, one line of copy, one primary button, centered.

## 6. Interaction rules

I want **lots of interactions**, but every one must confirm an action, show a state change, or preserve spatial context. If it does none of those, delete it. Many interactions does not mean much animation.

- **Budget:** max 1 primary transition and 1 secondary animation on screen at once. Never animate more than 3 views simultaneously. No looping or idle animations.
- **Press feedback** on every tappable surface (`PressableStyle`): scale 0.97, spring response 0.25, damping 0.9.
- **Sheets:** spring response 0.35, damping 0.85. Detents medium and large, drag indicator visible.
- **Focus start:** 0.30 s easeInOut (18 frames at 60 Hz, 36 at 120 Hz), zoom/matched-geometry from the Start Focus button.
- **Flashcard flip:** 0.35 s easeInOut, Y-axis 3D rotation, swap content at 90 degrees.
- **Flashcard swipe grading:** right 120 pt = Good, left 120 pt = Again, up 60 pt = Easy, down 60 pt = Hard. Tilt = translation.x / 20, max 12 degrees. Fly-off spring response 0.35, damping 0.8.
- **Task complete:** checkbox spring response 0.30, damping 0.7; strikethrough 0.20 s easeOut; row moves to Completed after 0.6 s; undo toast for 3.0 s.
- **Session complete:** spring response 0.4, damping 0.8.
- **Daily Goal ring:** trim animates 0.60 s easeOut; on goal reached, one pulse 1.0 to 1.06 to 1.0 over 0.40 s. No confetti.
- **Swipe actions** on every list row: leading Done, trailing Delete, full-swipe enabled.
- **Context menus** on subjects, tasks, decks, cards.
- **Drag to reorder** for subjects, topics, tasks. Lift = scale 1.03 and `pebble` surface shift, **no shadow**.
- **Haptics:** `.selection` for picker and tab changes, `.impact(.light)` for primary taps, `.impact(.medium)` for drag settle, `.success` for session complete and correct answers, `.warning` for wrong answers and destructive confirms, `.start` / `.stop` for the timer. Max 1 haptic per 80 ms.
- **Tab bar:** tapping the active tab scrolls to top; tapping again pops to root.
- **Widgets and Live Activity:** interactive Pause/Resume buttons via App Intents; tap deep-links to `study://focus`. Update the Live Activity only on start, pause, resume, end, never per tick.
- **Accessibility:** respect Reduce Motion (swap springs and flips for 0.15 s crossfades), Reduce Transparency, Increase Contrast. VoiceOver label on every control. Dynamic Type to AX5.

## 7. Voice and copy

- Short, warm, playful, never corporate. Written for a 14-year-old, never babyish.
- Never shame a missed day. A broken streak says: "Fresh start. Day 1."
- Buttons: Start Focus, Continue, Pause, Resume, Finish Session, Add Task, Add Subject, Start Revision, Check Answers, Try Again.
- Progress terms: Focus Time, Study Streak, XP, Daily Goal, Cards Mastered, Next Review.
- Empty states: "Nothing on your plate. Yet." / "Ready when you are." / "Your next study session starts here." / "A fresh day. A fresh start."
- Encouragement: "Nice work. Keep that momentum." / "One step closer." / "That's progress. Seriously." / "You showed up. That's what counts." / "Look at you go." / "Another session in the books." / "Small steps. Big progress." / "Your future self says thanks." / "You made time to learn today." / "Ready for another round?" / "Mistakes are part of learning." / "Take a breather. You've earned it." Never repeat the same one twice in a row.
- Sentence case everywhere. UI strings under 28 characters.

## 8. Code rules

- One type per file. Explicit imports. No force unwraps. No `@available` guesses.
- Business logic lives in small testable services (`TimerService`, `SchedulerService`, `StreakService`, `XPService`), never in views. Views stay under about 150 lines; split them.
- State: `@Observable` and `@Query`. No third-party dependencies unless I approve them.
- Timer is timestamp-based (`endDate - now`), never background execution.
- All date math through `Calendar.current`.
- No sorting, filtering or date math in a view `body`; precompute in services.
- Save to SwiftData on action completion, never per frame during a drag. Use `VersionedSchema` and a `SchemaMigrationPlan` from day one.
- Animations: explicit `.animation(_:value:)` or `withAnimation`. No global implicit animation.
- Previews use self-contained sample data.
- No macros beyond `@Model`, `@Observable`, `@Query`, `#Preview`.
- Never invent curriculum facts. Mark sample content "Sample".

### Folder structure

```
Study/
  App/
  Core/{Models,Persistence,Services,DesignSystem}
  Features/{Today,Study,Review,Focus,Progress,Settings}
  Widgets/{HomeWidgets,LiveActivities,Intents}
  Resources/
  Tests/
project.yml
.github/workflows/build.yml
docs/
```

`Core/DesignSystem/Interactions/` holds every reusable modifier and button style from section 6.

## 9. Performance targets

Cold launch under 1.0 s (best effort). 60 fps minimum, aim for 120 Hz ProMotion (`CADisableMinimumFrameDurationOnPhone = YES`). Memory under 120 MB. Installed size under 40 MB. Tap-to-response under 100 ms. No background polling, no network. Max 1 local notification per day, quiet hours 21:00 to 07:00.

## 10. Docs you maintain

- `docs/DECISIONS.md`: every override, assumption and skill translation
- `docs/SKILLS_USED.md`: the skill log
- `docs/CI_LOG.md`: last 10 CI runs (date, SHA, pass/fail, first error)
- `docs/WINDOWS_WORKFLOW.md`: the build and install loop, with exact AltStore/Sideloadly steps
- `DESIGN_NOTES.md`: a table showing how each `DESIGN.md` rule was applied (no unresolved rows)

## 11. Definition of done

A task is done only when all of these are true:

1. CI is green from a clean clone.
2. The feature matches `DESIGN.md` and section 5 of this file.
3. Interactions follow section 6 and stay within budget.
4. Accessibility checks in section 6 pass.
5. Docs in section 10 are updated.
6. I have confirmed it on my iPhone 17.

## 12. Do and don't

**Do**
- Work in small phases and stop to report after each one.
- Ask me when something is genuinely ambiguous, then proceed with the documented default if I am unavailable.
- Say plainly when something is unverified.

**Don't**
- Dump the whole app in one unverified block.
- Add a dependency, entitlement or capability without telling me.
- Use TrollStore, jailbreaks, exploits or signing bypasses.
- Promise that app data survives deleting the app.
- Touch files outside the task's scope.

## 13. Open questions (defaults apply until answered)

Final app name, brother's board and syllabus, reminder times, whether the repo is public, whether JSON export ships in v1, and whether the dark-mode color mapping in section 5 is approved.
