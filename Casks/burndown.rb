cask "burndown" do
  version "0.9.10"
  sha256 "b64a7f800f2680e62bb5fb6a5bfe76cea0d54ffc2b3fe1309d70a614d85fd9e9"

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
  # quarantined copy. Homebrew has removed quarantine skipping entirely (the --no-quarantine
  # flag is gone and HOMEBREW_CASK_OPTS no longer carries it), so every install arrives
  # quarantined and the caveats point at the routes that still work: xattr, System Settings,
  # or building from source. Right-click > Open died in macOS 15 Sequoia.
  caveats <<~EOS
    Burndown is ad-hoc signed for now, so macOS quarantines the download and
    Gatekeeper blocks the first open. Any one of these gets past it:

      1. Clear the flag on the copy you just installed (one command, once):
           xattr -d com.apple.quarantine "#{appdir}/Burndown.app"
         (Homebrew has removed quarantine skipping entirely, so every brew
         install arrives quarantined; this is the supported route.)

      2. Or without the Terminal: try to open Burndown, let macOS block it, then
         go to System Settings > Privacy & Security, scroll to Security, and
         click "Open Anyway". That button only appears for about an hour after a
         blocked launch. (macOS 15 removed the old right-click > Open shortcut.)

      3. Or build from source instead. A locally built app is never quarantined:
           git clone https://github.com/maz0x/burndown && cd burndown && ./build.sh

    What it reads and every host it can contact, with verification steps:
    https://burndown-app.pages.dev/trust
  EOS

  zap trash: [
    "~/.config/burndown",
    "~/Library/Preferences/com.maz.burndown.plist",
    "~/Library/LaunchAgents/com.maz.burndown.plist",
  ]
end
