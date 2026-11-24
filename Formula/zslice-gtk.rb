# The Linux app of zslice (GTK 4), built from the source of a release.
# packaging/homebrew/tap.sh in the zslice repository writes this file for
# each release. The Mac app is the cask zslice.
class ZsliceGtk < Formula
  desc "Slicer for FDM 3D printers (GTK 4 app for Linux)"
  homepage "https://zslice.beetlebug.org/"
  url "https://github.com/beetlebugorg/zslice/archive/refs/tags/v0.6.2-beta.tar.gz"
  sha256 "fd8ec6b648e30f646f91ef08d389b6cac5cd6844e59b92d37f832b179bd56596"
  license "AGPL-3.0-or-later"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "zig@0.16" => :build
  depends_on "glib"
  depends_on "gtk4"
  depends_on "json-glib"
  depends_on "libsoup"
  depends_on :linux
  depends_on "wayland"

  def install
    # The meson build runs linux/build-core.sh, which runs zig build.
    ENV.prepend_path "PATH", formula_opt_bin("zig@0.16")
    ENV["ZIG_GLOBAL_CACHE_DIR"] = buildpath/".zig-global-cache"
    ENV["ZIG_LOCAL_CACHE_DIR"] = buildpath/".zig-cache"
    system "meson", "setup", "build", "linux", "-Dcore-optimize=ReleaseFast", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    assert_path_exists bin/"zslice-gtk"
    assert_path_exists share/"zslice/beds"
    assert_path_exists share/"applications/org.beetlebug.Zslice.desktop"
  end
end
