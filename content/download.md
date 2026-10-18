---
title: "Download Spindle"
description: "A small app for Windows and macOS. While you play, it reads World of Warcraft's combat log file and uploads it, so Spindle can show how each key went. It reads the log and a few game files, and never touches the running game."
layout: "download"
platforms:
  - key: "windows-x64"
    os: "Windows"
    file: "Spindle-windows-x64-setup.exe"
    needs: "Windows 10 or 11, 64-bit (Windows on Arm runs it emulated). Installs for you only, with no administrator prompt."
  - key: "macos-universal"
    os: "macOS"
    file: "Spindle-macos-universal.dmg"
    needs: "macOS 13 Ventura or later, on Apple silicon or Intel."
---

[What Spindle reads](/privacy/) lists every file, and what it never does.

## On Windows

1. **Download** the installer. If your browser says it "isn't commonly downloaded", open the download's **…** menu, choose **Keep**, then **Show more › Keep anyway**.
2. **Run it.** The installer is signed by **Bryan Ray**, Spindle's developer. While the signature is new, Windows may still show **Windows protected your PC**: click **More info**, check it names `Spindle-…-setup.exe` and **Publisher: Bryan Ray**, then **Run anyway**. If it says "Unknown publisher", don't run it: download it again from this page.
3. Leave **Run Spindle** ticked at the end. Its icon appears by the clock (perhaps under the **^** arrow), and the welcome window opens. It starts when you log in from then on; you can turn that off in its Settings.

If Windows 11 says **Smart App Control blocked an app**, there's no Run anyway: Smart App Control allows a new publisher only once it has a reputation. Wait for a later release, or turn Smart App Control off in Windows Security › App & browser control › Smart App Control settings. Only recent versions of Windows 11 can turn it back on afterwards.

## On macOS

1. **Open the `.dmg` and drag Spindle onto Applications** before opening it. From anywhere else, it can't start at login.
2. **Open Spindle from Applications.** It's signed, and notarized by Apple, so macOS asks once whether to open an app downloaded from the internet: click **Open**.
3. Its icon appears in the menu bar, and the welcome window opens. macOS may say **Background Items Added**: that's Spindle starting at login, which you can turn off in its Settings.

If macOS says Spindle **is damaged** or can't be checked for malicious software, that's our build's fault, not yours: please tell us, and don't work around it.

## Then sign in

In the welcome window, click **Sign in**: Spindle's site opens to approve it, one click with your Battle.net sign-in. Then play a key with advanced combat logging on. Spindle can add its addon, which turns logging on for you in dungeons and raids. Your keys show on your home page as each one ends.

Spindle keeps itself up to date, installing each new version between keys once it has checked the signature.
