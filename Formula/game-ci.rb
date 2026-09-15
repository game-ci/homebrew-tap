class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.65"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.65/game-ci-macos-arm64.tar.gz"
      sha256 "c1aa880a3387233a12fe683b8965fdadd8c40ba47344812a1ccfb45f60932d16"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.65/game-ci-macos-x64.tar.gz"
      sha256 "a65e5f79a8bab043edca6abc71e33847fc56ff66ce50e4a90184225e1cb1727c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.65/game-ci-linux-arm64.tar.gz"
      sha256 "e481d362b367cdfe1d98b1a450c4b4c3a9df1cefcc48afa3c9ca29d3b85fb0b8"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.65/game-ci-linux-x64.tar.gz"
      sha256 "97b6748da152dd173d46a7a54a0f89cefac92194042b56142b49db9a3860a042"
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
