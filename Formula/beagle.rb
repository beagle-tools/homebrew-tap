# Homebrew formula for the unified `beagle` command (beagle/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/beagle"
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.9.0/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "26a7ee4606d00f6a49d5640896df4d55490a2d1eb5eb4f535b5ce79823162d73"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.9.0/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "3d2dd25de63e778a0d52298ccda24d4ebebccdff9398e6d1157cce5dcf4d73fa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.9.0/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d07032692f77702a3742b2abfc4f283c6c535506c39a0c7b173651c1d0eeff61"
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
