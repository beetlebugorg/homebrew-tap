class Charttable < Formula
  desc "Native map renderer for the MapLibre style spec"
  homepage "https://github.com/beetlebugorg/charttable"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.2/charttable-0.1.2-aarch64-macos.tar.gz"
      sha256 "a9df6e0232291663a7ed5bbc5bbef8f965218d73d077ffd21bd48dbb64e98858"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.2/charttable-0.1.2-x86_64-macos.tar.gz"
      sha256 "0520500659d4e919ed95e54fdc9eada32ddf0b63e546a37f47880a90e658f721"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.2/charttable-0.1.2-aarch64-linux-gnu.tar.gz"
      sha256 "d0a5c350f060bc692dad231515c47ff0816bff9e1b21f8b334b86dc448e257f4"
    end
    on_intel do
      url "https://github.com/beetlebugorg/charttable/releases/download/v0.1.2/charttable-0.1.2-x86_64-linux-gnu.tar.gz"
      sha256 "4e1122a62435135f5e47dcbab5e684100557761cc026ed862552cce7d3476bb7"
    end
  end

  def install
    include.install "include/charttable.h"
    # The archive, the shared library, and the two symlinks that carry the
    # soname.
    lib.install Dir["lib/*"]

    # Zig writes a bare file name as the dylib id, and dyld does not search the
    # Homebrew prefix. Name the installed path instead, so a program that links
    # -lcharttable finds the library at run time. Editing a Mach-O header
    # breaks the ad-hoc signature on Apple Silicon, so sign it again.
    return unless OS.mac?

    dylib = lib/"libcharttable.#{version}.dylib"
    system "install_name_tool", "-id", lib/"libcharttable.#{version.major}.dylib", dylib
    MachO.codesign!(dylib) if Hardware::CPU.arm?
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
