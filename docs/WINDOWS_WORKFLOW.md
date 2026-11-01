# WINDOWS_WORKFLOW.md

Step-by-step Windows 11 development, build, and sideload routine for **Study**.

---

## 1. Prerequisites (One-Time Setup on Windows 11)

### A. Apple Services (Web Installers Only — NOT Microsoft Store)
AltServer requires the direct Win32 web-installer builds of iTunes and iCloud to hook into device sync services:
1. **Uninstall** any Microsoft Store versions of iTunes or iCloud if installed.
2. **Download & Install iTunes (Windows 64-bit direct installer):**
   - Download directly from Apple: `https://www.apple.com/itunes/download/win64`
   - Run installer, complete setup, and sign into your Apple ID.
3. **Download & Install iCloud (Windows direct installer):**
   - Download direct setup: `https://updates.cdn-apple.com/2020/windows/001-39935-20200911-1A70AA56-F448-11EA-8109-8148443B55B8/iCloudSetup.exe`
   - Run installer, reboot PC if prompted, and sign in.

### B. AltServer on Windows
1. Download AltInstaller for Windows from `https://altstore.io`.
2. Extract `altinstaller.zip` and run `setup.exe`.
3. Launch **AltServer** from Start menu. It runs in the Windows notification tray (near the clock).
4. If Windows Firewall prompts, allow AltServer access on Private networks.

### C. iPhone Developer Mode Setup (iOS 16+)
1. On iPhone 17, go to **Settings > Privacy & Security**.
2. Scroll to the bottom and tap **Developer Mode**.
3. Toggle Developer Mode **ON** and follow the prompt to reboot the iPhone.
4. After reboot, unlock device and tap **Turn On** on the confirmation dialog, then enter passcode.

---

## 2. Daily Build & Sideload Loop

### Step 1: CI Build & Download Unsigned IPA
1. Push branch to GitHub: `git push origin main`.
2. Monitor CI run:
   ```powershell
   gh run watch
   ```
3. If CI fails, inspect the first failed line:
   ```powershell
   gh run view --log-failed
   ```
4. When green, download the unsigned `.ipa` artifact:
   ```powershell
   gh run download --name Study-unsigned-ipa --dir .\build
   ```
   The downloaded file lands at `.\build\Study-unsigned-ipa.ipa`.

### Step 2: Sideloading onto iPhone 17 via AltServer / Sideloadly

#### Option A: AltStore Classic
1. Connect iPhone 17 to Windows PC via USB-C cable (ensure "Trust This Computer" is confirmed on iPhone).
2. Open iTunes and verify your iPhone appears in the top device bar.
3. In iTunes under iPhone summary, check **"Sync with this iPhone over Wi-Fi"** and click **Apply**.
4. In Windows system tray, click the **AltServer** icon (diamond shape) > **Install AltStore** > Select your iPhone.
5. Enter your free Apple ID and password (credentials go directly to Apple servers to generate 7-day cert).
6. On iPhone, go to **Settings > General > VPN & Device Management**, tap your Apple ID under Developer App, and tap **Trust**.
7. Open AltStore on iPhone, tap **My Apps** > **+** icon, browse to or AirDrop/transfer `Study-unsigned-ipa.ipa`, and install.

#### Option B: Direct Sideloadly (Alternative 1-Click Sideload on Windows)
1. Download and run Sideloadly (`https://sideloadly.io`) on Windows.
2. Drag `.\build\Study-unsigned-ipa.ipa` into Sideloadly.
3. Enter your Apple ID.
4. Click **Start**. Sideloadly signs and installs the app and widget extensions directly to your connected iPhone.

---

## 3. 7-Day Auto-Refresh Routine

Free Apple Developer IDs issue certificates valid for exactly **7 days**.
- **Wi-Fi Background Refresh:** Keep PC turned on with AltServer running in the tray and connected to the same Wi-Fi network as your iPhone.
- AltStore will periodically refresh the app certificate in the background over local Wi-Fi.
- **Manual 5-Day Safety Refresh:** Open AltStore on iPhone once every 5 days and tap **Refresh All** under My Apps to prevent certificate expiration.
