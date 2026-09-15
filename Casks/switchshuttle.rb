cask "switchshuttle" do
  version "2.1.2"

  url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_universal.dmg"
  sha256 "ee892d2cac50a1ded433ee258f43c83abe2244f77f2502c6a5d7fe2fc4911971"

  name "SwitchShuttle"
  desc "Cross-platform terminal command manager with global hotkeys - organize, customize, and quickly access your most-used terminal operations with a sleek interface"
  homepage "https://github.com/s00d/switchshuttle"

  app "switch-shuttle.app"

  preflight_steps do
    terminate_process "switch-shuttle", match: :full
  end

  postflight_steps do
    run "/usr/bin/open", args: ["{{appdir}}/switch-shuttle.app"]
  end

  # Uncomment the following lines if you want to remove configuration on uninstall
  # zap trash: [
  #   "~/.config/switch-shuttle",
  #   "~/Library/Application Support/switch-shuttle",
  #   "~/Library/Preferences/com.SwitchShuttle.app.plist",
  #   "~/Library/Saved Application State/com.SwitchShuttle.app.savedState"
  # ]
end
