class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.70"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.70/game-ci-macos-arm64.tar.gz"
      sha256 "b0e71a2a2de576d7bc9729be653a48d59c3dcbd2f5710b36c45545bdf7e0bdc3"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.70/game-ci-macos-x64.tar.gz"
      sha256 "622ecd27c4d1535fe43a4b3744daaef2c69dea65e1ef5f161d63e83e3686b1ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.70/game-ci-linux-arm64.tar.gz"
      sha256 "487c94a0703b384f1e35dce8385b6bb85b0db1c7c15816d20a68aa043ae2ac6d"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.70/game-ci-linux-x64.tar.gz"
      sha256 "5121f1686010983191e9678ec0e9a0a9f9adb90bf9b180869ccd3cbc820fcc79"
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
