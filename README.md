# maz0x/homebrew-tap

Homebrew tap for [Burndown](https://github.com/maz0x/burndown), a macOS menu bar
monitor for Claude session and weekly usage limits.

```bash
HOMEBREW_CASK_OPTS="--no-quarantine" brew install --cask maz0x/tap/burndown
```

Releases are ad-hoc signed for now, so macOS quarantines the download and
Gatekeeper blocks the first open. The `HOMEBREW_CASK_OPTS` prefix above tells
Homebrew not to attach the quarantine flag; Homebrew describes that as a
Gatekeeper bypass that reduces system security, so it is your call to make.
Homebrew removed the `--no-quarantine` command-line flag, and a cask cannot set
the variable on your behalf, so this is the only form that still works.

If you would rather install plainly and deal with it afterwards, run
`brew install --cask maz0x/tap/burndown` and then either
`xattr -d com.apple.quarantine /Applications/Burndown.app`, or click **Open
Anyway** in System Settings > Privacy & Security > Security within about an hour
of the blocked launch. Apple removed the right-click > Open shortcut in macOS 15,
so that no longer works. Building from source avoids all of this: a locally
built app is never quarantined.
