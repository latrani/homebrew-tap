class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.7.1",
      revision: "5b1bec8296f2d6c2229ccfb1ea9640c2d133a7ad"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  bottle do
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.7.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4e8321d3e97603fea40aed054c6372a0135bf83b8102744dbb43bbf5de53e677"
    sha256 cellar: :any,                 x86_64_linux: "a2413f0da2d79d6cac0231680885d8f676841d8fa0f50f491b286ddd91dc5c1d"
  end

  depends_on "go" => :build
  depends_on "node" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/kiln"
    system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/"kiln-relay"), "./cmd/kiln-relay"
    # The web page: the wasm and the page itself, built into web/static.
    system "web/build.sh"
    (share/"kiln/web").install Dir["web/static/*"].reject { |f| f.end_with?(".test.mjs") }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiln version")
    assert_match "-allow", shell_output("#{bin}/kiln-relay 2>&1", 1)
    assert_path_exists share/"kiln/web/index.html"
    assert_path_exists share/"kiln/web/kiln.wasm"
  end
end
