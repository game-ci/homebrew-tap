class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.50"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.50/game-ci-macos-arm64.tar.gz"
      sha256 "ad4705c1963c57a53a4351179107abf872bb8b8e2697e0d99516a1dc33a24008"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.50/game-ci-macos-x64.tar.gz"
      sha256 "66982342fec7caf16f22925f813177462a5f9eb3807a347836151b43d36dcc57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.50/game-ci-linux-arm64.tar.gz"
      sha256 "10fb5f253f4fb9e5cf4be87f311f99181c1a7a90e40df9613b558c34bbffe036"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.50/game-ci-linux-x64.tar.gz"
      sha256 "8229b335ad2096c35659f399a8b2961c46df136fe715c6fc28fd04216311aa1a"
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
