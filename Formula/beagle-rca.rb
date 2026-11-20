# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "933d062581522dc7c75755c0c0b75a320226e33f19a3347f83b8e3d0fd6a2766"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "225125601e8577fae3a8577510d4a5a01a6f42ae4553d1f34f33c81ea904faed"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2c408ce47a34a5b1b4cbd4628376427daa593a7c9c700a4b4e063a5a7151ae77"
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
