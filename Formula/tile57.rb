class Tile57 < Formula
  desc "Nautical chart engine: IHO S-101 and S-57 charts to tiles, PNG, and PDF"
  homepage "https://github.com/beetlebugorg/tile57"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.0/tile57-0.3.0-aarch64-macos.tar.gz"
      sha256 "5c14c9a6a3effc99054c77e2b44bf8f4b88c6919b0c0a2cf52e6de1f35ea36be"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.0/tile57-0.3.0-x86_64-macos.tar.gz"
      sha256 "a110afd19b2b157a3d94f425319dea787147f1374c9b1d6b03033ecc530f267d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.0/tile57-0.3.0-aarch64-linux-gnu.tar.gz"
      sha256 "1ddf9422ea28f154e91415843b71ab7457ca247a48aaa3dd7cb33133974047af"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.0/tile57-0.3.0-x86_64-linux-gnu.tar.gz"
      sha256 "5a995cf44566d04d67703d4ee7c1ae1f70afd0a929f419091fa444f3f954e9c7"
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
