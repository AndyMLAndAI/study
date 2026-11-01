# Product

<!-- impeccable:product-schema 1 -->

## Platform

ios

## Stack
Swift 6, SwiftUI, SwiftData, ActivityKit, WidgetKit, App Intents, Swift Charts. XcodeGen (`project.yml`) on GitHub Actions CI (`runs-on: xcode-27`, Apple Silicon). No third-party dependencies.

## Users
Primary user: 14-year-old student (Class 8), ambitious, preparing for school and olympiad-level maths and science. Driven by autonomy, competence, and identity with zero tolerance for being talked down to, babyish UI, guilt, or corporate patronizing. Secondary/operator: 19-year-old older brother acting as developer and setup guide.

## Product Purpose
A native iPhone study companion that turns study sessions into calm, focused, and measurable progress. Combines a low-friction focus timer (Dynamic Island & Live Activity), an offline study manager, and an active recall engine (spaced repetition flashcards & quizzes) with zero ads, accounts, networks, or dark patterns.

## Positioning
A quiet, distraction-free study tool ("a white room with a single blue switch") built with high-craft native Apple design and honest teen psychology. Unlike gamified apps that use guilt streaks, ads, or predatory loops, Study respects autonomy: max 2 taps to start focus, fixed published XP rules, honest streak protection (1 auto rest day per week), and strict local-only privacy.

## Operating Context
Daily study sessions at home (desk or bed), quick revision bursts before dinner or school, and weekend review. Used in portrait on an iPhone 17 running iOS 27. Focus sessions monitored through the Dynamic Island and Lock Screen Live Activity while multitasking or with phone face-down. Managed on Windows 11 via AltStore Classic 7-day sideload refresh.

## Capabilities and Constraints
- Offline-first: SwiftData with versioned schema and migration plan. Zero network calls, zero analytics.
- Focus engine: Pomodoro & custom timers (timestamp-based), Dynamic Island, Lock Screen Live Activity, App Intents controls.
- Study manager: Subjects (color dot), topics, tasks (checkbox, swipe actions, undo toast).
- Active recall: SM-2-inspired spaced repetition (Again, Hard, Good, Easy), 4-way swipe/tap grading, 10 new cards/day cap, 10-question quizzes with retry rounds.
- Progress & Psychology: Daily Goal ring (trim pulse at 80% and 100%), honest streaks (1 auto rest day/7 days), capped XP (stops at 240 focus min/day), level titles (Starter to Grandmaster).
- Technical constraints: INR 0 budget, free Apple ID 7-day signing window, compiled exclusively via GitHub Actions CI (no local Mac/Xcode). App Group fallback paths planned for widget/Live Activity.
- Undecided facts: Final board & syllabus (CBSE/ICSE/Olympiad defaults to generic Class 8 sample content), user device (defaults to developer's iPhone 17), repo visibility (defaults to public), dark palette approval (defaults to proposed AMOLED mapping).

## Brand Commitments
- Name: "Study" (display name "Study", constant in `Core/DesignSystem/AppInfo.swift`). Never create a Swift type named `Study` to avoid module collisions.
- Aesthetic: Minimal Apple-core ("white room with a single blue switch"). SF Pro / SF Rounded system typography, flat surfaces, hairlines, zero drop shadows, Capsule buttons, 8 pt card radius.
- Voice: Short, warm, witty, confident teen voice; sentence case, under 28 chars; zero shame, zero fake urgency.
- Single blue switch: Apple Blue (`#0071E3`) reserved exclusively for filled primary buttons and active states.

## Evidence on Hand
- Hand-authored sample decks for Mathematics, Science, English, and Social Studies (labelled "Sample", Class 8 verified facts).
- Full design token specification in `DESIGN.md`.
- Complete interaction and motion specification in `AGENTS.md` and `MASTER_PROMPT.md`.
- No external user quotes, fabricated curriculum facts, or fake social proof.

## Product Principles
1. Launch to focus in 2 taps and under 6 seconds: eliminate all friction between intent and studying.
2. Honest psychology over dark patterns: transparent rewards, no countdown-to-loss timers, no guilt copy, healthy 240-min daily caps.
3. Apple-native craft: rely on system navigation, standard sheets, Dynamic Type, and crisp haptic feedback rather than ornamental chrome.
4. Absolute privacy: everything stays on the phone; zero telemetry or network calls.

## Accessibility & Inclusion
- Full Dynamic Type scaling to AX5 without clipping or truncating primary controls.
- Minimum 44×44 pt touch targets with adequate spacing across all buttons and chips.
- WCAG AA (minimum 4.5:1) contrast ratio on all text and active elements in both light and dark modes.
- Comprehensive Reduce Motion support swapping physics springs/flips for 0.15 s crossfades.
- Screen reader semantic descriptions (VoiceOver labels and values) on every interactive element.
