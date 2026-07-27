cask "tokcat" do
  arch arm: "aarch64", intel: "x64"
  version "0.1.41"
  sha256 arm:   "2cba09eb75955d3a85001ad755d1f2692671d114454e38e3645e7c9ac2e99e02",
         intel: "68c3781c56a9cbee9fcbf4aba4fa728ac68a6b699c545893538402353e241905"

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
