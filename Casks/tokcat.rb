cask "tokcat" do
  version "0.1.25"
  sha256 "1e3ff10d7a9998172572fb0afc12ebb667a771d28709cf949a58f6edf6edf261"

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_aarch64.dmg"
  name "Tokcat"
  desc "Menubar dashboard for local AI token usage"
  homepage "https://github.com/handlecusion/tokcat"

  depends_on macos: :big_sur

  app "Tokcat.app"

  postflight do
    # Strip Gatekeeper quarantine and re-apply ad-hoc signature so the
    # unsigned-but-distributed app can launch on first run.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tokcat.app"]
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Tokcat.app"]
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/" \
                   "LaunchServices.framework/Support/lsregister",
                   args: ["-f", "#{appdir}/Tokcat.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.handlecusion.tokcat",
    "~/Library/Caches/com.handlecusion.tokcat",
    "~/Library/LaunchAgents/com.handlecusion.tokcat.plist",
    "~/Library/Preferences/com.handlecusion.tokcat.plist",
    "~/Library/Saved Application State/com.handlecusion.tokcat.savedState",
  ]
end
