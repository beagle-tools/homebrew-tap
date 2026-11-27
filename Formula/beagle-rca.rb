# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.38.1"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle rca …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula: " \
                      "brew uninstall beagle-rca && brew install beagle-tools/tap/beagle"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.38.1/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "0ff7ce100cb3d10487b6e712870ebdab1c4d755ea78beb29577af1b736fe7129"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.38.1/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "70240a8c7101a6f2a5036b59a4d2df58e7589eafeadb1338fa9522c501cc8505"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.38.1/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "63339e87a9d568be95be7fb3d5840e22a44eb2e3700ca5dab5259b3fccf46705"
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
