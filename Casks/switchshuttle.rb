cask "switchshuttle" do
  version "2.2.0"

  url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_universal.dmg"
  sha256 "39e92f5fd680e709656e847d962c64fcddb7d360616b0a57b548280fa0fe1bba"

  name "SwitchShuttle"
  desc "Cross-platform terminal command manager with global hotkeys - organize, customize, and quickly access your most-used terminal operations with a sleek interface"
  homepage "https://github.com/s00d/switchshuttle"

  app "switch-shuttle.app"

  preflight_steps do
    terminate_process "switch-shuttle", match: :full
  end

  # App is Developer ID + notarized + stapled. Homebrew still stamps
  # com.apple.quarantine on the DMG payload → Gatekeeper "could not verify".
  # Clear quarantine here. Do NOT call /usr/bin/open: seatbelt denies LS
  # (kLSNoExecutableErr). Do NOT exec Contents/MacOS/*: AppKit aborts in
  # RegisterApplication without a proper .app launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/switch-shuttle.app"],
        writable_paths: ["switch-shuttle.app"],
        writable_base:  :appdir,
        must_succeed:   false
  end

  caveats <<~EOS
    SwitchShuttle runs from the menu bar (system tray).
    Open it once from Applications (or Spotlight) after install.
  EOS
end
