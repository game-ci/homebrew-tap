class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.55"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.55/game-ci-macos-arm64.tar.gz"
      sha256 "79e1abe166c0a3799f88ea97e22268c744121b060b8f1109c982fd512af4f049"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.55/game-ci-macos-x64.tar.gz"
      sha256 "e367406e8a3d01ecdc7f9f22c760fa3b1b872231a2c4e860baad4b85708e80be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.55/game-ci-linux-arm64.tar.gz"
      sha256 "7b8b0ea0a92293449158b5288f1ba15cdb71eb906d1d08cd9b323fa8af16b82c"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.55/game-ci-linux-x64.tar.gz"
      sha256 "2cb1c12c6d1eb268acc890de24f8a90ef930e95f01b55f838253975837c3ae74"
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
