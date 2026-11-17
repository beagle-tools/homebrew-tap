# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.29.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.29.2/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "06305960061c4237805e1536f9b20f689c72509794f40e828a1ce0b0d999c149"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.29.2/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "f1440c5a03b522dc281aa0fe66ba594b3289175f4e53dfbb6a7a5b9526e53c31"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.29.2/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c0529384d4ce3f6f7b38df897e407588b74c5dfe7344bcf42034aadfb8aec7c7"
    end
  end

  def install
    bin.install "beagle", "beagle-agentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
  end
end
