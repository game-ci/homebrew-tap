class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.73"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.73/game-ci-macos-arm64.tar.gz"
      sha256 "20b7b370126b44287a16fb99d70a1bb55933bc3158216ec6f8ff8d9abd6141ab"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.73/game-ci-macos-x64.tar.gz"
      sha256 "4699dc52c0cefb128dc3712f8ae97c543642aeb677b50b94f20b5df81742831f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.73/game-ci-linux-arm64.tar.gz"
      sha256 "2328668c280b30eaf67fe3c63b275106d48c2f96182efa22233e0695ba867efb"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.73/game-ci-linux-x64.tar.gz"
      sha256 "3d4cc79952121ea46173d4d1eb8f2b6c6bcc866191489ec754e1511ab90d2fcd"
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
