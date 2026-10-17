class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.8.1",
      revision: "6e010a581d1bd3543bfddd8908d72326392f8d69"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  bottle do
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "272149322ad836563cda527d6886c23b8144c29406cb9a34261c056e19b0e054"
    sha256 cellar: :any,                 x86_64_linux: "b610c7c32ed180751bca60f289181189113f9eacbf3b56180c7d91b634540ffa"
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
    assert_match "-config", shell_output("#{bin}/kiln-relay 2>&1", 1)
    assert_path_exists share/"kiln/web/index.html"
    assert_path_exists share/"kiln/web/kiln.wasm"
  end
end
