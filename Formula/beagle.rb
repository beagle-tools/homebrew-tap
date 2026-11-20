# Homebrew formula for the unified `beagle` command (cli/). TEMPLATE: release
# CI (scripts/release/homebrew.sh) fills the @…@ placeholders with the
# release version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle.rb. Edit this file, never the
# tap copy — the next release overwrites it.
class Beagle < Formula
  desc "Developer tools in one command: RCA workspaces, PR recaps, agent tracking, more"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/cli"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.3.1/beagle-cli-aarch64-apple-darwin.tar.gz"
      sha256 "e6ca41022021de7f7fa8aa9aeb8725f53bc60bba006a7178c27e84ba0ec53ce1"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.3.1/beagle-cli-x86_64-apple-darwin.tar.gz"
      sha256 "08383ec3e3f663c6883aaf1b54419b0f462be46f0206be0ebe7bc420f41a6a1a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-cli-v0.3.1/beagle-cli-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3dab086634dddf81b443268c93f4ece15634e27068ea81e15c0582878a0f0302"
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
