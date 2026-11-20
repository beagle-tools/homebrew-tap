# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.3/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "ea63dc5ad0f46bb0a7fce3b2a3f086d9d87bf5738c5d9a062c754de5eb908c7d"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.3/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "e25d9568ef8f6e64ec07c1587367f9ca782d60dc90a7e35d0f5c458e17fcff11"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.3/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a97d55d9b817d47c334495318b00ee32a47ca2eb4c5f5b6f378b57c9a847f6f5"
    end
  end

  # The standalone rca CLI installs its own `beagle`; this one replaces it
  # (`beagle rca …`). Switch with `brew uninstall beagle-rca`.
  conflicts_with "beagle-rca", because: "both install a `beagle` binary"

  def install
    bin.install "beagle", "beagle-agentd"
  end

  def caveats
    <<~EOS
      Every tool is a subcommand: `beagle help` lists them (`beagle rca`,
      `beagle scout`, `beagle tandem`, …). `brew upgrade beagle` updates
      them all; `beagle doctor` finds old standalone binaries to remove.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
    assert_match "rca", shell_output("#{bin}/beagle help")
  end
end
