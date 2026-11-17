# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.30.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "245fb0e8089dc09269a4eb3f9ac32139fe6b507d809aee1a6f6a6ac9dcb1bf3c"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.30.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "5193a1c016ac4a90532df0cd05e8d66fae4cb505335c5e0f7f96c509537705c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.30.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4493565b443b705019165a013ac74dabf715c3f1b307f26b0013dfbaaf8305f1"
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
