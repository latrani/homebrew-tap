class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.5.3",
      revision: "7defbf31b8651d3b1e4ef03dee87358bc55f41ad"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/kiln"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiln version")
  end
end
