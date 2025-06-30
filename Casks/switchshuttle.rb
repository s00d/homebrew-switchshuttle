cask "switchshuttle" do
  version "1.5.3"

  if Hardware::CPU.intel?
    url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_x64.dmg"
    sha256 "2d342075fe32e696f8075542de4b5de73fadc13c7b7c92550b16487d6da83124"
  else
    url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_aarch64.dmg"
    sha256 "872f75bf7699fec205f49cf9dd9997ac2b97d910e7bba63e36216008844f6ec9"
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
