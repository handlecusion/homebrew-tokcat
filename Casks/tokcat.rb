cask "tokcat" do
  version "0.2.8"
  sha256 "a0c6c11c479888655b558a5139f4ddf2532aa9c502ff3e257e498dba63d5a053"

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
