class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.68"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.68/game-ci-macos-arm64.tar.gz"
      sha256 "02d30841fd43bf7eaec6d73f33c60ea0dfb29a4f29ad42b635c4f5de3c68747a"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.68/game-ci-macos-x64.tar.gz"
      sha256 "b45b2db95b25bbd085d6a1023ffc7b40eb200dc9325707b6631961f5f4706cd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.68/game-ci-linux-arm64.tar.gz"
      sha256 "914549ae457b92a460ba87f13025c316c9359759314819bc3046252415517dd4"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.68/game-ci-linux-x64.tar.gz"
      sha256 "0a6781c23fd8d4d98dab150b2b31348c3684dfb0ba37ba1f4af2487bbf7f9cf2"
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
