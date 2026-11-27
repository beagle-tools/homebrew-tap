# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.39.0"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle rca …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula: " \
                      "brew uninstall beagle-rca && brew install beagle-tools/tap/beagle"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.39.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "898800a0d837d7eedfcd39e2bcd370bceb58d691917d0d34b8daf301b99cae18"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.39.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "4e08359982d638d114a6320412a95d4bb1f5d4728356e2163d3d4e118fedaba5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.39.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "01bcbc3bf1ca188620399059907a775806876f1bc40fdd52c778a897f94832d9"
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
