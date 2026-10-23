class Cliproxyapi < Formula
  desc "CLIProxyAPI built with the cpa-key-policy integration patches"
  homepage "https://github.com/wignerStan/cpa-plugin-key-policy"
  license "MIT"
  head "https://github.com/wignerStan/cpa-plugin-key-policy.git", branch: "main"

  depends_on "go" => :build
  depends_on "python@3.14" => :build

  resource "infra-d0c058fc" do
    url "https://github.com/wignerStan/infra.git",
        revision: "d0c058fc132ff392d9f96e858f0f6ccd0e1d2037"
  end

  def install
    infra_source = buildpath/"build/infra-source"
    resource("infra-d0c058fc").stage infra_source
    ENV["INFRA_GO_DIR"] = (infra_source/"go").to_s
    ENV["CC"] = "/usr/bin/cc" if OS.linux?
    system "bash", "scripts/materialize-cliproxyapi.sh"
    build_root = buildpath / "build" / "cliproxyapi"
    ldflags = %W[
      -X main.Version=#{version}
      -X main.Commit=wignerstan/cpa-plugin-key-policy
      -X main.BuildDate=#{time.iso8601}
      -X main.DefaultConfigPath=#{etc / "cliproxyapi.conf"}
    ]

    Dir.chdir(build_root) do
      system "go", "build", *std_go_args(output: bin / "cliproxyapi", ldflags: ldflags),
             "./cmd/server"
      etc.install "config.example.yaml" => "cliproxyapi.conf"
    end
  end

  service do
    run [opt_bin / "cliproxyapi", "-config", etc / "cliproxyapi.conf"]
    keep_alive true
  end

  test do
    output = shell_output("#{bin}/cliproxyapi --version 2>&1", 2)
    assert_match "CLIProxyAPI Version:", output
  end
end
