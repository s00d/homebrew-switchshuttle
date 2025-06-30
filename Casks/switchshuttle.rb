cask "switchshuttle" do
  version "1.5.2"

  if Hardware::CPU.intel?
    url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_x64.dmg"
    sha256 "9b60cbb00df48420f156c5fc93bcdae452f729a22794fa00ae66dd78434d0d23"
  else
    url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_aarch64.dmg"
    sha256 "9280e9e946836947f40c902e2d83fb6253d878ed0c8fb5f7f4db4dca4edce086"
  end

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
