class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.59"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.59/game-ci-macos-arm64.tar.gz"
      sha256 "51475def735d7df3afd2c4eb16c0a28ab62389f2a5943239f9f966bd934ee0fe"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.59/game-ci-macos-x64.tar.gz"
      sha256 "1c6cb7f0e1568469d5862b8977ea65a6a1b3ffd344a3dc5f445b7bbb5cb651ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.59/game-ci-linux-arm64.tar.gz"
      sha256 "f6e0625e250064e12d14adcb6b848e0625e87eb7e9f51e9a07cf466a96a38564"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.59/game-ci-linux-x64.tar.gz"
      sha256 "d013fd874e5b415e7708cfe518aa457700fc830a95fe926267ff8bb7b485ae44"
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
