# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.2.0/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "0b817e0cd0d149f7bc159520b063a27cdcbc9b9410007b399e9cc609061b2660"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.2.0/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "fdb8dcb7f195e0723d86d5761f070326c98477e4d17aa98349f59f3ad6581c90"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.2.0/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5cc071994ccfc363f3fa695a52cf9486a692cb32999f245eb729d6fb0512db4d"
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
