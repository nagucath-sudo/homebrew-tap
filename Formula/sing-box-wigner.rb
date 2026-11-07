class SingBoxWigner < Formula
  desc "Universal proxy platform with native DAE and Tailscale integrations"
  homepage "https://github.com/bmfv4smm7g-hash/sing-box"
  version "1.15.0-dev.20261102-wigner.1"
  license "GPL-3.0-or-later"
  version_scheme 1

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/bmfv4smm7g-hash/sing-box/releases/download/v1.15.0-dev.20261102-wigner.1/sing-box-v1.15.0-dev.20261102-wigner.1-darwin-arm64.tar.gz"
    sha256 "173722f1d3ff8613611b133a3541191f20a8a0187a6cced29604d8eec07c8f3d"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/bmfv4smm7g-hash/sing-box/releases/download/v1.15.0-dev.20261102-wigner.1/sing-box-v1.15.0-dev.20261102-wigner.1-linux-amd64.tar.gz"
    sha256 "8362ff6c32e095251ba25fd3c99a41f0c23f2ab5c7894423db2a7725d7bcfe3b"
  end

  conflicts_with "sing-box", because: "both install a sing-box executable"

  def install
    bin.install "sing-box"
    pkgshare.install "SOURCE_COMMIT", "VENDOR_LOCK.json", "SHA256SUMS"
    generate_completions_from_executable(bin/"sing-box", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
    (testpath/"config.json").write <<~JSON
      {"inbounds":[{"type":"mixed","listen":"127.0.0.1","listen_port":1080}]}
    JSON
    system bin/"sing-box", "check", "-c", testpath/"config.json"
    assert_match "tailscale", shell_output("#{bin}/sing-box api tailscale --help").downcase
  end
end
