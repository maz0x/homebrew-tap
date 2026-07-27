cask "burndown" do
  version "0.9.0"
  sha256 "2e6df795c81825ebba33f2d8f60f34e1f125b221d4323457bf59080b08839041"

  url "https://github.com/maz0x/burndown/releases/download/v#{version}/Burndown-#{version}.zip"
  name "Burndown"
  desc "Menu bar monitor for Claude session and weekly usage limits"
  homepage "https://github.com/maz0x/burndown"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Burndown.app"

  # Releases are ad-hoc signed until a Developer ID certificate lands, so Gatekeeper would
  # otherwise block the quarantined copy. Install with --no-quarantine, or right-click Open once.
  caveats <<~EOS
    Burndown is ad-hoc signed for now. If macOS refuses to open it, either install with:
      brew install --cask --no-quarantine maz0x/tap/burndown
    or right-click Burndown.app in Applications, choose Open, then Open again.
  EOS

  zap trash: [
    "~/.config/burndown",
    "~/Library/Preferences/com.maz.burndown.plist",
    "~/Library/LaunchAgents/com.maz.burndown.plist",
  ]
end
