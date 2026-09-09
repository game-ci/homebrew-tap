class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.54"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.54/game-ci-macos-arm64.tar.gz"
      sha256 "31bb5905f506773a75e561d153fd8321d0af72577ca2a40403b75b875a313660"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.54/game-ci-macos-x64.tar.gz"
      sha256 "95841477553bd102fa66940a0efc998295868328d97264df8858c517e069e128"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.54/game-ci-linux-arm64.tar.gz"
      sha256 "db64b64b2d2e89d162a0e5a6b9ec191ddb6f2f0feb608da85852aab15d3d5077"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.54/game-ci-linux-x64.tar.gz"
      sha256 "706e18bb8b4c59a37ca9080dfb5919ed263c319be39a0a67e6044d0a7503e12e"
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
