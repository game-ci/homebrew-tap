class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.71"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.71/game-ci-macos-arm64.tar.gz"
      sha256 "dfc14c75254b4e5208be698e10c0f5b073360610217fcecc7c7f713f434ee226"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.71/game-ci-macos-x64.tar.gz"
      sha256 "e76cfaa95f480f46c2930e21102238d8590a3f47c9a9d299750bbeb90f0b5215"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.71/game-ci-linux-arm64.tar.gz"
      sha256 "5101ecaca69f2fc0a09cdf1bb07c8a86bc04a0d34e85bae1da19ea08e267f3e6"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.71/game-ci-linux-x64.tar.gz"
      sha256 "c970b36e0591c81c2bc5840523ce284e8b23a52614650eb44d702e262f2598ae"
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
