class Zinkywhat < Formula
  desc "Driver for the Pimoroni Inky wHAT e-paper display"
  homepage "https://github.com/beetlebugorg/zinkywhat"
  version "0.3.0"
  license "MIT"

  # This drives Raspberry Pi hardware through Linux device nodes, so there is
  # no macOS build and no x86 build — neither could do anything useful.
  depends_on :linux
  depends_on arch: :arm64

  url "https://github.com/beetlebugorg/zinkywhat/releases/download/v0.3.0/zinkywhat-0.3.0-aarch64-linux-gnu.tar.gz"
  sha256 "0069d57b8026b7e4d6f39ff083c2f15408a7d8fb18bec88f5231461f2f741c28"

  def install
    bin.install "bin/zinky"
  end

  def caveats
    <<~EOS
      zinky needs SPI and I2C enabled, and your user in the spi, gpio and i2c
      groups:

        sudo raspi-config nonint do_spi 0
        sudo raspi-config nonint do_i2c 0
        sudo usermod -aG spi,gpio,i2c "$USER"

      Then reboot and run: zinky probe
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zinky version 2>&1")
  end
end
