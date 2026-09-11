class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.63"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.63/game-ci-macos-arm64.tar.gz"
      sha256 "92b5861df50cae3791f529f29e420558683e7dfc113b5d3c3e136cea7eb58b40"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.63/game-ci-macos-x64.tar.gz"
      sha256 "319db008fc89e93a3f656c2c3b57e93b00e87847dc77f040ac99940c410f2a70"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.63/game-ci-linux-arm64.tar.gz"
      sha256 "034e501b40a63c032b3210d27be5132524438d2ac78cd4b4dc4f915779847728"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.63/game-ci-linux-x64.tar.gz"
      sha256 "a8fa5c09a6e8f3a3dd37322f0968ca957bf9d5600e86d877e8f37e3ffecbeba7"
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
