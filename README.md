# Homebrew tap for Sectile

[Sectile](https://github.com/sebastienferry/sectile) Desktop for macOS 13
(Ventura) or later, Apple Silicon and Intel, as a Homebrew cask.

```sh
brew install --cask sebastienferry/sectile/sectile
```

Installing by this fully qualified name taps this repository and
[trusts](https://docs.brew.sh/Tap-Trust) the `sectile` cask only, not the
whole tap. The app bundles its Sectile agent: nothing else needs installing.
Upgrade with `brew upgrade --cask sectile`, remove with
`brew uninstall --cask sectile` (add `--zap` to also delete its settings and
logs).

## What the cask does

- It downloads `sectile-desktop-darwin-<arch>.zip` from the GitHub Release of
  the version it names, and checks it against the checksum that release
  publishes in `SHA256SUMS`.
- It removes the quarantine mark from `Sectile.app` after installing it. The
  app carries an ad-hoc signature and is not notarized, so macOS would
  otherwise report it as damaged and refuse to open it. Installing the cask
  means trusting the Sectile releases on GitHub.

## How it is kept up to date

`.github/workflows/update.yml` runs every six hours and on demand. It runs
`bin/update-cask`, which points the cask at the latest Sectile release and
copies its checksums from `SHA256SUMS`; when that changes the cask, the
workflow audits it, installs and uninstalls it on a macOS runner, and commits
it to `main`. To publish a release at once, run the workflow by hand from the
**Actions** tab, optionally with a tag.

Run the same update locally with:

```sh
sh bin/update-cask          # the latest release
sh bin/update-cask v0.3.0   # a given one
```
