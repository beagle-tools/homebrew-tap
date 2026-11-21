# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.34.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "ba7f7bfe43c04d3d4df2e6859a02b6316b36dc02583480086ae479814eb5d64b"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "a158e4645e447aef1221c85f9301c4b6d6fd60344436a419716cc70b5c7c3025"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a2b52cae137bd1a3de33df6dac35741220c3e91a2c305f77eebbc8f207786a58"
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
