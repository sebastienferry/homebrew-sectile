cask "sectile" do
  arch arm: "arm64", intel: "amd64"

  # bin/update-cask rewrites the version and both checksums from the
  # SHA256SUMS of the GitHub Release; edit those lines by hand only to pin.
  version "0.4.1"
  sha256 arm:   "cbdceea607a852e2170a00258858e294a493c73787226985855f7620ad650e4f",
         intel: "f0e45bd38e61b002bbc0179b57cfaf4678fb81a6aad3e84558b66adfef58ff77"

  # The archive holds the directory @electron/packager writes, named after
  # Electron's arch token (x64), not Go's (amd64).
  on_arm do
    app "Sectile-darwin-arm64/Sectile.app"
  end
  on_intel do
    app "Sectile-darwin-x64/Sectile.app"
  end

  url "https://github.com/sebastienferry/sectile/releases/download/v#{version}/sectile-desktop-darwin-#{arch}.zip"
  name "Sectile"
  name "Sectile Desktop"
  desc "Local-first workflow manager for tickets, coding agents and pull requests"
  homepage "https://github.com/sebastienferry/sectile"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  # The app carries an ad-hoc signature and is not notarized: with the
  # quarantine mark Homebrew sets on the download, macOS reports it as damaged
  # and refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Sectile.app"]
  end

  zap trash: [
    "~/Library/Application Support/sectile-desktop",
    "~/Library/Preferences/com.electron.sectile.plist",
    "~/Library/Saved Application State/com.electron.sectile.savedState",
  ]
end
