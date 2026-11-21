# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.6.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.5/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "121a2ee46ad5625310e56a2fd1a85cfd8a5fb5125f148242a5d5ec2cbacd49a0"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.5/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "28bcc5866b395363e358e910af2fdeb37537ca40324e6b9e66c0daf0420e8dc9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.6.5/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2a3393957330c640ed3780583a870a51195e4aea6d1aafcb00268d84ca3a6ea5"
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
      Run `beagle setup` once: it installs every tool's agent skills, scout's
      session hooks and its store (each step asks first; `--yes` runs all).
      Every tool is a subcommand: `beagle help` lists them (`beagle rca`,
      `beagle scout`, `beagle tandem`, …). `brew upgrade beagle` updates
      them all; `beagle doctor` checks the setup (gh, beagle-agentd, tmux,
      skills, hooks) and finds old standalone binaries to remove.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
    assert_match "rca", shell_output("#{bin}/beagle help")
  end
end
