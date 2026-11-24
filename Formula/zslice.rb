# The zslice command line tool. packaging/homebrew/tap.sh in the zslice
# repository writes this file for each release.
class Zslice < Formula
  desc "Slicer for FDM 3D printers (command-line tool)"
  homepage "https://zslice.beetlebug.org/"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.2-beta/zslice-0.6.2-beta-aarch64-macos.tar.gz"
      sha256 "91c09861ad7891cdc32f18f12996eb6ff199eb044c7e246df74f111ef2036276"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.2-beta/zslice-0.6.2-beta-x86_64-macos.tar.gz"
      sha256 "c075beba29cc57a29b0ba81261fd3266eaa68a18bfc230067842f84f861b4fa5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.2-beta/zslice-0.6.2-beta-aarch64-linux-musl.tar.gz"
      sha256 "bfc547d19103cd4e04986de958b39e6008b3b391990f8b0b81b854d240ffd637"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.2-beta/zslice-0.6.2-beta-x86_64-linux-musl.tar.gz"
      sha256 "0a8a46698321301b16bd0de2dd879e4e0f2472f1e54926d73fe83d4558d6ba93"
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
