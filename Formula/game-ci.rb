class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.66"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.66/game-ci-macos-arm64.tar.gz"
      sha256 "3a1b4c077b5d8d727fe9d2948e9bd5f8649a2eb76913e8ddd31a9e9de5f6cb6b"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.66/game-ci-macos-x64.tar.gz"
      sha256 "f7e0ab4f476f14ff4f1b5b3fc649bc3035c0925ac704b6eb9e837a81c058107a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.66/game-ci-linux-arm64.tar.gz"
      sha256 "a8eedff82d2eb6b4a257cb1e88293cecfea0e0cb5c8c49898c73815b920e996b"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.66/game-ci-linux-x64.tar.gz"
      sha256 "82e3346fabc49c671cdd5fb7c7537e371f3657f48fd8f079e4342026908aaf45"
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
