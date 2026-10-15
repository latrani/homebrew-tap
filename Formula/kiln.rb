class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.7.0",
      revision: "94c082b931f24eca954345ccb3c77d14bfca64e5"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  bottle do
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4239a75ca995bd12413efcbc09e56963795dbd6a1b2999685e159b15a32e3385"
    sha256 cellar: :any,                 x86_64_linux: "30fb32d5b82562ce8630aec030238e014927f4e1e63a1c5a3cb8eef4745ec25b"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/kiln"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiln version")
  end
end
