class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.53"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.53/game-ci-macos-arm64.tar.gz"
      sha256 "a22895c4f0bbf52b3e826dce709d4f3a94cc6c7a614ebc7608eeeb84ded8056f"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.53/game-ci-macos-x64.tar.gz"
      sha256 "9c37360e8b118d14acfa018044582bd9ff01b9f60472535b7cc36975f60ce9b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.53/game-ci-linux-arm64.tar.gz"
      sha256 "d48f90d6ae06d59856c7b4fe41020fb76ad1465cf7adccfdc9c411e4bf76eb7c"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.53/game-ci-linux-x64.tar.gz"
      sha256 "a6bd3025f91117b83b75d818b5b07c7ff3c1f832662ade4f94b78c14260ff3d1"
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
