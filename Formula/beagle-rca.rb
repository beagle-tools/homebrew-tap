# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "80e7eec9704d58c0a604a15b4d64cef815b9f7159ed0ba83fdaa81569c6f6cde"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "6483d2ed67fbfc34e08a8f79c82ec8afb7cc3a5c4699448313a2e5bde9895e2f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0d09e36a5898baaad765e327c9d18a701c4db9e325bb5b6646c4fbd350cbf87c"
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
