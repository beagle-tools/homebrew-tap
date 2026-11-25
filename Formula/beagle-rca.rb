# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.37.0"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle rca …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula: " \
                      "brew uninstall beagle-rca && brew install beagle-tools/tap/beagle"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.37.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "a7e474767213f19775780a8ca15399b86710dd4fa92897b55e005a537553416d"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.37.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "42d6eaf6817576d4b7298ba28452965dea8a68fde96f95a6649f593f56ff6166"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.37.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2b72da3aca1ecd7367dd10a6447d17587426a5db0da8734b09d6e2e60bc37921"
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
