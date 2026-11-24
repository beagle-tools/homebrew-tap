# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.34.2"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle rca …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula: " \
                      "brew uninstall beagle-rca && brew install beagle-tools/tap/beagle"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.2/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "0c8d47f2fdcd603dd4c5afca509ed51be61618d002f7d5f7ad1870f96c051867"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.2/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "25d2ae77f89da3231d54cfbffdc4a9a7e4bccbba98a7b54a78a4197695272a88"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.34.2/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "176a2e1e02801dbb70d76d077d06c50da95a62bda36792e41575b340b4326ad0"
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
