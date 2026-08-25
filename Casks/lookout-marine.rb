cask "lookout-marine" do
  version "0.1.0"
  sha256 "45c96affd31b019f7ee7be23b23e901a6554c76bc02fe6c763e0d8c601e68c8b"

  url "https://github.com/beetlebugorg/lookout-marine/releases/download/v#{version}/LookoutMarine-#{version}-macos-arm64.dmg"
  name "Lookout Marine"
  desc "S-57/S-101 chartplotter"
  homepage "https://github.com/beetlebugorg/lookout-marine"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "LookoutMarine.app"
end
