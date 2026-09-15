cask "switchshuttle" do
  version "2.2.0"
  sha256 "39e92f5fd680e709656e847d962c64fcddb7d360616b0a57b548280fa0fe1bba"

  url "https://github.com/s00d/switchshuttle/releases/download/app-v#{version}/switch-shuttle_#{version}_universal.dmg"
  name "SwitchShuttle"
  desc "Menu bar terminal command manager with global hotkeys"
  homepage "https://github.com/s00d/switchshuttle"

  depends_on :macos

  # postflight_steps are seatbelted: (deny lsopen) blocks /usr/bin/open, and
  # exec'ing Contents/MacOS/* aborts in RegisterApplication. Classic postflight
  # can open but is deprecated. Homebrew's unsandboxed path is installer script
  # (same pattern as amazon-music). Installer runs before an `app` move would,
  # so the script places the .app itself, then launches via Launch Services.
  generated_script "brew-install.sh", content: <<~SH
    #!/bin/bash
    set -euo pipefail
    SRC="#{staged_path}/switch-shuttle.app"
    DST="#{appdir}/switch-shuttle.app"
    /bin/rm -rf "${DST}"
    /usr/bin/ditto "${SRC}" "${DST}"
    /usr/bin/xattr -dr com.apple.quarantine "${DST}" || true
    /usr/bin/open "${DST}" || true
  SH
  installer script: {
    executable: "brew-install.sh",
  }

  preflight_steps do
    terminate_process "switch-shuttle", match: :full
  end

  uninstall quit:   "com.SwitchShuttle",
            delete: "#{appdir}/switch-shuttle.app"

  caveats <<~EOS
    SwitchShuttle runs from the menu bar (system tray).
  EOS
end
