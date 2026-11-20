# Homebrew formula for the Beagle Workflows CLIs (agentd, agentctl,
# agenttop). TEMPLATE: release CI (scripts/release/homebrew.sh) fills the
# @…@ placeholders with the release version and each tarball's sha256, and
# pushes the result to beagle-tools/homebrew-tap as
# Formula/beagle-workflows.rb. Edit this file, never the tap copy.
class BeagleWorkflows < Formula
  desc "Local agent scheduler: agentd daemon, agentctl CLI and agenttop TUI"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/workflows"
  version "0.3.5"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.3.5/beagle-workflows-aarch64-apple-darwin.tar.gz"
    sha256 "826391bb79791015a16a1c0845f0fea98893dc17effddb61f0ff2641fe3c8835"
  end
  on_intel do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.3.5/beagle-workflows-x86_64-apple-darwin.tar.gz"
    sha256 "4dbeb6f6c8e3a19712ae4a56e087495909e9c7867c91f9615b1586c3c23e8a8b"
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
