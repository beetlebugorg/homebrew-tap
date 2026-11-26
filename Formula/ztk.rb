# The ztk formula. packaging/homebrew/tap.sh in the ztk repository
# writes this file for each release.
class Ztk < Formula
  desc "Experimental Tk replacement written in Zig"
  homepage "https://beetlebug.org/ztk/"
  version "0.2.0-beta"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v0.2.0-beta/ztk-0.2.0-beta-aarch64-macos.tar.gz"
      sha256 "0174e3bbc4aa1613d84d78d853091812016eb3ce6454dc0e07b3538f0d845840"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v0.2.0-beta/ztk-0.2.0-beta-x86_64-macos.tar.gz"
      sha256 "770915b9ba70a77c560ba5d25fe0b26f084223dcd385c5d6df87eafe86c85252"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v0.2.0-beta/ztk-0.2.0-beta-aarch64-linux-musl.tar.gz"
      sha256 "0d8bb974a724226266a560a40b8b93aee12c12d1f529a9a42312eca53df3de62"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v0.2.0-beta/ztk-0.2.0-beta-x86_64-linux-musl.tar.gz"
      sha256 "49e5f87c2f6741a458cdc38c5f1133dc75fafff22f0a59bf0b166e85e17d788f"
    end
  end

  def install
    bin.install "ztk"
  end

  test do
    (testpath/"t.tcl").write "puts [expr {6 * 7}]\n"
    assert_equal "42", shell_output("#{bin}/ztk #{testpath}/t.tcl").strip
  end
end
