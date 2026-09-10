class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.60"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.60/game-ci-macos-arm64.tar.gz"
      sha256 "99976bb2d8de9e561eda9c9b4d4c73c0fd421d1923b8b6cf9fffad147e95bc17"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.60/game-ci-macos-x64.tar.gz"
      sha256 "75e878fddc3c45822bbd4eede64cc032a29d436040d442193af9a2773097ab9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.60/game-ci-linux-arm64.tar.gz"
      sha256 "9a955feab8b699372a1bc24b2efba57ef1963c20f0e375d51e1ee04372081fb4"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.60/game-ci-linux-x64.tar.gz"
      sha256 "a9b6a9000ba5cda71346061fee385c093a3495365b81924cdfab03826aa46054"
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
