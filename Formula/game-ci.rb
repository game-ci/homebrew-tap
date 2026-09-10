class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.58"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.58/game-ci-macos-arm64.tar.gz"
      sha256 "a644cd849c3bdc81426e62ec59ec622a157d1a088a350c0c40dbafaf9b4bcc8f"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.58/game-ci-macos-x64.tar.gz"
      sha256 "554891dfd004b26773e1cbfa96cb049fa059c1e9b0c25e43f44f759101f6b2a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.58/game-ci-linux-arm64.tar.gz"
      sha256 "22f7d8e63701c08da2b6d3f7d739d6bca3f71e7b4f765fb03daad6db1b8067de"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.58/game-ci-linux-x64.tar.gz"
      sha256 "b392111a60d879eb4ce93e469f597485bec7f1ab539c4dda6f8d8a20784d3054"
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
