# The zslice command line tool. packaging/homebrew/tap.sh in the zslice
# repository writes this file for each release.
class Zslice < Formula
  desc "Slicer for FDM 3D printers (command-line tool)"
  homepage "https://zslice.beetlebug.org/"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.1-beta/zslice-0.6.1-beta-aarch64-macos.tar.gz"
      sha256 "9ab8fa037ff17e797187cfb59343acd95888930d65861f584a89cb19b53310bf"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.1-beta/zslice-0.6.1-beta-x86_64-macos.tar.gz"
      sha256 "f32d4700bd092e5e2a21c997cdf3955fa8217a0982ed1f8608a2bb2e1a7e9d34"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.1-beta/zslice-0.6.1-beta-aarch64-linux-musl.tar.gz"
      sha256 "a2d87e2eb495f8b73beca6bac4cbf7f37142feb4581c38a55a8bc3fe220eae21"
    end
    on_intel do
      url "https://github.com/beetlebugorg/zslice/releases/download/v0.6.1-beta/zslice-0.6.1-beta-x86_64-linux-musl.tar.gz"
      sha256 "2b1596f9ae19c7ef63c2348b69200414bc65ddb88c26dca7247668ab71f34ba4"
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
