class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.62"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.62/game-ci-macos-arm64.tar.gz"
      sha256 "12fbc69ad5df2290a0d8442803467950edb018cfe1b77c5cf76748861a3843d4"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.62/game-ci-macos-x64.tar.gz"
      sha256 "9811472681e74e569015c28d00f06ecc39c89eea9b19427be0879381c1139b1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.62/game-ci-linux-arm64.tar.gz"
      sha256 "a708521781323a7697cb9209630795d142874567905a6d1009db8cc3b1f8b049"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.62/game-ci-linux-x64.tar.gz"
      sha256 "30ea8af8b386aec5a5106de424697625d0333ad3fac566fcfffbd1ba44d9658e"
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
