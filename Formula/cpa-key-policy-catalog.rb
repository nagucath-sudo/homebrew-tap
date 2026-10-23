class CpaKeyPolicyCatalog < Formula
  desc "CPA key-policy plugin with per-key model catalogs"
  homepage "https://github.com/wignerStan/cpa-plugin-key-policy"
  license "MIT"
  head "https://github.com/wignerStan/cpa-plugin-key-policy.git", branch: "main"

  depends_on "go" => :build
  depends_on "python@3.14" => :build

  resource "infra" do
    url "https://github.com/wignerStan/infra.git",
        revision: "9b82d375d097900094715c226209d940b405eb8e"
  end

  def install
    infra_source = buildpath/"build/infra-source"
    resource("infra").stage infra_source
    ENV["INFRA_GO_DIR"] = (infra_source/"go").to_s
    ENV["CGO_ENABLED"] = "1"
    ENV["GOFLAGS"] = "-mod=readonly"
    ENV["CC"] = "/usr/bin/cc"
    ENV["CXX"] = "/usr/bin/c++"
    system "bash", "scripts/prepare-go-workspace.sh"
    extension = OS.mac? ? "dylib" : "so"
    output = libexec/"cpa-key-policy.#{extension}"
    libexec.mkpath
    system "go", "build", "-trimpath", "-buildvcs=false", "-tags", "cshared",
           "-buildmode=c-shared", "-ldflags", "-s -w", "-o", output,
           "./cmd/cpa-key-policy"
    rm libexec/"cpa-key-policy.h"
  end

  def caveats
    <<~EOS
      Set CLIProxyAPI's plugins.dir to:
        #{opt_libexec}

      Then enable the cpa-key-policy plugin and configure catalog_groups.
    EOS
  end

  test do
    extension = OS.mac? ? "dylib" : "so"
    assert_path_exists libexec/"cpa-key-policy.#{extension}"
  end
end
