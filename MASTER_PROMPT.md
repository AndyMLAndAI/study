# MASTER_PROMPT.md

<inputs>
Project: Study, a native iPhone study app.
Read in this exact order before writing any code:
1. ./AGENTS.md (universal rules, Windows workflow, brand kit, code style)
2. ./DESIGN.md (visual source of truth; wins on all visual conflicts)
3. Every SKILL.md under ./.agents/ (run: Get-ChildItem -Recurse -Filter SKILL.md .agents). Mandatory. Log use in docs/SKILLS_USED.md.
4. This file.
Precedence: DESIGN.md (visuals) > AGENTS.md (rules and workflow) > this file (scope, UX, psychology, algorithms). Log every override in docs/DECISIONS.md.
If any of 1 to 3 is missing, STOP and tell me.

AUDIENCE: my younger brother. Age 14, Class 8, an ambitious student who also does olympiad-style maths and science. NOT me (I am 19). Every UX and psychology decision targets a 14-year-old's motivation: autonomy, competence, identity, zero embarrassment. Never babyish, never preachy, never corporate.

BUDGET: INR 0. Nothing paid, ever. No Apple Developer Program, no TestFlight, no paid APIs, no paid tools. Free Apple ID signing only.

SIGNING (acknowledged): free Apple ID certificates expire every 7 days. I will use a free sideload app that auto-refreshes that 7-day window (AltStore Classic with AltServer on Windows, or an equivalent such as SideStore or Sideloadly; ChatGPT recommended one for testing). This is accepted for testing. Do not suggest paying to avoid it. Do not promise it removes Apple's limits. Treat it as a known constraint, verify early (Phase 0), and document the exact refresh routine in docs/WINDOWS_WORKFLOW.md.

ENVIRONMENT: Windows 11, PowerShell 7, VS Code. No Mac, no Xcode, no Simulator. GitHub Actions (runs-on: xcode-27, Apple Silicon, Xcode 27 image) is the only compiler. My iPhone 17 (iOS 27) is the only test device.

PRIORITY ORDER when anything conflicts:
1. UI and UX craft (feel, clarity, responsiveness)
2. Consumer psychology applied ethically
3. Correctness and reliability
4. Feature breadth
Fewer features done beautifully beats many features done adequately. Cut scope before cutting polish.
</inputs>

<direction>
Aesthetic: minimal Apple-core. "A white room with a single blue switch." Flat surfaces, hairlines, whitespace, typography as the main voice, SF Symbols only. Delight comes from motion, haptics, timing and copy, never from decoration, gradients, glows, mascots or confetti.
Interaction: tons of small, responsive, native-feeling interactions. Each must confirm an action, show a state change, or preserve spatial context. Many interactions, little animation.
Native: SwiftUI + system components first. Feel like a first-party Apple app (Clock, Reminders, Fitness).

CONSUMER PSYCHOLOGY PLAYBOOK (apply every principle below, with the exact implementation given):
1. Self-determination (autonomy, competence, relatedness). Autonomy: he picks subjects, durations (chips 15 / 25 / 45 min), accent dot per subject, one of 3 alternate app icons. Competence: visible mastery (Cards Mastered, level, streak, accuracy). Relatedness without social features: a weekly summary he can screenshot (Progress tab, "Week in review" sheet).
2. Fogg behavior model (Behavior = Motivation + Ability + Prompt). Maximise ability: launch to running timer in at most 2 taps and 6 seconds (Today > Start Focus > it starts with last-used subject and duration). Prompts: one well-timed local notification (see algorithm). Never rely on motivation alone.
3. Goal-gradient effect. The Daily Goal ring shows remaining time in plain words when 20% or less remains ("12 min to your goal"). Ring gets a subtle 1.0 to 1.04 pulse once at 80%, then once at 100%.
4. Endowed progress (honest version). Completing onboarding grants a real 20 XP "Setup bonus" and starts Level 1. No fake pre-filled progress bars.
5. Zeigarnik effect. If a session or revision is interrupted, Today shows a "Pick up where you left off" row (resume focus, or finish 6 of 10 cards). Disappears after 24 h.
6. Peak-end rule. Every session ends on a calm, positive summary: count-up of 3 stats over 0.6 s easeOut, one encouragement line, one obvious next action (Continue). Never end on an error, a paywall-style prompt, or a nag.
7. Loss aversion, handled gently. Streaks exist, but breaking one is not punitive: 1 automatic rest day per rolling 7 days, "Best streak" is kept forever, a broken streak says "Fresh start. Day 1." No red, no guilt, no countdown-to-loss timers.
8. Predictable rewards, not variable ones. XP, levels and badges follow fixed, published rules. No loot boxes, no random drops, no slot-machine animations.
9. Testing effect and spacing effect (the real learning science). Active recall before reveal. Show the next review date after every grade ("Next review in 6 days") so the spacing logic feels transparent and trustworthy.
10. Cognitive load. New cards capped at 10 per day. Review session default 20 cards, with a "Quick 5" option. One primary action per screen.
11. Implementation intentions. Onboarding asks "When do you usually study?" with time chips (4 PM, 6 PM, 7 PM, 8 PM, Not sure). Reminders attach to that cue.
12. Identity and status for a teen. Level titles feel earned and a bit cool: Level 1 "Starter", 3 "Sharpener", 5 "Locked In", 8 "Deep Work", 12 "Grandmaster". Copy treats him as capable ("Hard topic. You've got the tools.").
13. Feedback latency. Visual response within 100 ms of any tap, haptic within 16 ms of the visual. Grading feedback within 300 ms.
14. Reduce friction at the end of a loop. After a session, Continue returns to the previous tab with a 0.30 s easeInOut transition; break timer auto-starts only if he opted in.

