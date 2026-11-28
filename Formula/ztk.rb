# The ztk formula. packaging/homebrew/tap.sh in the ztk repository
# writes this file for each release.
class Ztk < Formula
  desc "GUI toolkit AI can see: Tk rebuilt in Zig"
  homepage "https://beetlebug.org/ztk/"
  version "1.0.0-beta.2"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.2/ztk-1.0.0-beta.2-aarch64-macos.tar.gz"
      sha256 "7adea1c46747f8af4c14509ac66b7fd555ccc3a4e75b100dd08721fabc3c73e6"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.2/ztk-1.0.0-beta.2-x86_64-macos.tar.gz"
      sha256 "4b3e4ac01f5dacde250071c9050f2c4e53afd23f1c3f32732c3ec33b95753c72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.2/ztk-1.0.0-beta.2-aarch64-linux-musl.tar.gz"
      sha256 "a97b4f23cf71099c858df8b766a08b004b9c6e13a8205dae47d17a340bed570f"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztk/releases/download/v1.0.0-beta.2/ztk-1.0.0-beta.2-x86_64-linux-musl.tar.gz"
      sha256 "04b0aca442bc8b1164fede3480845447adf1fcaa8be3795a8730c646912323c2"
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
