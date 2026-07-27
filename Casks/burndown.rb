cask "burndown" do
  version "1.1"
  sha256 "8099776444910336d96b324e75a83d43a762c9715586d0e1921e3e66dae6d4b3"

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
