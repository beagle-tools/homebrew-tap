# Homebrew formula for the Beagle Workflows CLIs (agentd, agentctl,
# agenttop). TEMPLATE: release CI (scripts/release/homebrew.sh) fills the
# @…@ placeholders with the release version and each tarball's sha256, and
# pushes the result to beagle-tools/homebrew-tap as
# Formula/beagle-workflows.rb. Edit this file, never the tap copy.
class BeagleWorkflows < Formula
  desc "Local agent scheduler: agentd daemon, agentctl CLI and agenttop TUI"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/workflows"
  version "0.4.0"
  license "Apache-2.0"

  depends_on :macos

  on_arm do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.4.0/beagle-workflows-aarch64-apple-darwin.tar.gz"
    sha256 "9d9f046b6484df630baed6a76a15942ac571a3b79e938508eeef184d8298ab3b"
  end
  on_intel do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.4.0/beagle-workflows-x86_64-apple-darwin.tar.gz"
    sha256 "bf338a73ba6137ea51d1af21caff182daaacccb367977f88f0b6d087e538f93e"
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
