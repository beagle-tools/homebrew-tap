# Homebrew formula for the Beagle RCA CLI. TEMPLATE: release CI
# (scripts/release/homebrew.sh) fills the @…@ placeholders with the release
# version and each tarball's sha256, and pushes the result to
# beagle-tools/homebrew-tap as Formula/beagle-rca.rb. Edit this file, never
# the tap copy — the next release overwrites it.
class BeagleRca < Formula
  desc "Root-cause analysis workspaces for incidents, in the terminal"
  homepage "https://github.com/beagle-tools/beagle-tools/tree/main/rca"
  version "0.33.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.5/beagle-rca-aarch64-apple-darwin.tar.gz"
      sha256 "d514c7b28ed45695cc52781d15a2d344a610927f95d9a27034dff4e6eba59461"
    end
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.5/beagle-rca-x86_64-apple-darwin.tar.gz"
      sha256 "4dcab65dc3eb5e52b7a9358b1cf8c4c06fbea2fa91d68932dd6ca89b720c8cc7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/beagle-tools/beagle-tools/releases/download/beagle-rca-v0.33.5/beagle-rca-x86_64-unknown-linux-musl.tar.gz"
      sha256 "112932da036e768ec5a6c1977c68d27a39850b0ebdd3a5877db6f81d0bf8f32e"
    end
  end

  # The unified `beagle` command (formula `beagle`) installs a `beagle` too
  # and replaces this CLI as `beagle rca …`.
  conflicts_with "beagle", because: "both install a `beagle` binary"

  def install
    bin.install "beagle", "beagle-agentd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/beagle --version")
  end
end
