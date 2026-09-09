class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.57"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.57/game-ci-macos-arm64.tar.gz"
      sha256 "7635657a607a258e80efe3ea9184fb65b286db9799581302693afc4ef0b80c3f"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.57/game-ci-macos-x64.tar.gz"
      sha256 "e24246661a9fd38530c4d4cf147b82368279dc5c08abbcad592e4e1defbf25e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.57/game-ci-linux-arm64.tar.gz"
      sha256 "daa8a1851d0ca3a72caa86e42a931ec374bd2986d91a40bf0fcb59a3485d44dd"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.57/game-ci-linux-x64.tar.gz"
      sha256 "de4ef8606eab4622c092c5768e3e9e7b19d24751456855a592647cccc27ad004"
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
