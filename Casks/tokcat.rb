cask "tokcat" do
  version "0.2.3"
  sha256 "ee26e0ab465bcee674e2846bfdc6dc807a4fe64a8c0fb7d5d02884f35a0d266a"

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
