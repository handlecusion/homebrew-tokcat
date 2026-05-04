cask "tokcat" do
  version "0.1.3"
  sha256 :no_check

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_aarch64.dmg"
  name "Tokcat"
  desc "Menubar dashboard for tokscale CLI token usage"
  homepage "https://github.com/handlecusion/tokcat"

  depends_on macos: ">= :big_sur"
  depends_on formula: "tokscale"

  app "Tokcat.app"

  postflight do
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
