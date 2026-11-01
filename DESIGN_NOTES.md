# DESIGN_NOTES.md

How `DESIGN.md` rules and brand kit specifications are translated to native iOS for **Study**.

| DESIGN.md Rule / Token | Web Spec (DESIGN.md) | iOS Translation / Implementation | Status / Resolution | Notes |
|---|---|---|---|---|
| **Theme / Appearance** | Light theme only | Light & Dark appearance supported | Resolved | Dark mode uses true AMOLED black (`#000000`). Surface 0: `#000000`, Surface 1: `#1D1D1F`, Surface 2: `#333333`. |
| **Apple Blue** | `#0071E3` (`--color-apple-blue`) | `Color.appleBlue` | Resolved | Strictly for filled primary buttons and selected/active states. Never text, borders, or decoration. |
| **Link Blue** | `#0066CC` (`--color-link-blue`) | `Color.linkBlue` (`#0066CC` Light / `#2997FF` Dark) | Resolved | Outlined secondary buttons (1 pt border + text) and inline links. |
| **Signal Blue** | `#2997FF` (`--color-signal-blue`) | `Color.signalBlue` (`#2997FF`) | Resolved | Decorative only (icon strokes, subtle highlights). Never interactive fills or borders. |
| **Canvas (Surface 0)** | `#F5F5F7` (`--surface-canvas`) | `Color.canvas` (`#F5F5F7` Light / `#000000` Dark) | Resolved | Base app background. |
| **Wash (Surface 1)** | `#F4F8FB` (`--surface-elevated-wash`) | `Color.wash` (`#F4F8FB` Light / `#1D1D1F` Dark) | Resolved | Elevated section washes and sheets. |
| **Pebble (Surface 2)** | `#E2E2E5` (`--surface-pebble`) | `Color.pebble` (`#E2E2E5` Light / `#333333` Dark) | Resolved | Secondary button fill, pressed surfaces, inactive chart bars. |
| **Carbon (Primary Ink)** | `#1D1D1F` (`--color-carbon`) | `Color.carbon` (`#1D1D1F` Light / `#F5F5F7` Dark) | Resolved | Primary text and dark icon glyphs. |
| **Ash (Secondary Ink)** | `#707070` (`--color-ash`) | `Color.ash` (`#707070` Light / `#A1A1A6` Dark) | Resolved | Subtitles, captions, empty state copy, muted labels. Dark ash (`#A1A1A6`) maintains >4.5:1 contrast on black. |
| **Mist** | `#858585` (`--color-mist`) | `Color.mist` (`#858585`) | Resolved | Lightest functional gray for subtle secondary icon strokes. |
| **Hairline Dividers** | 1px border (`#D2D2D7` / `#333333`) | `Color.hairline` (`#D2D2D7` Light / `#333333` Dark) | Resolved | 1 pt dividers, row borders, and input outlines. |
| **Success Color** | Not in DESIGN.md | `Color.success` (`#248A3D` Light / `#30D158` Dark) | Resolved — Does NOT break rule | Restricted strictly to feedback icons and text (e.g. task done, correct answer). Never backgrounds, buttons, or borders. See verdict below. |
| **Error Color** | Not in DESIGN.md | `Color.error` (`#D70015` Light / `#FF453A` Dark) | Resolved — Does NOT break rule | Restricted strictly to feedback icons and text (e.g. destructive swipe action, wrong answer). Never backgrounds or buttons. See verdict below. |
| **Subject Dots** | Not in DESIGN.md | 10 pt system circle dots (Blue, Green, Orange, Red, Purple, Teal, Pink, Yellow) | Resolved | The ONLY extra chromatic element in the UI. Purely for identification/tagging. Never used for buttons, fills, or text. |
| **Chart Active Bar** | Not in DESIGN.md | `Color.appleBlue` for today's bar, `Color.pebble` for past/other bars | Resolved | Counts as a "selected/active" state under the single blue switch rule; past days remain neutral pebble. Does not break the single blue switch rule. |
| **Radii: Pills & Buttons** | 980px border-radius | `Capsule()` | Resolved | Non-negotiable for all buttons, chips, tags, and status pills. |
| **Radii: Cards & Inputs** | 8px border-radius | 8 pt continuous corner radius (`.rect(cornerRadius: 8)`) | Resolved | Applied to inputs, card-like containers, and modal sheets. Only two radii in app: Capsule and 8 pt. |
| **Elevation & Shadows** | No box shadows on UI | Zero drop shadows (`.shadow` banned) | Resolved | Elevation communicated strictly via surface shift (`canvas` -> `wash` -> `pebble`) and 1 pt hairlines. Drag lift uses `scaleEffect(1.03)` + pebble shift. |
| **Containers on Canvas** | No cards inside canvas | Content sits directly on `canvas` | Resolved | Plain lists (`.listStyle(.plain)`) with hairline dividers, no inset-grouped boxed panels. |
| **Typography Scale & Fonts** | SF Pro (Text/Display) in px | Native SF Pro via Dynamic Type in pt; SF Rounded for timer & XP digits | Resolved | Weights: 300 light, 400 regular, 600 semibold (never 700). Scales to AX5. Optical tracking managed natively. |
| **Timer Display** | Not in DESIGN.md | 84 pt SF Rounded semibold, `.monospacedDigit()`, `.contentTransition(.numericText())` | Resolved | Large focus countdown with `@ScaledMetric(relativeTo: .largeTitle)`. |

## Single Blue Switch Verdict

### 1. Success and Error Colors
- **Tokens:** `Color.success` (`#248A3D` Light / `#30D158` Dark) and `Color.error` (`#D70015` Light / `#FF453A` Dark).
- **Verdict:** **Does NOT break the "single blue switch" rule.**
- **Rationale:** 
  - They are purely semantic, transient feedback indicators (a 1 pt checkmark stroke upon task completion, a swipe-to-delete row indicator, or an inline review indicator).
  - They are strictly prohibited on button backgrounds, container fills, large borders, and primary navigation elements.
  - Interactive affordance remains 100% monochrome + Apple Blue (`#0071E3`). At rest, the screen remains a quiet white/black room with the single blue switch.

### 2. Subject Dots
- **Verdict:** **Does NOT break the rule.**
- **Rationale:** Restricted to a 10 pt circular glyph strictly for visual indexing of subjects. Never applied to typography, surfaces, or interactive buttons.

### 3. Active Chart Bar (appleBlue)
- **Verdict:** **Does NOT break the rule.**
- **Rationale:** Today's bar in the Progress focus chart qualifies as a selected/active state under section 5 of `AGENTS.md` ("selected/active states only"). Inactive bars remain neutral `pebble`.

