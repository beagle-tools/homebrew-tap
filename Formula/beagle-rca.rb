# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.31.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.1/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "782bd6832532034241fae59e53603c9fc98c5ac5013ce6825b57c92e73e22889"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.1/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "27afc6d2d1e133f56fd25b47fe4f25137f7cdd7068d04de3e50129446bd19f50"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.1/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "dddaa2745f101fc6b482cd47403ea4db4941e61021f42d0f32f5dcac150b1c89"
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
