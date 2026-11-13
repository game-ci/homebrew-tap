class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.75"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.75/game-ci-macos-arm64.tar.gz"
      sha256 "e4e690d7e369b73a1422dc61c9007f802ee19b5b0cf4de46a003db1785aa3a65"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.75/game-ci-macos-x64.tar.gz"
      sha256 "99ec22214fa1ab96b59e9e7b74dca92db6c466cede4631238b7b79fe7cb872c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.75/game-ci-linux-arm64.tar.gz"
      sha256 "853225b9a0becf5b60d77c7c20392c6f333585001d4c4828625fed4babee6bf3"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.75/game-ci-linux-x64.tar.gz"
      sha256 "38f0c5ceaa2b3924bb84cd58455c9c314fc6d5107e50609f12adfd2034f5a315"
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