ETHICAL RED LINES (he is a minor; these are absolute):
- No dark patterns: no guilt copy, no fake urgency, no hidden dismiss, no confirm-shaming.
- No infinite loops. Healthy ceiling: XP from focus stops at 240 min per day, and the app says "That's a solid day. Go outside." Quiet hours 21:00 to 07:00 (no notifications, and a gentle "Wind down" note if a session starts after 22:00).
- No social comparison, leaderboards or public profiles.
- No data leaves the device. No analytics SDKs. No accounts. No network.
- Max 1 notification per day. Auto-pause reminders after 3 ignored in a row, then ask once: "Want fewer reminders?"
- Honest progress only: never inflate numbers, never fake streaks.
</direction>

<subject>
Study: a minimal, interaction-rich, psychologically sound study companion.
Core features, ranked:
1. Focus engine: Pomodoro and custom timers, Dynamic Island, Lock Screen Live Activity, interactive controls.
2. Study manager: subjects, topics, tasks, assignments, revision schedule.
3. Active recall: flashcards (swipe grading), quizzes, spaced repetition, progress tracking.
Supporting: Today dashboard, Progress tab, Settings, home widgets, App Intents, JSON export/import.
NOT in v1: accounts, backend, paid APIs, AI tutor, leaderboards, multiplayer, payments, ads, public App Store release, TestFlight, web wrappers, React Native, Flutter, PWA, WebView, analytics.
If a feature must be cut for time, cut in this order: widgets variants, alternate app icons, week-in-review sheet, quizzes. Never cut polish on Focus, Today or Review.
</subject>

