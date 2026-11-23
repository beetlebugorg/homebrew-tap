# The ztcl formula. packaging/homebrew/tap.sh in the ztcl repository
# writes this file for each release.
class Ztcl < Formula
  desc "Experimental sandboxed Tcl interpreter written in Zig"
  homepage "https://github.com/beetlebugorg/ztcl"
  version "0.1.0-alpha"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-aarch64-macos.tar.gz"
      sha256 "2d4adc858e5b03ddb785ee61d79720299c0d7dcc66b2b2bdc3e2fc9224b1e31f"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-x86_64-macos.tar.gz"
      sha256 "3f9fcb6e6bc6a7befcdbd17845ffd9c5077353e0b9da8af81ecee1a38cef1c4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-aarch64-linux-musl.tar.gz"
      sha256 "0f60ee1fb033249525a1c7ef3630ddec02e6423a8f19312122d22a0b560e3fb2"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-x86_64-linux-musl.tar.gz"
      sha256 "f7398e44867400ce3f9ffa5cc28ed7bf41f9fc23e49e81cecb88d6a3b89efee9"
    end
  end

  def install
    bin.install "ztcl"
  end

  test do
    (testpath/"t.tcl").write "puts [expr {6 * 7}]\n"
    assert_equal "42", shell_output("#{bin}/ztcl #{testpath}/t.tcl").strip
  end
end
