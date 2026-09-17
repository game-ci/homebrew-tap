class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.69"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.69/game-ci-macos-arm64.tar.gz"
      sha256 "afa8f39dadeff60ab5e7b07e371f85a7338943147b02e41735aa4d30011859c1"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.69/game-ci-macos-x64.tar.gz"
      sha256 "f3e7cd39670504801d5a4c72b2767bc9a6257bdb6564c320a36d2dfd1dc04f15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.69/game-ci-linux-arm64.tar.gz"
      sha256 "58b74ec6c7cc8f6da5cda471df8a118bd06047e458192e65693ebf790e7a5b10"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.69/game-ci-linux-x64.tar.gz"
      sha256 "78f39695ce2e0e6e26645e1b13c8b92223b40839a74b2d98952b867b1df90365"
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
