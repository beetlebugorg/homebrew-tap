# The ztcl formula. packaging/homebrew/tap.sh in the ztcl repository
# writes this file for each release.
class Ztcl < Formula
  desc "Experimental sandboxed Tcl interpreter written in Zig"
  homepage "https://github.com/beetlebugorg/ztcl"
  version "0.2.0-beta"
  license "BSD-2-Clause"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.2.0-beta/ztcl-0.2.0-beta-aarch64-macos.tar.gz"
      sha256 "c77d7e749d7aedffd0c206ea601e42824f8eb1f5a84c31049b86c8e09745826a"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.2.0-beta/ztcl-0.2.0-beta-x86_64-macos.tar.gz"
      sha256 "7c0d5e7efed3809cb03600e8b2b15bac252687323a382748b8cdbf52548c60a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.2.0-beta/ztcl-0.2.0-beta-aarch64-linux-musl.tar.gz"
      sha256 "3a80db6eb820d95bede4d4e3832a698bf6cd6639291e128b2c6de8462b4899e7"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.2.0-beta/ztcl-0.2.0-beta-x86_64-linux-musl.tar.gz"
      sha256 "d15c66886e2fb2deb1722210d90ebd0d6de163a04d32f07227da1bf1ff5760a5"
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
