class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.72"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.72/game-ci-macos-arm64.tar.gz"
      sha256 "80708915e899ee1c0f167a8f6cb614535e88eb1703e3e105aeed9c15e7a4d0a6"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.72/game-ci-macos-x64.tar.gz"
      sha256 "449b9a7f2bd31a956c14f4bc41bdfb5d313c01314299ebc2de088f7a4cfd7c7a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.72/game-ci-linux-arm64.tar.gz"
      sha256 "878fc9facb55abb3efbb249f4f6c07658d2866e682d91e78cbbcc732041b9ecd"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.72/game-ci-linux-x64.tar.gz"
      sha256 "1de550a620ee92e05e920b6db7d431621440b60b2577f04b4a997dc92a58cb0a"
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
