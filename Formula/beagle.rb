# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.1.0/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "2eab3612f290f3366537d03be26f8b623b3b949dcb576d7a415161503beec507"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.1.0/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "816389d25466ef9a9bd5401f263e06e78db5d1f3ab13cc35b01d563623e63776"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.1.0/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cdd69030a1b56a0b68c01d79780665dd0c614c46876cac4c91577429949ddd1f"
    end
  end

  # The standalone rca CLI installs its own `beagle`; this one replaces it
  # (`beagle rca …`). Switch with `brew uninstall beagle-rca`.
  conflicts_with "beagle-rca", because: "both install a `beagle` binary"

  def install
    bin.install "beagle"
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
