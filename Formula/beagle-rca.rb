# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.36.0"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle rca …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula: " \
                      "brew uninstall beagle-rca && brew install beagle-tools/tap/beagle"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.36.0/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "e3f7d97796d6bf39b7ccea2f55a84d9778a08629fa9d17167ebd3264925f9780"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.36.0/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "35889055ef0df4e609e7d852a9585472638612857776b9a0d4c93dd5027760c7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.36.0/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "76a3d31ceeb90cfde987803441ba1423383394ddff8f17576a860a8e73a376e2"
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
