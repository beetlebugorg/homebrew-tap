class Tile57 < Formula
  desc "Nautical chart engine: IHO S-101 and S-57 charts to tiles, PNG, and PDF"
  homepage "https://github.com/beetlebugorg/tile57"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.4.0/tile57-0.4.0-aarch64-macos.tar.gz"
      sha256 "1eccb3f3087965a26d76fcde858112605086e9adf1a4b3c8bae278487da91f29"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.4.0/tile57-0.4.0-x86_64-macos.tar.gz"
      sha256 "4b95a701c87afac350ce08e4fedae10ed1d98b54dee938d13a5a718051813ea6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.4.0/tile57-0.4.0-aarch64-linux-gnu.tar.gz"
      sha256 "65577ae5d5f0bf8e101f37e6d380d9404306e925d76167ec30141a960b9b0df3"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.4.0/tile57-0.4.0-x86_64-linux-gnu.tar.gz"
      sha256 "a633c63be078c077aa605e1fd2ee8b273078491b8fbbe963e7bbd508262ad98a"
    end
  end

  def install
    bin.install "bin/tile57"
    lib.install "lib/libtile57.a"
    include.install "include/tile57.h"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tile57 version 2>&1")
  end
end
