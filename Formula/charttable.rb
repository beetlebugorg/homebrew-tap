class Charttable < Formula
  desc "Native map renderer for the MapLibre style spec"
  homepage "https://github.com/beetlebugorg/charttable"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.3.0/charttable-0.3.0-aarch64-macos.tar.gz"
      sha256 "9144747d2a2321c720cd532fbe04ed86b75fd2ebf2a563dd745b88b39e29bf16"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.3.0/charttable-0.3.0-x86_64-macos.tar.gz"
      sha256 "40c6c670d48cb3e911bb808ea849529b13006d2ca82cd7209ed127051d370a31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.3.0/charttable-0.3.0-aarch64-linux-gnu.tar.gz"
      sha256 "2974d6b502ebb6495be952a87bf901a3777b01aa8939316102e31a3fc99a1dbf"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.3.0/charttable-0.3.0-x86_64-linux-gnu.tar.gz"
      sha256 "82f0e5dc6b7d35bad1f6ce29295b456748616827d7092d452cf8eae232a35a9e"
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
