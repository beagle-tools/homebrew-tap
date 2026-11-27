# Homebrew formula for the Beagle Workflows CLIs (agentd, agentctl,
# agenttop). TEMPLATE: release CI (scripts/release/homebrew.sh) fills the
# @…@ placeholders with the release version and each tarball's sha256, and
# pushes the result to beagle-tools/homebrew-tap as
# Formula/beagle-workflows.rb. Edit this file, never the tap copy.
class BeagleWorkflows < Formula
  desc "Local agent scheduler: agentd daemon, agentctl CLI and agenttop TUI"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/agent"
  version "0.9.0"
  license "Apache-2.0"

  # Replaced by the unified `beagle` formula (`beagle agent …`). Deleted one
  # release after this deprecation shipped.
  deprecate! date: "2026-11-20",
             because: "is replaced by the beagle formula (`beagle agent`): " \
                      "brew uninstall beagle-workflows && brew install beagle-tools/tap/beagle"

  depends_on :macos

  on_arm do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.9.0/beagle-workflows-aarch64-apple-darwin.tar.gz"
    sha256 "56ce4e01c39d7c8cf2bb27b3b11ade317be483f0e9544c1f953ad7f2d4a4160d"
  end
  on_intel do
    url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-workflows-v0.9.0/beagle-workflows-x86_64-apple-darwin.tar.gz"
    sha256 "a635888f5c3540a818317186dccdedd0ea5460eee7b44aa9d19437f80cd870c9"
  end

  def install
    bin.install "agentd", "agentctl", "agenttop"
  end

  # agentd runs as a per-user launchd agent (label com.agentd.daemon).
  # This formula is deprecated: the caveats point at its replacement.
  def caveats
    <<~EOS
      beagle-workflows is deprecated: `beagle agent` in the beagle formula
      replaces agentctl, agenttop and agentd. Switch with:

        brew uninstall beagle-workflows
        brew install beagle-tools/tap/beagle
        beagle agent daemon install   # repoints launchd at `beagle agent daemon run`

      Until then, restart the daemon after every upgrade so it runs the new
      binary: agentctl daemon restart
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentctl --version")
  end
end
