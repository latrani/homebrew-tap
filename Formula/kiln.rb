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
    root_url "https://github.com/latrani/homebrew-tap/releases/download/kiln-0.5.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8defb1386dfb4cd3bb27fe174f0c247db14bbeb85eabafcaffd857e0845613e5"
    sha256 cellar: :any,                 x86_64_linux: "1d191164cf25e96896e97c1f64d3bedab3fd5bcef9241e267394918b77109b6c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/kiln"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kiln version")
  end
end
