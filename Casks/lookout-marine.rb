cask "lookout-marine" do
  version "0.2.0"
  sha256 "73fc45cb532dff73973484125badd58d4e2ccbc91dd3c1cd4f993aa27c3e2ddc"

  url "https://github.com/beetlebugorg/lookout-marine/releases/download/v#{version}/LookoutMarine-#{version}-macos-arm64.dmg"
  name "Lookout Marine"
  desc "S-57/S-101 chartplotter"
  homepage "https://github.com/beetlebugorg/lookout-marine"

  depends_on arch: :arm64
  depends_on macos: ">= :tahoe"

  app "LookoutMarine.app"
end
