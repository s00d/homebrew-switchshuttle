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

  # Homebrew seatbelt forbids LaunchServices (`open` / `lsregister`) inside
  # postflight_steps — that is what caused kLSNoExecutableErr (-10827).
  # Official pattern (OrbStack, Keybase, Parallels): `run` the Mach-O / helper
  # directly. Background with nohup so brew does not wait on the tray app.
  # See: https://docs.brew.sh/Cask-Cookbook#cask-artifact-trust-and-sandboxing
  postflight_steps do
    run "/bin/bash", args: [
      "-c",
      'nohup "{{appdir}}/switch-shuttle.app/Contents/MacOS/SwitchShuttle" >/dev/null 2>&1 &',
    ]
  end

  caveats <<~EOS
    SwitchShuttle runs from the menu bar (system tray).
    If it did not appear after install, open it once from Applications.
  EOS
end
