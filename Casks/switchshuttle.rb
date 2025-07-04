cask "switchshuttle" do
  version "1.7.0"

  url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_universal.dmg"
  sha256 "64bd8e0595a98d72a4ecc286c1ef700084c1b931a3aabbc8093b5f6008a39e9a"

  name "SwitchShuttle"
  desc "Cross-platform terminal command manager with global hotkeys - organize, customize, and quickly access your most-used terminal operations with a sleek interface"
  homepage "https://github.com/s00d/switchshuttle"

  app "switch-shuttle.app"

  postflight do
    system_command "chmod", args: ["+x", "/Applications/switch-shuttle.app"]
    system_command "xattr", args: ["-cr", "/Applications/switch-shuttle.app"]
    system_command "codesign", args: ["--force", "--deep", "--sign", "-", "/Applications/switch-shuttle.app"]
  end

  # Uncomment the following lines if you want to remove configuration on uninstall
  # zap trash: [
  #   "~/.config/switch-shuttle",
  #   "~/Library/Application Support/switch-shuttle",
  #   "~/Library/Preferences/com.SwitchShuttle.app.plist",
  #   "~/Library/Saved Application State/com.SwitchShuttle.app.savedState"
  # ]
end
