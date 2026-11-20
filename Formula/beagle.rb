# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.5.0/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "a2f77a06183155bb4c88cce57cdc562a16f3080706b185bc4bc3cd50d10b1306"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.5.0/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "08f23c7dbf5cd79eda15f3d191d33dfc6f21030cd338e808432c362c27daf64a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.5.0/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2d7140bb27162ed6f594692eec2ddb4daf79158dade62da4b4418d7dcb28090a"
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
