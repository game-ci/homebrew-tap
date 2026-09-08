class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.52/game-ci-macos-arm64.tar.gz"
      sha256 "cc9b48d970bd261bc34141624b6438e8101052bb576904a2ddae24292f52a05a"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.52/game-ci-macos-x64.tar.gz"
      sha256 "db3f9ad8c337325fc3f859fa88bd09a42d595dd865a7886a56741d8c84476216"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.52/game-ci-linux-arm64.tar.gz"
      sha256 "e7a2d0630b182f9894d9e8cf16a7f50442b38fd6de2c9fbfeab9922b8e68790d"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.52/game-ci-linux-x64.tar.gz"
      sha256 "7930e095e2610592c570c97ff4f778007bd150ace19393b10b375c4935629c15"
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
