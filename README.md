# Homebrew Tokcat

Homebrew tap for Tokcat.

## Install

```sh
brew tap handlecusion/tokcat
brew install --cask tokcat
```

The `tokcat` cask installs the macOS menubar app and depends on the
`tokscale` formula in this tap, which installs the upstream CLI.

After installation, open Tokcat from Applications. It runs in the macOS menu
bar and reads token usage through the installed `tokscale` CLI.

## Packages

- `tokscale`: upstream CLI formula, sourced from `@tokscale/cli-darwin-arm64`
- `tokcat` cask: macOS menubar app, sourced from the `tokcat` GitHub release

## Thanks

Special thanks to [@junhoyeo](https://github.com/junhoyeo) for creating and
maintaining `tokscale`, the CLI that this menubar app builds on.
