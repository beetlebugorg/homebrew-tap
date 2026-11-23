# The Mac app of zslice: a universal app, signed with a Developer ID and
# notarized. packaging/homebrew/tap.sh in the zslice repository writes this
# file for each release.
cask "zslice" do
  version "0.6.0-beta"
  sha256 "6aa229a989e3dbf8e4cb3469c3361ceb052f48f6e9319f9472be2ce522d1db7b"

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
