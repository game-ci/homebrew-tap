class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.64"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.64/game-ci-macos-arm64.tar.gz"
      sha256 "d9d664c4bd0c86784f8a766e32a9dcddf4bf67371cb523931267906c517db347"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.64/game-ci-macos-x64.tar.gz"
      sha256 "69cb63226175db224e3d366a5a13c60b233d9c9072061d2d9b2c68daa34273be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.64/game-ci-linux-arm64.tar.gz"
      sha256 "eeb256386b9bc4e5c16bc128131732b4176f981ee7cda843dcae0d1ad057a035"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.64/game-ci-linux-x64.tar.gz"
      sha256 "2f815f1debced0422d12e7e2ef3391733f864e1535b4c7baee6fa374c3dd92a0"
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
