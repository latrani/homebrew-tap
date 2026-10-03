# latrani/tap

Homebrew formulae for [Kiln](https://github.com/latrani/Kiln).

```sh
brew install latrani/tap/kiln
```

## How releases get here

1. Publishing a Kiln release sends a `kiln-release` dispatch here
   (Kiln's `.github/workflows/homebrew.yml`).
2. `bump.yml` opens a `bump-kiln-<version>` PR with the new tag and commit.
3. `tests.yml` (brew test-bot) builds and tests it, and makes bottles.
4. When that passes, `publish.yml` runs `brew pr-pull`: the bottles go up
   as a release here and the formula lands on `main`.

A bump can also be started by hand: Actions → "bump" → "Run workflow".
Any other PR is published by running "brew pr-pull" with its number.

`TAP_TOKEN` is a fine-grained token for this repo (Contents and Pull
requests: write). Kiln uses the same token to send the dispatch, and the
bump PR has to be opened with it: a PR opened with `GITHUB_TOKEN` doesn't
start test-bot.
