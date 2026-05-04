cask "tokcat" do
  version "0.1.11"
  sha256 "4b2555deb98c36c175953c794b91a39434dacda640e59d89b12b0974d434fe26"

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
