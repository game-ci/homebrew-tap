class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.74"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.74/game-ci-macos-arm64.tar.gz"
      sha256 "3809a5ca6b9f0452c0edffa10fa3e10621cf1e1cbe539dbd6a1a7c933c97d5bb"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.74/game-ci-macos-x64.tar.gz"
      sha256 "b70b58c38fb7368196e4420653f81a60951164e542fd928b9066800e0971aa4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.74/game-ci-linux-arm64.tar.gz"
      sha256 "97893a6bbdf7b3503dfeb534cf7e695fd88a659409f9b0595827e3599a5fc3d6"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.74/game-ci-linux-x64.tar.gz"
      sha256 "d543b09e212163dc98651978c93399a913c8764264f566fba45d114ab1c7e7b0"
    end
  end

  def install
    # The binary is not self-contained: it resolves its own static assets
    # (default-build-script/, platforms/*, unity-config/) from a dist/
    # directory that must sit next to it on disk, and those are mounted into
    # Docker containers as real paths (see game-ci/cli#73). Keep the whole
    # extracted tree together in libexec and expose the binary via a wrapper
    # rather than symlinking it out of its directory.
    libexec.install "game-ci", "dist"
    (bin/"game-ci").write_env_script libexec/"game-ci", {}
  end

  test do
    assert_match "game-ci", shell_output("#{bin}/game-ci --help")
  end
end
