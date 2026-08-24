class Charttable < Formula
  desc "Native map renderer for the MapLibre style spec"
  homepage "https://github.com/beetlebugorg/charttable"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.3/charttable-0.1.3-aarch64-macos.tar.gz"
      sha256 "fa1d9769c079c1eb13403f404a69e42f357aa788cf31f6e92f3a0154985e2974"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.3/charttable-0.1.3-x86_64-macos.tar.gz"
      sha256 "50828dd35474f96e359220cc80debd1af625dea9bb04a01144a9297c1692fbe4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.3/charttable-0.1.3-aarch64-linux-gnu.tar.gz"
      sha256 "ed27ad6b47a06943669de27a5587e03986aee23299d8955afb7403f5245006c0"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.3/charttable-0.1.3-x86_64-linux-gnu.tar.gz"
      sha256 "695fa230e19227b8572db1c4f796a0e98b5c8e1c38dadb9f54f1f16b25b683ab"
    end
  end

  def install
    include.install "include/charttable.h"
    # The archive, the shared library, and the two symlinks that carry the
    # soname.
    lib.install Dir["lib/*"]

    # Zig writes @rpath as the dylib id, which only resolves for a program that
    # sets an rpath. Name the installed path instead, so anything that links
    # -lcharttable finds the library at run time. The library is built with
    # -headerpad_max_install_names, which is what leaves room for a path this
    # long. Editing a Mach-O header breaks the ad-hoc signature on Apple
    # Silicon, so sign it again.
    return unless OS.mac?

    dylib = lib/"libcharttable.#{version}.dylib"
    system "install_name_tool", "-id", lib/"libcharttable.#{version.major}.dylib", dylib
    system "codesign", "--force", "--sign", "-", dylib if Hardware::CPU.arm?
  end

  test do
    (testpath/"abi.c").write <<~C
      #include <charttable.h>
      int main(void) { return charttable_abi_layout() == 0; }
    C

    # charttable_abi_layout reports the struct-layout guard. It touches no GPU,
    # so it runs anywhere.
    if OS.mac?
      system ENV.cc, "abi.c", "-I#{include}", "-L#{lib}", "-lcharttable", "-o", "abi"
      system "./abi"
    else
      # The library leaves the Vulkan loader to the program that links it, and
      # a test machine has none. Compile against the header instead.
      system ENV.cc, "-I#{include}", "-c", "abi.c", "-o", "abi.o"
    end
  end
end
