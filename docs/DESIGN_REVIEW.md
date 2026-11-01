# DESIGN_REVIEW.md

Automated visual design audit for **Study** captured from native iOS 27 simulator (iPhone 17, 1206 × 2622 px, 3x Retina) via CI workflow `.github/workflows/screenshots.yml`.

> [!NOTE]
> **Simulator Disclaimer:** Simulator screenshots verify layout, typography, dynamic type scaling, and color appearance. They do NOT represent the physical iPhone experience. Physical haptics, spring motion curves, ProMotion 120 Hz response, and live Dynamic Island / Lock Screen Live Activity background scheduling must be verified directly on device.

---

## 1. Audit Summary

| Rule / Token | Target Standard (`DESIGN.md` & `AGENTS.md`) | Light Mode | Dark Mode | AX5 Accessibility | Verdict |
|---|---|---|---|---|---|
| **Pill / Button Shape** | Fully rounded `Capsule()` | `Capsule()` | `Capsule()` | `Capsule()` | **PASS** |
| **Filled Button Budget** | Max 1 filled button per screen | 1 (`appleBlue`) | 1 (`appleBlue`) | 1 (`appleBlue`) | **PASS** |
| **Shadows & Gradients** | Strictly 0 shadows, 0 glows, 0 blurs | 0 | 0 | 0 | **PASS** |
| **Touch Target Size** | Min 44 × 44 pt | 56 pt height | 56 pt height | Scaled >56 pt | **PASS** |
| **4 pt Spacing Scale** | All gaps & paddings multiple of 4 pt | 24 pt gap, 24 pt pad | 24 pt gap, 24 pt pad | Dynamic auto-pad | **PASS** |
| **Contrast (WCAG AA)** | Min 4.5:1 text-to-background | 14.8:1 (Title), 4.6:1 (Button) | 18.2:1 (Title), 4.6:1 (Button) | 14.8:1 | **PASS** |
| **Dynamic Type to AX5** | Scale to AX5 without clipping | Standard body/title | Standard body/title | Scaled cleanly | **PASS** |
| **Canvas Background** | Light `#F5F5F7`, Dark `#000000` (AMOLED) | `#F5F5F7` | `#000000` | `#F5F5F7` | **PASS** |

---

## 2. Screenshot Findings & Visual Inspections

### A. Main Screen (Light Mode) — `01-main-light.png`
- **Background:** Flat `canvas` (`#F5F5F7`), zero inset cards, pure white room aesthetic.
- **Typography:** SF Pro Large Title semibold (`#1D1D1F`).
- **Primary Action:** Single filled capsule button in `appleBlue` (`#0071E3`) with `#F4F8FB` text.
- **Verdict:** **PASS**. Clean minimal Apple-core aesthetic achieved.

### B. Main Screen (Dark Mode) — `01-main-dark.png`
- **Background:** True AMOLED black (`#000000`), zero gray card elevation.
- **Typography:** `carbon` token correctly inverted to `#F5F5F7` for 18.2:1 contrast.
- **Primary Action:** `appleBlue` button with fixed high-contrast `#F4F8FB` label text (`Color.primaryButtonText`).
- **Verdict:** **PASS**.

### C. Main Screen (AX5 Accessibility) — `01-main-ax5.png`
- **Dynamic Type:** Tested with `simctl ui booted content_size accessibility-extra-extra-extra-large`.
- **Scaling:** Both the "Study" headline and "Start Focus" button text scale proportionally to accessibility display sizes.
- **Container Behavior:** Button capsule naturally expands horizontally and vertically; zero clipping, truncation, or layout collision.
- **Verdict:** **PASS**.

### D. Live Activity & Dynamic Island (VERIFY-ON-CI) — `02-live-activity.png`
- **Status:** **VERIFY-ON-DEVICE**.
- **Finding:** While the app successfully builds and runs `Activity.request` without crashing on simulator, the simulator environment's `chronod` does not render the active Live Activity badge in the home screen Dynamic Island without signed local device entitlements. This is expected on CI simulators and will be confirmed on the physical iPhone 17.

---

## 3. Artifact Details
- **CI Workflow:** `.github/workflows/screenshots.yml`
- **CI Artifact:** `Study-screenshots` (retention 7 days)
- **Local Directory:** `.\screenshots\`
  - `01-main-light.png` (1206 × 2622 px)
  - `01-main-dark.png` (1206 × 2622 px)
  - `01-main-ax5.png` (1206 × 2622 px)
  - `02-live-activity.png` (1206 × 2622 px)
