# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.32.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.1/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "518a77711b6427a0c8c35fd9059be611270f0143a33e6adeb7a3b77325036600"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.1/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "d93e4848c7d0bce39c6be0228444f9a0f788ee74992e5340816fc4505b9ee888"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.1/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "36d6cdc2f67c33c897f43fe9db1f0e4372c10dba47eb18358b7af7cc31a8995b"
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
