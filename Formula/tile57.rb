class Tile57 < Formula
  desc "Nautical chart engine: IHO S-101 and S-57 charts to tiles, PNG, and PDF"
  homepage "https://github.com/beetlebugorg/tile57"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.1/tile57-0.3.1-aarch64-macos.tar.gz"
      sha256 "d0e9bc66b92aa0583a6d0474b61773015cf1b0c8759bf9f2d8b71394f3d47e3e"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.1/tile57-0.3.1-x86_64-macos.tar.gz"
      sha256 "72bb9526c6e6bfaa6435e9a37a467f1ceafb38e8c7e9f37618e26e72d6e7bf13"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.1/tile57-0.3.1-aarch64-linux-gnu.tar.gz"
      sha256 "20d4aedc705ddb779a658e0760602657881ed37bb9ef10ddbb4c90d0025a4db5"
    end
    on_intel do
      url "https://github.com/beetlebugorg/tile57/releases/download/v0.3.1/tile57-0.3.1-x86_64-linux-gnu.tar.gz"
      sha256 "adbc038bbb5073e6846666936624b4c9c8ace28250c71d793c3e71d7e1801ef7"
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
