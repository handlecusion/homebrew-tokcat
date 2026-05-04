cask "tokcat" do
  version "0.1.10"
  sha256 "e476e95e1927f72e62539436a9840ddce1d17faf2dde69ecaff02f1a10399e24"

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_aarch64.dmg"
  name "Tokcat"
  desc "Menubar dashboard for tokscale CLI token usage"
  homepage "https://github.com/handlecusion/tokcat"

  depends_on macos: ">= :big_sur"
  depends_on formula: "tokscale"

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
