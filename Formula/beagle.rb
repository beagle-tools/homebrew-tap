# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.7.0/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "00ed9fcb05354f5082ad1c5c24ac6c223af52c4fef40c34928b824a3ee8a7c70"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.7.0/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "7e9e24888b065e09e96673def9522558a5ead078dc4a31d6e67e62e03704bb44"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.7.0/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0de97b0cafcdb9e2aca8b202269ec59eac30af0bfcf497ac3b9f31effd609ef4"
    end
  end

  # The standalone rca CLI installs its own `beagle`; this one replaces it
  # (`beagle rca …`). Switch with `brew uninstall beagle-rca`.
  conflicts_with "beagle-rca", because: "both install a `beagle` binary"

  def install
    # beagle-agentd is deprecated (`beagle rca agentd run` replaces it); it
    # stays one release so services installed before the switch keep working.
    bin.install "beagle", "beagle-agentd"
  end

  def caveats
    <<~EOS
      Run `beagle setup` once: it installs every tool's agent skills, scout's
      session hooks and its store (each step asks first; `--yes` runs all).
      Every tool is a subcommand: `beagle help` lists them (`beagle rca`,
      `beagle scout`, `beagle tandem`, `beagle agent`, …). `brew upgrade
      beagle` updates them all; `beagle doctor` checks the setup (gh, agent
      services, tmux, skills, hooks) and finds old standalone binaries to
      remove.

      The agent daemons are `beagle` too. If you installed their services
      before, re-run these once so they stop using the old binaries
      (`agentd`, `beagle-agentd`), which go away in the next release:
        beagle agent daemon install   # agentd → beagle agent daemon run
        beagle rca agent install      # beagle-agentd → beagle rca agentd run
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
    assert_match "rca", shell_output("#{bin}/beagle help")
  end
end
