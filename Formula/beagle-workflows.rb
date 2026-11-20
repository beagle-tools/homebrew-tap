# Homebrew formula for the Beagle Workflows CLIs (agentd, agentctl,
# agenttop). TEMPLATE: release CI (scripts/release/homebrew.sh) fills the
# @…@ placeholders with the release version and each tarball's sha256, and
# pushes the result to beagle-tools/homebrew-tap as
# Formula/beagle-workflows.rb. Edit this file, never the tap copy.
class BeagleWorkflows < Formula
  desc "Local agent scheduler: agentd daemon, agentctl CLI and agenttop TUI"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/workflows"
  version "0.3.3"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.3.3/beagle-workflows-aarch64-apple-darwin.tar.gz"
    sha256 "84774f38b399d22931bcd1b50db55b3d56a7b323ba11805e2bc6d9ef187d6acf"
  end
  on_intel do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.3.3/beagle-workflows-x86_64-apple-darwin.tar.gz"
    sha256 "1c2b2280b04d2c171ccc801ff393d7d3565a25b6832244b4eca6f1dd2a328ec9"
  end

  def install
    bin.install "agentd", "agentctl", "agenttop"
  end

  # agentd runs as a per-user launchd agent (label com.agentd.daemon).
  # `agentctl daemon install` renders the embedded plist pointing at
  # HOMEBREW_PREFIX/bin, so the unit survives upgrades. A running daemon
  # keeps the OLD binary after an upgrade, so restarting is part of every
  # upgrade.
  def caveats
    <<~EOS
      agentd is a daemon. To run it at login under launchd:

        agentctl daemon install

      After every `brew upgrade beagle-workflows`, restart the daemon so it
      runs the new binary:

        agentctl daemon restart

      Logs: ~/Library/Logs/agentd/agentd.{out,err}.log
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentctl --version")
  end
end
