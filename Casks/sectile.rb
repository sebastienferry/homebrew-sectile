cask "sectile" do
  arch arm: "arm64", intel: "amd64"

  # bin/update-cask rewrites the version and both checksums from the
  # SHA256SUMS of the GitHub Release; edit those lines by hand only to pin.
  version "0.5.0"
  sha256 arm:   "2f51dfb7eef6197d8dc7f1698de17af4d3ee2907134aea60f86b85817629591a",
         intel: "64f46d3091d42b72ad5473d871f8771865c2036bee9f01d9894924f61f253c16"

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
