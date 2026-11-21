# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.6/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "9bfd99368b6b58e7a0b8702ab33d4df4d6661c9611a3ef9184a97c52c56a5179"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.6/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "b98e8a5cbb2dafb44208d71b9e808b24abeaebbd732c58cef193d2e9922503b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.6/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c210dad84933c6e46dcf2bdbe0d3edd47111dad0db5e6adc26a91fffd7f6746e"
    end
  end

  # The unified `beagle` command (formula `beagle`) installs a `beagle` too
  # and replaces this CLI as `beagle rca …`.
  conflicts_with "beagle", because: "both install a `beagle` binary"

  def install
    bin.install "beagle", "beagle-agentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
  end
end
