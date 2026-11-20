# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.32.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.2/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "2e394478c7df5e459f0adb60ff6e61b790aa834765b690078e78b298f7fdf7e6"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.2/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "5dd9474f9ed7465f2a0c6a25b818f271830e004dfa4c18678ef18d9bcdb98fe9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.32.2/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c9221bd9b1c59beeb61351ac06fe235914be050e07530409908decfe4030aaf1"
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
