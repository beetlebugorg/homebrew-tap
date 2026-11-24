# The Mac app of zslice: a universal app, signed with a Developer ID and
# notarized. packaging/homebrew/tap.sh in the zslice repository writes this
# file for each release.
cask "zslice" do
  version "0.6.2-beta"
  sha256 "5e4c06f5d9ec234dccd67a3136d64a24eb81e1801d2487c5013e5df019a9d19c"

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
