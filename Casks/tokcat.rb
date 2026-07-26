cask "tokcat" do
  arch arm: "aarch64", intel: "x64"
  version "0.1.40"
  sha256 arm:   "5879c4211687d91789f91982cb2d708b37dcf97390a309e0a9f3439654bd2d1a",
         intel: "cdfaa5c7c9512ddc8b62001152478ce586ff687c0fa40bf94b2c62e80e3eb23a"

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
