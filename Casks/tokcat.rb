cask "tokcat" do
  version "0.2.6"
  sha256 "f4f601b63405e3b2ef36833ef709b76fc47465821daa5531673e618192b4a3f7"

  url "https://github.com/handlecusion/tokcat/releases/download/v#{version}/Tokcat_#{version}_universal.dmg"
  name "Tokcat"
  desc "AI token usage monitor for the macOS menu bar"
  homepage "https://github.com/handlecusion/tokcat"

  depends_on macos: ">= :ventura"

  app "Tokcat.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tokcat.app"],
                   sudo: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Tokcat.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.handlecusion.tokcat",
    "~/Library/WebKit/com.handlecusion.tokcat",
  ]
end
