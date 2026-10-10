class Kiln < Formula
  desc "Terminal MUCK client for tracking multiple characters and worlds"
  homepage "https://github.com/latrani/Kiln"
  # A git URL, not a tarball: Kiln reads its version from the git tag Go
  # stamps into the build, and a tarball has no .git to stamp from.
  url "https://github.com/latrani/Kiln.git",
      tag:      "v0.6.0",
      revision: "e42218a9f5ba67d2d282978594ab0c048a5b1192"
  license "MIT"
  head "https://github.com/latrani/Kiln.git", branch: "main"

  bottle do
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c11b971b8c1a0d71a340f109a4c821793237c9a7752bbda14a9575f179b5dc71"
    sha256 cellar: :any,                 x86_64_linux: "6643b3810e6bae9f9643ee9b0c8a16ce721bfe6366c204848b5924dbf489b559"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/kiln"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiln version")
  end
end
