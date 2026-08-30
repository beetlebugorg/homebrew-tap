class Charttable < Formula
  desc "Native map renderer for the MapLibre style spec"
  homepage "https://github.com/beetlebugorg/charttable"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.1/charttable-0.2.1-aarch64-macos.tar.gz"
      sha256 "c6433e00455652cf7393ce881989af585e7869f4b2f1c8bc7508492b5331863f"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.1/charttable-0.2.1-x86_64-macos.tar.gz"
      sha256 "5eb6aaccab549a3940d5676f540c96aad6e9a88924ab26688639abed7fc3e6ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.1/charttable-0.2.1-aarch64-linux-gnu.tar.gz"
      sha256 "6211d4787bfb62fdc300463610f26c1c3b20f9c404cbc92a262f6d33c56259ca"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.2.1/charttable-0.2.1-x86_64-linux-gnu.tar.gz"
      sha256 "8ac2781ccdfaf0b0ed54ef1815a4ef92f472ef7daa45d7c43017f6c28aad0d74"
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
