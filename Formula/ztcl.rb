# The ztcl formula. packaging/homebrew/tap.sh in the ztcl repository
# writes this file for each release.
class Ztcl < Formula
  desc "Experimental sandboxed Tcl interpreter written in Zig"
  homepage "https://github.com/beetlebugorg/ztcl"
  version "1.0.0-beta.3"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.3/ztcl-1.0.0-beta.3-aarch64-macos.tar.gz"
      sha256 "c3f50a2d6ee9c6fb2802ee88cdf7ea8f7b6ee5cce1329a2a10be98f32663c593"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.3/ztcl-1.0.0-beta.3-x86_64-macos.tar.gz"
      sha256 "e1716d5a8a4e221d0c82f7b2f69def4fa701f7ccb81b27f067fceb1f5006abb4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.3/ztcl-1.0.0-beta.3-aarch64-linux-musl.tar.gz"
      sha256 "24860089795e6c0521b252de6c679ffbebb78721c83f5f9cd77cdf4886d156ee"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.3/ztcl-1.0.0-beta.3-x86_64-linux-musl.tar.gz"
      sha256 "c545f2da8727016b6abcc8dffafaa496f16a3c3f1e7e33771e0849215a0e486d"
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
