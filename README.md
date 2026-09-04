# GameCI Homebrew Tap

Homebrew formulae for [GameCI](https://game.ci).

## Install

```bash
brew install game-ci/tap/game-ci
```

Upgrade later with:

```bash
brew upgrade game-ci
```

## What this installs

The `game-ci` CLI — build and test commands for Unity, Godot, Unreal and Bevy
projects, locally and in CI. See the
[documentation](https://game.ci/docs/cli) for usage.

Homebrew puts `game-ci` on your `PATH` and handles upgrades and uninstall for
you. If you would rather not use Homebrew, the install script works anywhere:

```bash
curl -fsSL https://raw.githubusercontent.com/game-ci/cli/main/install.sh | sh
```

## A note on packaging

The `game-ci` binary is not self-contained: it resolves static assets
(`default-build-script/`, `platforms/*`, `unity-config/`) from a `dist/`
directory that must sit alongside it on disk, because those paths are mounted
into Docker containers during a build (see
[game-ci/cli#73](https://github.com/game-ci/cli/issues/73)).

The formula therefore installs the whole extracted release into `libexec` and
exposes the binary through a wrapper, instead of symlinking the executable out
of its directory. Packaging that assumes "one archive, one binary" will produce
an install that passes `game-ci --help` and then fails on any real build.

## Updating the formula

Formula updates are automated from the
[game-ci/cli](https://github.com/game-ci/cli) release workflow. To update by
hand, bump `version`, the four `url`s and the four `sha256`s to match the
`checksums.txt` published with the release.

## License

MIT
