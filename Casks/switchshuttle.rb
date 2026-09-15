cask "switchshuttle" do
  version "2.2.0"

  url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_universal.dmg"
  sha256 "39e92f5fd680e709656e847d962c64fcddb7d360616b0a57b548280fa0fe1bba"

  name "SwitchShuttle"
  desc "Cross-platform terminal command manager with global hotkeys - organize, customize, and quickly access your most-used terminal operations with a sleek interface"
  homepage "https://github.com/s00d/switchshuttle"

  app "switch-shuttle.app"

  # Sandboxed install-steps DSL — fine for pkill-style helpers.
  preflight_steps do
    terminate_process "switch-shuttle", match: :full
  end

  # Launch must NOT use postflight_steps: those run inside Homebrew's seatbelt
  # sandbox, and `/usr/bin/open` then fails with kLSNoExecutableErr (-10827)
  # even though the .app is notarized and opens fine from Finder/Terminal.
  # Classic postflight runs unsandboxed (same as pre-migration).
  postflight do
    system_command "/usr/bin/open", args: ["#{appdir}/switch-shuttle.app"]
  end

  # Uncomment the following lines if you want to remove configuration on uninstall
  # zap trash: [
  #   "~/.config/switch-shuttle",
  #   "~/Library/Application Support/switch-shuttle",
  #   "~/Library/Preferences/com.SwitchShuttle.app.plist",
  #   "~/Library/Saved Application State/com.SwitchShuttle.app.savedState"
  # ]
end
