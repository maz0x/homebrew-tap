cask "burndown" do
  version "0.9.2"
  sha256 "b75dd7d211052312982ac255c8bf6c7835d5e21d0fe68e483896434bc766dba3"

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

  # Releases are ad-hoc signed until a Developer ID certificate lands, so Gatekeeper blocks the
  # quarantined copy. A cask cannot opt itself out of quarantine (there is no quarantine stanza
  # in the Cask DSL), and Homebrew removed the --no-quarantine command-line flag, so the caveats
  # below point at the routes that still work: the HOMEBREW_CASK_OPTS env var, xattr, System
  # Settings, or building from source. Right-click > Open died in macOS 15 Sequoia.
  caveats <<~EOS
    Burndown is ad-hoc signed for now, so macOS quarantines the download and
    Gatekeeper blocks the first open. Any one of these gets past it:

      1. Clear the flag on the copy you just installed:
           xattr -d com.apple.quarantine "#{appdir}/Burndown.app"

      2. Or reinstall without the quarantine flag ever being attached:
           brew uninstall --cask burndown
           HOMEBREW_CASK_OPTS="--no-quarantine" brew install --cask maz0x/tap/burndown
         Homebrew describes this as a Gatekeeper bypass that reduces system
         security. It is your call: you are choosing to trust this build.

      3. Or without the Terminal: try to open Burndown, let macOS block it, then
         go to System Settings > Privacy & Security, scroll to Security, and
         click "Open Anyway". That button only appears for about an hour after a
         blocked launch. (macOS 15 removed the old right-click > Open shortcut.)

      4. Or build from source instead. A locally built app is never quarantined:
           git clone https://github.com/maz0x/burndown && cd burndown && ./build.sh
  EOS

  zap trash: [
    "~/.config/burndown",
    "~/Library/Preferences/com.maz.burndown.plist",
    "~/Library/LaunchAgents/com.maz.burndown.plist",
  ]
end
