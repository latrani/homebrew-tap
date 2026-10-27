class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.9.3",
      revision: "883115f968f75b5bb73a859e62fb57a0258cdabc"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  bottle do
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.9.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "252f4991868e3964d96df496f289ba0c7a5f247e24afd797f142ec2c4d628f4a"
    sha256 cellar: :any,                 x86_64_linux: "9c7cc2bdcbb5972f08e31d2efb4eec94c668151b04e10a5c53ff03b87a0b5334"
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
