# The ztk formula. packaging/homebrew/tap.sh in the ztk repository
# writes this file for each release.
class Ztk < Formula
  desc "GUI toolkit AI can see: Tk rebuilt in Zig"
  homepage "https://beetlebug.org/ztk/"
  version "1.0.0-beta.3"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.3/ztk-1.0.0-beta.3-aarch64-macos.tar.gz"
      sha256 "79c75be60228f9ad659fd56bd804cc3452dccbdcf7b00673c06ddea1badb252a"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.3/ztk-1.0.0-beta.3-x86_64-macos.tar.gz"
      sha256 "e18ed9e667b1650a8ad34379aacf53028d3dff4a54a44e091f52ac9f1111f843"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.3/ztk-1.0.0-beta.3-aarch64-linux-musl.tar.gz"
      sha256 "3e735e04fa6ab32fa54969cede9303a5bfb09d4717de6b828d326988c64fa5ce"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.3/ztk-1.0.0-beta.3-x86_64-linux-musl.tar.gz"
      sha256 "99c6a53be7ceb339b9e913e5107ca9703d3be27847de18f42e5266a1bd10413e"
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
