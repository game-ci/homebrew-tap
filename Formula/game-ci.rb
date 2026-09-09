class GameCi < Formula
  desc "CLI for building and testing games in CI (Unity, Godot, Unreal, Bevy)"
  homepage "https://game.ci"
  version "0.1.56"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.56/game-ci-macos-arm64.tar.gz"
      sha256 "cfd45ae3fd74fcb2baa706abaf74e64be33748d0fee0cc1df5fd4893b68e0f58"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.56/game-ci-macos-x64.tar.gz"
      sha256 "1b02c73582ab1c3a3a373070b59ab1b4009f9c57ecf0636158bf675f3408bb2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/game-ci/cli/releases/download/v0.1.56/game-ci-linux-arm64.tar.gz"
      sha256 "19458d3dad748f7ac75ae12d9721d89b72bc3c5577b9aab2650c2606dd84c9d9"
    end
    on_intel do
      url "https://github.com/game-ci/cli/releases/download/v0.1.56/game-ci-linux-x64.tar.gz"
      sha256 "6bb6a7d724fea6b2abca828e359faa0b46dec562c9e86c6aa2be2a5a900fa3fe"
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
