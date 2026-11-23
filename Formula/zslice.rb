# The zslice command line tool. packaging/homebrew/tap.sh in the zslice
# repository writes this file for each release.
class Zslice < Formula
  desc "Slicer for FDM 3D printers (command-line tool)"
  homepage "https://zslice.beetlebug.org/"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.0-beta/zslice-0.6.0-beta-aarch64-macos.tar.gz"
      sha256 "ea96343c731905c3377bb0517c4d5e503e29145ab83ce82e21f966627f6e0130"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.0-beta/zslice-0.6.0-beta-x86_64-macos.tar.gz"
      sha256 "aa6e0b83630126370c7a9f96fc9a808721c003afd6046fbfaaf2c525495f7638"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.0-beta/zslice-0.6.0-beta-aarch64-linux-musl.tar.gz"
      sha256 "4e810e6f9331257c03051d6392757ea29fb4eb32f458f9f137c4202d6e52c5e1"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.0-beta/zslice-0.6.0-beta-x86_64-linux-musl.tar.gz"
      sha256 "54b56e235a0bbeba93fcaf1582e4dbdbbac84b6c3885d79a37b9190fc4eb7cda"
    end
  end

  def install
    bin.install "zslice"
  end

  test do
    system bin/"zslice", "demo", testpath/"demo.stl"
    system bin/"zslice", "slice", testpath/"demo.stl", "-o", testpath/"demo.gcode"
    assert_match ";LAYER:", (testpath/"demo.gcode").read
  end
end
