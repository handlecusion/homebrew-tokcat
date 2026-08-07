cask "tokcat" do
  version "0.2.1"
  sha256 "3779d92d9848cf837e307b46ddd764b9f011aa10568b82bb53b5afd2a8e6307d"

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
