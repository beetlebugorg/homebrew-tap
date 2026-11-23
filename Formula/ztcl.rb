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
      sha256 "5b8c194d29d7656f89afbd7b15da23b222856c4fac01d527ebdfc21a453f2aca"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-x86_64-macos.tar.gz"
      sha256 "4059e7af0faabef93ef43941d06a5f38c435b0fc2aa5e08fdafc625576b98541"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-aarch64-linux-musl.tar.gz"
      sha256 "fb043878c4d1c887594454e1478c0a29616d6a667d6de1932b2478d64b0678f4"
    end
    on_intel do
      url "https://github.com/beetlebugorg/ztcl/releases/download/v0.1.0-alpha/ztcl-0.1.0-alpha-x86_64-linux-musl.tar.gz"
      sha256 "b755744e8b5000b209c2ffb8954d7d8a64a3316387514c9625200982df6bb0ef"
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
