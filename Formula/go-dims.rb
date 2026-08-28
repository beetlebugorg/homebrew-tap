class GoDims < Formula
  desc "On-the-fly image resizing server, with a command to sign image URLs"
  homepage "https://github.com/beetlebugorg/go-dims"
  version "1.0.0-rc2"
  license "MIT"

  on_macos do
    # The macOS build links Homebrew's libvips. The Linux build is static and
    # needs nothing at run time.
    depends_on "vips"

    on_arm do
      url "https://github.com/beetlebugorg/go-dims/releases/download/v1.0.0-rc2/dims-macos-arm64.zip"
      sha256 "fac6cdcd5d8c1078b5d7ac501e6c2d5f5ec2b09c7f9245266985cfb406e5a48b"
    end
    on_intel do
      url "https://github.com/beetlebugorg/go-dims/releases/download/v1.0.0-rc2/dims-macos-amd64.zip"
      sha256 "806b901ec1b2a930dd1b4ad63699edab6bac4fc0fa1ce15b66eb574a393ec590"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/beetlebugorg/go-dims/releases/download/v1.0.0-rc2/dims-linux-arm64.zip"
      sha256 "984a483d7d2ac7bb511c167970f6916f09f95707bb5cc69fffc778b294cc2927"
    end
    on_intel do
      url "https://github.com/beetlebugorg/go-dims/releases/download/v1.0.0-rc2/dims-linux-amd64.zip"
      sha256 "6c7ddc519ae04bb5f96749f9350571c13ba15d4990162cafc18962e1678e5b5d"
    end
  end

  def install
    bin.install "dims"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dims version")
  end
end
