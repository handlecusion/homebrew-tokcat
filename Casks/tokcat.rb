cask "tokcat" do
  arch arm: "aarch64", intel: "x64"
  version "0.1.36"
  sha256 arm:   "4a385512651dd8f8bd59cf2f7038ba034d1a0d0fd66788c1b9e32ca8667562da",
         intel: "83b605a7a2e1390af6e8bffc7c8da6a2e87352f622274b33034ce75a7c7d31af"

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
