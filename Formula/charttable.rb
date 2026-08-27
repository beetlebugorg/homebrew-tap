class Charttable < Formula
  desc "Native map renderer for the MapLibre style spec"
  homepage "https://github.com/beetlebugorg/charttable"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.0/charttable-0.2.0-aarch64-macos.tar.gz"
      sha256 "f24a8daed6c7a69d95e919a7e2eff613b706e9a5683e1c71d62e708d78b7763f"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.0/charttable-0.2.0-x86_64-macos.tar.gz"
      sha256 "1547a6219566a752b1331eb50272f750b5056e5a8ec3eaadc88cdff27586442e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.0/charttable-0.2.0-aarch64-linux-gnu.tar.gz"
      sha256 "df87d199d86f03b55de158ec3f4378238aaeac19ee131ee3060cbef6090794a7"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.0/charttable-0.2.0-x86_64-linux-gnu.tar.gz"
      sha256 "fa6e37096536aafefad91e32889cd447e17f0db08fb55653d0d331236d797755"
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
