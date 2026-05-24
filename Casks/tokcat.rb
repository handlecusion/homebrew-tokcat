cask "tokcat" do
  version "0.1.21"
  sha256 "5e6e0626b69d97edfced3acfb3092cb5fec0b05f5b7110afa632260efa82a7f1"

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_aarch64.dmg"
  name "Tokcat"
  desc "Menubar dashboard for local AI token usage"
  homepage "https://github.com/handlecusion/tokcat"

  depends_on macos: ">= :big_sur"

  app "Tokcat.app"

  postflight do
    # Strip Gatekeeper quarantine and re-apply ad-hoc signature so the
    # unsigned-but-distributed app can launch on first run.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tokcat.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Tokcat.app"]
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
                   args: ["-f", "#{appdir}/Tokcat.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.handlecusion.tokcat",
    "~/Library/Preferences/com.handlecusion.tokcat.plist",
    "~/Library/Caches/com.handlecusion.tokcat",
    "~/Library/Saved Application State/com.handlecusion.tokcat.savedState",
    "~/Library/LaunchAgents/com.handlecusion.tokcat.plist",
  ]
end
