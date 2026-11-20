# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.1/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "70df3482a088a11506e4229c3f5db42fed20d176585f3a7ebcbdeed0d0c4bf43"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.1/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "a3f67fa122dbf2678c86bd01e6977194a53fda36e22a1fd638f8de7a98fd3d85"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.1/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e9bc55e478a95e4e6193cb4b31398f9e238bf3deac813b6c6518aebf9615b3e3"
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
