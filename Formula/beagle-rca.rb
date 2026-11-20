# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.3/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "6216938118a38cca1d4fb85ea8e54e6d700d31909b89b932594141d111df9657"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.3/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "426ba25e7a0a08d9ebdd3efbc7ed63038e666a5b2b53cf833fedf7be7b7c5095"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.3/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "986fc958edb260d5827c1c02d292ecdb72c5878578d1b656e399346eec42dec0"
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
