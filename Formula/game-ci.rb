class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.61"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.61/game-ci-macos-arm64.tar.gz"
      sha256 "1dcb5d25e3a20d0df1a23864c8e42a70242037a1290dc002505c5a553af087e5"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.61/game-ci-macos-x64.tar.gz"
      sha256 "f85d6e15e3fee9a7bc5a8f5e3889b17390e978622bcd1d14ec13aa3e46b81e60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.61/game-ci-linux-arm64.tar.gz"
      sha256 "4312be2c9b3b3ac88057da10fe049c17f9c065ede080626e309ba18fab6e2898"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.61/game-ci-linux-x64.tar.gz"
      sha256 "6e40cdc618b5225794fd842151cb17cf205a0f518d1789bb6337bf28b8225e5c"
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
