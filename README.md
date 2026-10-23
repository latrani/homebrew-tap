# latrani/tap

Homebrew formula and cask for [Kiln](https://github.com/latrani/Kiln):
the `kiln` formula is the terminal client, and the `kiln` cask is the
desktop app (macOS).

```sh
brew install latrani/tap/kiln          # terminal
brew install --cask latrani/tap/kiln   # desktop app
```

## How releases get here

1. Publishing a full Kiln release sends a `kiln-release` dispatch here
   (Kiln's `.github/workflows/homebrew.yml`). Prereleases (`v1.2.3-rc.1`)
   don't.
2. `bump.yml` opens two PRs: `bump-kiln-<version>` with the formula's new
   tag and commit, and `bump-cask-kiln-<version>` with the cask's new
   version and the sha256 of the release's macOS zip.
3. `tests.yml` (brew test-bot) audits both, and builds, tests and
   bottles the formula.
4. When the formula PR passes, `publish.yml` runs `brew pr-pull`: the
   bottles go up as a release here and the formula lands on `main`. The
   cask PR has no bottles: merge it with the Merge button once it passes.

A bump can also be started by hand: Actions → "bump" → "Run workflow".
Any other PR that changes the formula is published by running
"brew pr-pull" with its number; one that doesn't (the cask, workflows,
this README) is merged with the Merge button.

An rc's cask is set by hand: a PR that sets the cask's `version` and
`sha256` from the rc's macOS zip.

`TAP_TOKEN` is a fine-grained token for this repo (Contents and Pull
requests: write). Kiln uses the same token to send the dispatch, and the
bump PRs have to be opened with it: a PR opened with `GITHUB_TOKEN`
doesn't start test-bot.