<canvas>
Device: iPhone 17. Design canvas 402 x 874 pt. iOS 27.0 minimum. Portrait only. Safe areas respected. Min tap target 44 x 44 pt. Light and dark appearance both supported (dark uses true black #000000 for AMOLED).
Tech: Swift 6, SwiftUI, SwiftData, ActivityKit, WidgetKit, App Intents, Swift Charts. No third-party dependencies.
Targets (via XcodeGen project.yml, generated on CI, never commit .xcodeproj): Study (app), StudyWidgets (widget + Live Activity), StudyTests.
Bundle IDs: com.andyml.study, com.andyml.study.widgets. App Group: group.com.andyml.study (test early under free signing).
Free-signing realities to plan around (verify in Phase 0, do not assume): free accounts have limits on active sideloaded apps and App IDs per 7 days, and may restrict App Groups and some capabilities. The widget extension counts toward those limits.
Fallback plan if App Groups fail: the Live Activity still works because its state lives in ActivityKit ContentState, and its Pause/Resume buttons run as LiveActivityIntent in the app process; the home widget degrades to a static launcher with deep link study://focus; data sharing is app-only. Report the failure and proposed options. Never silently drop a requested feature.
Environment: Windows 11. No macOS-only commands locally. You cannot compile or preview anything locally. Write conservative, compile-safe Swift, add // VERIFY-ON-CI when unsure an iOS 27 API exists.
</canvas>

<typography>
System SF Pro through Dynamic Type; SF Rounded for timer digits and XP only. No manual .tracking().
Weights: 300 light (subheads, descriptors), 400 regular (body), 600 semibold (buttons, titles). Never 700.
Scale (pt): caption 12, body-sm 14, body 17, subheading 21, heading-sm 28, heading 34 (large title), display 40 (onboarding and hero moments only).
Focus countdown: 84 pt SF Rounded semibold, @ScaledMetric(relativeTo: .largeTitle), .monospacedDigit(), .contentTransition(.numericText()).
Live Activity countdown: 34 pt SF Rounded semibold. Dynamic Island compact: 15 pt.
Changing numbers always use .contentTransition(.numericText()) with .snappy(duration: 0.30).
Max 2 weights per screen. Dynamic Type must scale to AX5 without clipping or truncating primary actions.
</typography>

<word-palette>
Voice: short, warm, a little witty, confident, never corporate, never childish. Written for a 14-year-old who is smart and slightly allergic to being talked down to. Sentence case. UI strings under 28 characters (except encouragement).
Buttons: Start Focus, Continue, Pause, Resume, Finish Session, Add Task, Add Subject, Start Revision, Check Answers, Try Again.
Progress terms: Focus Time, Study Streak, XP, Daily Goal, Cards Mastered, Next Review, Level.
Empty states (rotate): "Nothing on your plate. Yet." / "Ready when you are." / "Your next study session starts here." / "A fresh day. A fresh start."
Encouragement (never the same one twice in a row): "Nice work. Keep that momentum." / "One step closer." / "That's progress. Seriously." / "You showed up. That's what counts." / "Look at you go." / "Another session in the books." / "Small steps. Big progress." / "Your future self says thanks." / "You made time to learn today." / "Ready for another round?" / "Mistakes are part of learning." / "Take a breather. You've earned it."
Hard-moment lines (after a wrong answer or a failed card): "Hard one. You'll get it." / "Not yet. That's what reviews are for." / "Close. Try it again later."
Streak: "Day 6" / broken: "Fresh start. Day 1." / rest day: "Rest day. Streak safe."
Limits: "That's a solid day. Go outside." / "Wind down. Sleep helps memory."
Interaction microcopy: swipe actions "Done", "Delete", "Snooze 1 day", "Edit"; context menu "Start Focus", "Edit", "Duplicate", "Move to…", "Delete"; undo toasts "Task completed. Undo" and "Card deleted. Undo" (3.0 s); card hint (first 3 reviews only) "Swipe right: Good. Swipe left: Again."; long-press hint (once) "Press and hold for more."
Notification copy (rotate, max 1 per day, never guilt): "Got 10 minutes? Your cards are ready." / "Your 6 PM focus slot. Want it?" / "Quick 5 cards before dinner?" / "Your streak is at Day 6. Nice."
Banned words and tones: "you failed", "don't lose your streak", "last chance", "you're behind", "disappointed", "only", "just" (as minimisers), exclamation spam.
</word-palette>

<composition>
Navigation: TabView with 4 tabs (Today, Study, Review, Progress), each inside its own NavigationStack. Settings opens as a sheet from a gear in the Today and Progress toolbars. Focus is a full-screen cover.

SCREENS
TODAY (top to bottom): date caption (12 pt ash), greeting (heading 34 pt), Daily Goal ring (96 pt diameter, 10 pt stroke) with minutes and "to your goal" text, "Pick up where you left off" row (only if interrupted work exists), Start Focus filled capsule (full width, 56 pt tall, last subject and duration shown as subtitle, with a long-press menu to change them), Today's Tasks (max 5, hairline rows), Upcoming Revisions (max 3), one encouragement line (12 pt ash). No cards; content sits on canvas.
STUDY: subject list (10 pt color dot, name, progress as thin 4 pt bar), tap into topics and assignments. + in toolbar. Drag to reorder.
REVIEW: due count as the hero number (display 40 pt), Start Revision filled capsule, Quick 5 outlined capsule, deck list, Quiz launcher. Session screen: single card, big, centered; progress as "6 / 20" caption; swipe or tap-to-grade buttons below (Again, Hard, Good, Easy as 4 capsule buttons, one filled only: Good).
PROGRESS: weekly focus bar chart (Swift Charts, 7 bars, 8 pt radius tops, appleBlue for today and pebble for others), streak and best streak, level and XP-to-next, cards mastered, accuracy, subject breakdown, "Week in review" sheet.
FOCUS: full-screen. Countdown 84 pt centered, subject dot and name above, session type caption (Focus, Short Break, Long Break) below, 4 pt linear progress bar at the bottom edge, controls: Pause/Resume (filled capsule), Finish (ghost link). Dim to 0.55 opacity when paused.
SETTINGS: appearance, durations (focus, short break, long break), daily goal, reminder time chips, quiet hours, data export and import, alternate app icon, about.
ONBOARDING: 3 screens max: (1) welcome and name, (2) subjects (pre-selected Maths, Science, English, Social Studies) and daily goal chips 30 / 60 / 90 min, (3) "When do you usually study?" time chips + Start. Then land on Today with the Setup bonus toast. Skippable except name.

INTERACTION CATALOG (implement all; each in a reusable component under Core/DesignSystem/Interactions/)
1. PressableStyle on every tappable surface: scale 0.97, spring(response 0.25, dampingFraction 0.9) press and release.
2. Haptics: .selection (picker, tab), .impact(.light) (primary taps), .impact(.medium) (drag settle), .success (session complete, correct answer, goal reached), .warning (wrong answer, destructive confirm), .start / .stop (timer). Max 1 haptic per 80 ms.
3. Swipe actions on every list row: leading Done (success), trailing Delete (error), full swipe enabled.
4. Context menus (long press) on subjects, tasks, decks, cards, with a rounded 8 pt preview shape.
5. Drag to reorder on subjects, topics, tasks. Lift: scale 1.03 and pebble surface shift, NO shadow. Settle spring(response 0.30, dampingFraction 0.85).
6. Flashcard: tap to flip, easeInOut 0.35 s (21 frames at 60 Hz, 42 at 120 Hz), Y-axis rotation3DEffect, perspective 0.6, swap content at 90 degrees. Drag grading: right 120 pt = Good, left 120 pt = Again, up 60 pt = Easy, down 60 pt = Hard. Tilt = translation.x / 20, max 12 degrees. Label opacity = min(1, abs(translation) / 120). Fly-off spring(response 0.35, dampingFraction 0.8) to 600 pt. Next card scale 0.95 to 1.0 over 0.25 s easeOut. Min drag distance 10 pt.
7. Task complete: checkbox spring(response 0.30, dampingFraction 0.7); strikethrough 0.20 s easeOut; row moves to Completed after 0.6 s over 0.30 s easeInOut; undo toast 3.0 s.
8. Numbers: .contentTransition(.numericText()) + .snappy(duration: 0.30).
9. Daily Goal ring: trim 0.60 s easeOut; pulse 1.0 to 1.04 to 1.0 over 0.40 s at 80% and 100%.
10. Focus start: zoom or matchedGeometry transition from Start Focus, 0.30 s easeInOut (18 frames at 60 Hz).
11. Focus screen: tap the countdown toggles pause/resume; long press (0.6 s) on Finish opens the confirm dialog; swipe down minimises (Live Activity continues). Pause dims digits to 0.55 over 0.20 s.
12. Sheets: spring(response 0.35, dampingFraction 0.85), detents [.medium, .large], drag indicator visible, corner radius 24.
13. Scrolling: native large-title collapse. One .scrollTransition per screen at most (opacity 1.0 to 0.0, scale 1.0 to 0.96).
14. Keyboard: @FocusState, Return advances fields, toolbar Done dismisses, add-task sheet opens with keyboard up.
15. Tab bar: tap active tab scrolls to top; tap again pops to root.
16. Pull to refresh on Today (.refreshable, under 0.5 s).
17. Empty states fade in 0.25 s easeOut: SF Symbol 48 pt + one line + one primary button.
18. Live Activity and widgets: interactive Pause/Resume (App Intents), deep link study://focus.
19. Session complete: spring(response 0.4, dampingFraction 0.8), stats count up over 0.6 s easeOut, .success haptic.
20. Toasts: slide up 0.30 s easeInOut, hold 3.0 s, slide down 0.25 s; undo is a ghost link.
Accessibility for all: Reduce Motion swaps springs and flips for 0.15 s crossfades; VoiceOver labels on every control; Reduce Transparency and Increase Contrast respected; Dynamic Type to AX5; haptics respect system setting.
INTERACTION BUDGET: max 1 primary transition and 1 secondary animation visible at once; never animate more than 3 views simultaneously; no idle or looping animation.
</composition>

<color-system>
Defer to DESIGN.md. Tokens (light / dark):
- appleBlue #0071E3 / #0071E3: filled primary buttons and selected states ONLY. Never text, borders, decoration.
- linkBlue #0066CC / #2997FF: outlined secondary buttons, inline links.
- signalBlue #2997FF / #2997FF: decorative only (icon strokes).
- canvas #F5F5F7 / #000000. wash #F4F8FB / #1D1D1F. pebble #E2E2E5 / #333333.
- carbon (text) #1D1D1F / #F5F5F7. ash (muted) #707070 / #A1A1A6. hairline #D2D2D7 / #333333.
- success #248A3D / #30D158. error #D70015 / #FF453A (feedback only).
The dark column, success, error and dark ash are inferred additions (DESIGN.md is light only); mark them "proposed" in DESIGN_NOTES.md.
Subject dots (10 pt, identification only): Blue #0A84FF, Green #30D158, Orange #FF9F0A, Red #FF453A, Purple #BF5AF2, Teal #64D2FF, Pink #FF375F, Yellow #FFD60A. Defaults: Maths Blue, Science Green, English Orange, Social Studies Purple.
Rules: flat fills only; no gradients, glows or colored shadows; no shadows at all except none (drag-lift uses scale and surface shift). Cards, images, inputs 8 pt radius; buttons capsule. No cards inside the canvas: rows and hairlines only. One accent per screen. Contrast at least 4.5:1 in both modes. All colors in the asset catalog and Core/DesignSystem/Colors.swift; no hex literals elsewhere. .regularMaterial only for Live Activity background and sheet toolbars.
</color-system>

<algorithm>
FOCUS TIMER
- Focus 25 min, short break 5, long break 15; long break after every 4th completed focus. Custom 1 to 180 min.
- Timestamp-based: remaining = endDate - now. Never rely on background execution. Pause stores remaining seconds; resume sets a new endDate. Record actual elapsed seconds.
- Completed if elapsed is at least 90% of planned. Under 5 minutes elapsed on Finish: no XP, no guilt, copy "Short one. Try again when ready."
- Break auto-start is OFF by default (autonomy), toggle in Settings.
SPACED REPETITION (SM-2 inspired)
- Ease starts 2.5, min 1.3. Grades: Again 0, Hard 3, Good 4, Easy 5.
- Reps: first success 1 day, second 6 days, then round(previous interval x ease).
- Ease update: ease = max(1.3, ease + 0.1 - (5 - q) x (0.08 + (5 - q) x 0.02)).
- Again: repetitions 0, due in 10 minutes, ease minus 0.2 (floor 1.3).
- "Mastered" = interval of 21 days or more.
- Daily new-card cap 10. Review session default 20 cards; Quick 5 option. Sort: due-first, overdue-first, interleave subjects.
- After each grade, show "Next review in N days" (0.25 s fade, 1.2 s hold).
- Calendar-safe date math via Calendar.current.
QUIZ
- 10 questions from selected decks, shuffled, no duplicates, explanation after every answer, wrong answers re-queued once at the end ("retry round"), accuracy tracked, never invent curriculum facts.
XP AND LEVELS (fixed, published rules)
- 10 XP per completed 10 min of focus (cap: stops at 240 focus min per day).
- 5 XP per correct card. 20 XP once per day on reaching Daily Goal. 20 XP Setup bonus once.
- XP to reach next level = 100 + 50 x (level - 1). Titles: L1 Starter, L3 Sharpener, L5 Locked In, L8 Deep Work, L12 Grandmaster.
- No XP for opening or closing the app.
STREAK
- A day counts with at least 10 min completed focus OR at least 10 cards reviewed. Local midnight boundary.
- 1 automatic rest day per rolling 7 days does not break the streak. Best streak is stored forever.
- Milestone badges (flat SF Symbols, fixed rules): 3-day, 7-day, 14-day, 30-day streak; first 100 cards mastered; first 10 hours of focus; first perfect quiz; first Level 5.
NOTIFICATIONS
- Local only. Permission requested after the first completed session, never on launch.
- Cue time from onboarding chip (4, 6, 7 or 8 PM): fire 10 min before. If "Not sure": 7 PM.
- Max 1 per day, quiet hours 21:00 to 07:00, none if cards are not due and no session is planned, auto-pause after 3 ignored in a row then ask once.
</algorithm>

<editorial-details>
Starter content (labelled "Sample", Class 8 level, verified correct; replaceable once the exact syllabus is known): subjects Mathematics, Science, English, Social Studies.
Decks, 5 cards each minimum:
Mathematics Fundamentals: What is a prime number? A number greater than 1 with exactly two positive factors. / What is 7²? 49. / What is a fraction? A representation of part of a whole. / What is the perimeter of a square? 4 x side length. / What is 25% of 200? 50.
Science Foundations: What is photosynthesis? The process by which green plants use light energy to make food. / What is an atom? The basic unit of an element. / What is evaporation? Conversion of liquid into gas. / What is a force? A push or pull. / What is the SI unit of force? Newton.
English Basics and Social Studies Basics: author 5 correct, age-appropriate cards each; never invent facts; add an explanation field to every card.
Alternate app icons: 3 (light, dark, tinted), flat, single glyph.
Week in review sheet: focus minutes, sessions, cards reviewed, best day, one encouragement line. Screenshot-friendly, flat, no branding clutter.
Privacy line in About: "Everything stays on this phone."
</editorial-details>

<implementation>
Persistence: SwiftData with VersionedSchema and SchemaMigrationPlan from day one. Entities: Subject(id, name, colorHex, createdAt, sortOrder), Topic(id, title, subjectID, completed, sortOrder), StudyTask(id, title, notes?, subjectID?, dueDate?, completed, createdAt), StudySession(id, subjectID?, startDate, endDate?, plannedSeconds, actualSeconds, completed), Deck(id, name, subjectID?, isSample, createdAt), Flashcard(id, deckID, question, answer, explanation?, createdAt), ReviewState(id, flashcardID, easeFactor, repetitions, intervalDays, dueDate, lastReviewed?), DailyStat(id, day, focusSeconds, xp, cardsReviewed, cardsCorrect), Badge(id, kind, earnedAt), StudySettings(id, dailyGoalMinutes, focusMinutes, shortBreakMinutes, longBreakMinutes, remindersEnabled, reminderCueHour, autoStartBreaks). JSON export via ShareLink and import via fileImporter.
Services (logic outside views): TimerService, SchedulerService, StreakService, XPService, NotificationService, BadgeService, ExportService.
Folders: App/, Core/{Models,Persistence,Services,DesignSystem(+Interactions)}, Features/{Today,Study,Review,Focus,Progress,Settings,Onboarding}, Widgets/{HomeWidgets,LiveActivities,Intents}, Resources/, Tests/.
Live Activity: static attributes (subject, sessionType, plannedSeconds); ContentState (endDate, isPaused, remainingSeconds). Countdown via Text(timerInterval:). Compact: subject dot + countdown. Minimal: progress ring. Expanded: subject, countdown, Pause/Resume button. Lock Screen: countdown, subject, progress. Local updates only, on start, pause, resume, end. Info.plist: NSSupportsLiveActivities = YES.
App Intents: StartFocusIntent, PauseFocusIntent, ResumeFocusIntent, EndFocusIntent (LiveActivityIntent where needed).
BUILD PIPELINE (free): develop on Windows, push to a PUBLIC GitHub repo (free macOS minutes), CI on runs-on: xcode-27: checkout, brew install xcodegen, xcodegen generate, xcodebuild for generic/platform=iOS with CODE_SIGNING_ALLOWED=NO, unit tests on an iOS 27 simulator, package unsigned .ipa, upload artifact Study-unsigned-ipa. Download with gh run download --name Study-unsigned-ipa --dir .\build. Install with the free 7-day refresher app (AltStore Classic via AltServer on Windows, requires the web-installer versions of iTunes and iCloud from Apple, not the Microsoft Store versions; or SideStore or Sideloadly) signed with a free Apple ID. Refresh routine: keep AltServer running on the PC, same Wi-Fi as the iPhone, open the refresher app at least once every 5 days. No TrollStore, jailbreaks or signing bypasses.
Windows rules: .gitattributes forces LF for swift, yml, yaml, plist, pbxproj, sh. Conventional Commits. One feature per commit. Fix only the first CI error at a time.
</implementation>

<performance>
Cold launch under 1.0 s (best effort). Timer-running within 6 s of tapping the app icon. Tap response under 100 ms. 60 fps minimum, aim for 120 Hz ProMotion (CADisableMinimumFrameDurationOnPhone = YES). A 0.30 s animation is 18 frames at 60 Hz and 36 at 120 Hz. Memory under 120 MB. Installed size under 40 MB. Zero network requests, zero background polling. No allocations inside gesture onChanged. No sorting, filtering or date math in a view body. Live Activity updates only on state change. Max 1 notification per day.
</performance>

<validation>
FUNCTIONAL (all on a physical iPhone 17, not only CI):
1. App launches without crashing.
2. Onboarding (3 screens) completes and persists after relaunch.
3. Subjects can be created, edited, deleted, reordered.
4. Tasks can be added, completed, undone.
5. Focus timer starts and counts down correctly.
6. Timer stays accurate after 5 min in the background.
7. Pause and resume keep remaining time within 1 s.
8. Completed sessions persist after force-quit.
9. Dynamic Island shows the active session (compact, minimal, expanded).
10. Lock Screen Live Activity counts down and reflects pause.
11. Home widget shows correct streak and today's minutes (or its documented fallback).
12. App Intents perform the correct action.
13. Grades map to Again 0, Hard 3, Good 4, Easy 5.
14. Intervals follow 1 day, 6 days, then x ease; Again returns in 10 minutes.
15. Data survives an app update and a JSON export then import round trip.
16. App survives a 7-day refresh cycle with the free refresher app and data intact.
INTERACTION: 17. PressableStyle on every button. 18. Swipe actions, context menus, drag reorder on tasks, subjects, topics. 19. Flashcard drag grades correctly in all 4 directions and flip works. 20. Reduce Motion replaces springs and flips with crossfades. 21. VoiceOver reads every control sensibly. 22. Dynamic Type AX5 does not clip primary actions.
PSYCHOLOGY AND UX: 23. Launch to running timer in at most 2 taps and 6 s. 24. Onboarding takes at most 3 screens and under 45 s. 25. Zero guilt, shame or urgency strings (grep against banned list). 26. Streak break shows "Fresh start. Day 1." and Best streak is preserved. 27. 1 rest day per rolling 7 days works. 28. XP from focus stops at 240 min/day and the "Go outside" line appears. 29. Max 1 notification per day and quiet hours respected. 30. Session end screen shows the 3 stats count-up, one encouragement line, one Continue action. 31. "Next review in N days" appears after every grade. 32. Rewards follow the fixed published rules (no randomness).
PROCESS: 33. docs/SKILLS_USED.md has at least one entry per phase and every listed file exists in .agents/. 34. DESIGN_NOTES.md has zero unresolved rows. 35. CI is green from a clean clone.
</validation>

<gotchas>
- Audience is the 14-year-old brother, not me. Do not tune the UX to my taste.
- Superseded earlier decisions: "no unnecessary animations" is replaced by the interaction catalog and budget; screen radii 12/16 pt are replaced by 8 pt and capsule; drag-lift shadow is removed; "no streak grace period" is replaced by 1 automatic rest day per rolling 7 days; onboarding shrinks from 7 steps to 3; target iOS 26 is replaced by iOS 27 with Xcode 27 and runs-on: xcode-27.
- DESIGN.md is a light-theme web reference. The dark mapping, success/error colors and the iOS pt translation are inferred; document them in DESIGN_NOTES.md.
- The borrowed Mac runs macOS 12 and cannot build this. Ignore it.
- Free signing: 7-day expiry (refresher app handles it while AltServer is running), possible limits on active apps, App IDs per week, App Groups and extensions. A widget extension counts toward limits. Test in Phase 0 with a minimal app. A simulator or CI success proves nothing about on-device install.
- Without App Groups, the widget cannot read SwiftData; use the fallback in canvas. Never silently drop a feature.
- The refresher app needs the PC on and AltServer running to refresh; if it lapses, the app stops launching until re-signed. Data survives re-signing but not deleting the app. Do not promise otherwise.
- NSSupportsLiveActivities = YES must be set or Live Activities fail silently.
- Do not hand-edit .xcodeproj; XcodeGen on CI generates it. If XcodeGen fails on the iOS 27 SDK, fall back to a Swift Package plus a minimal hand-written pbxproj and say so.
- CRLF line endings can break CI; .gitattributes prevents it.
- Skills in .agents/ may reference macOS tools; translate to CI equivalents and log it.
- Curriculum is unconfirmed (board and syllabus). Keep content generic, labelled "Sample", never invent facts.
- Gamification is a seasoning, not the meal. If a mechanic does not help him study more, study better, or feel good about it honestly, cut it.
- Do not dump the whole app in one block. Work in phases and report after each.
</gotchas>
