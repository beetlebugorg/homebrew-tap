# The Mac app of zslice: a universal app, signed with a Developer ID and
# notarized. packaging/homebrew/tap.sh in the zslice repository writes this
# file for each release.
cask "zslice" do
  version "0.6.1-beta"
  sha256 "bafdcf2db116ef08b0b2cb9e4be07e358d766e5a7384a668be01dc9089d703dd"

  url "https://github.com/beetlebugorg/zslice/releases/download/v#{version}/zslice-#{version}-macos-universal.dmg"
  name "zslice"
  desc "Slicer for FDM 3D printers"
  homepage "https://zslice.beetlebug.org/"

  depends_on macos: :sonoma

  app "zslice.app"

  zap trash: [
    "~/Library/Application Support/zslice",
    "~/Library/Preferences/org.beetlebug.zslice.plist",
    "~/Library/Saved Application State/org.beetlebug.zslice.savedState",
  ]
end
