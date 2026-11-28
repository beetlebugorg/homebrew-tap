# The ztcl formula. packaging/homebrew/tap.sh in the ztcl repository
# writes this file for each release.
class Ztcl < Formula
  desc "Experimental sandboxed Tcl interpreter written in Zig"
  homepage "https://github.com/beetlebugorg/ztcl"
  version "1.0.0-beta.1"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.1/ztcl-1.0.0-beta.1-aarch64-macos.tar.gz"
      sha256 "7075ea9695d068d2125e9d826a36378e4256e5f978499360a6430f6107b5ea7b"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.1/ztcl-1.0.0-beta.1-x86_64-macos.tar.gz"
      sha256 "750f353632161bc06d12adf2f28b73a1455917ed3fed9efaa2da97acad61ef36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.1/ztcl-1.0.0-beta.1-aarch64-linux-musl.tar.gz"
      sha256 "8aacddbbc04d6e98ca98785ac33c41bd432abe25f55558427f6100db80306b8f"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.1/ztcl-1.0.0-beta.1-x86_64-linux-musl.tar.gz"
      sha256 "10d51669b5cebcacc737b983dce1b769991ecb55721f23d048802e5127a063d4"
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
