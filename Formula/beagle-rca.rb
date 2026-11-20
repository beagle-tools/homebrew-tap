# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.2/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "82e1b3406250a554fdb40ec3da026d8cd6b7a8d84b88add0d9c6a469446760f8"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.2/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "59c813adca37e42087e200a99148a93550c9dfa584d81e2aa34e824a7cc72cf9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.2/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "73104f3e17edf2e32fb5001d2f1b9e45616abefecbe6631e131ec5892b52f571"
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
