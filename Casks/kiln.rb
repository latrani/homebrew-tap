cask "kiln" do
  version "0.9.0-rc.1"
  sha256 "fd4761bfca735efc2985be6941622829de8305e0a01ac4f873234598f433a3ad"

  url "https://github.com/latrani/Kiln/releases/download/v#{version}/Kiln-#{version}-macos-universal.zip"
  name "Kiln"
  desc "MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Kiln.app"

  # The app is only ad-hoc signed, so Gatekeeper would refuse a quarantined
  # copy. Homebrew disables Gatekeeper-failing casks only in homebrew/cask,
  # not in a third-party tap.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Kiln.app"]
  end
end
