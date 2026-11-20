# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.31.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.2/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "1bb046f2433862d82d86b9d0f86a2aa2e783b1092a925c5cd31f531aae8442fc"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.2/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "b3c78235b6f0842b58bc64b1738713d9cd060630cd9ec1fcea2aa444b8a34b93"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.31.2/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fe15eeb26bc4b1945a91b5dbf02f0344a9d6ad5ffa370fffc155608053102251"
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
