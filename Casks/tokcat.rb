cask "tokcat" do
  version "0.3.2"
  sha256 "8bf5405ba50ca0a37502011f089741b133ee8f439565f9354962156ec0c835af"

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
