cask "kiln" do
  version "0.9.0"
  sha256 "5253e1d2bedb4314ee127a567709429b4e3c4a5939a11e28348b6e9ccdb57d8b"

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
