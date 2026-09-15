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
  # com.apple.quarantine on the downloaded DMG payload, which triggers
  # Gatekeeper's "Apple could not verify…" on first open.
  # Strip quarantine in classic (unsandboxed) postflight, then launch via LS.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-cr", "#{appdir}/switch-shuttle.app"],
                   must_succeed: false
    system_command "/usr/bin/open",
                   args:         ["#{appdir}/switch-shuttle.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    SwitchShuttle runs from the menu bar (system tray).
    If it did not appear after install, open it once from Applications.
  EOS
end
