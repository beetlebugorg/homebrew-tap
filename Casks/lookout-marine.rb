cask "lookout-marine" do
  version "0.3.0"
  sha256 "695253b5768aceefdd1aa1540c1372b5d9fc9b2bfa3a7d696a676df61fb03fa9"

  url "https://github.com/beetlebugorg/lookout-marine/releases/download/v#{version}/LookoutMarine-#{version}-macos-arm64.dmg"
  name "Lookout Marine"
  desc "S-57/S-101 chartplotter"
  homepage "https://github.com/beetlebugorg/lookout-marine"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "LookoutMarine.app"
end
