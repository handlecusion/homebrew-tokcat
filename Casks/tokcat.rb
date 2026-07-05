cask "tokcat" do
  arch arm: "aarch64", intel: "x64"
  version "0.1.33"
  sha256 arm:   "4c0fac57ecc982040bf63639ef707d190585603444fb729b233951f94bb38db8",
         intel: "16563baf3d08f214ed43d35b9dc799961e3464f916e9535ae054bbbd8b3a1f9e"

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_#{arch}.dmg"
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
