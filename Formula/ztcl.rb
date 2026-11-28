# The ztcl formula. packaging/homebrew/tap.sh in the ztcl repository
# writes this file for each release.
class Ztcl < Formula
  desc "Experimental sandboxed Tcl interpreter written in Zig"
  homepage "https://github.com/beetlebugorg/ztcl"
  version "1.0.0-beta.2"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.2/ztcl-1.0.0-beta.2-aarch64-macos.tar.gz"
      sha256 "335e121f38821a5de0d18c36bb365416aed1fc08f81a8afa6bbf1c60c6b5f56b"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.2/ztcl-1.0.0-beta.2-x86_64-macos.tar.gz"
      sha256 "f9f74c8f44d12ad88aa75ec6bc68629408ad7567e8e34535ec14adf6eb1fbf21"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.2/ztcl-1.0.0-beta.2-aarch64-linux-musl.tar.gz"
      sha256 "627e162ec315853a56442ddd003ff85e75ca14e93821ea4c9b2685329b29598a"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v1.0.0-beta.2/ztcl-1.0.0-beta.2-x86_64-linux-musl.tar.gz"
      sha256 "d7cc97e4cbb95d70c5a260adb239546eadac77fbd9b171d86fa3132e7f80d8e5"
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
