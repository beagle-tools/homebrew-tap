# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "ceb124e3a5b8915c191c2f4cae3ee217811a34c48760bf82e6fe8ef9f520499e"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "6e3b54387238cbf99c5a0bae89a58fff93b334de33652cffc928fc951be0f010"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9fbe1bee792a8b28a7db9d75bf51f843b8d7f313c3714b44aa06ba073b97dfbd"
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
