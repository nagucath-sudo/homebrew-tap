class TailscaleWigner < Formula
  desc "Tailscale with direct CGNAT routing support"
  homepage "https://github.com/bmfv4smm7g-hash/tailscale"
  version "1.104.4-wigner.1"
  license "BSD-3-Clause"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/bmfv4smm7g-hash/tailscale/releases/download/v1.104.4-wigner.1/tailscale-v1.104.4-wigner.1-darwin-arm64.tar.gz"
    sha256 "b08cb8d3ed62563e9030177d7c0f47917a01e73e69b130a1fe086fba31199839"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/bmfv4smm7g-hash/tailscale/releases/download/v1.104.4-wigner.1/tailscale-v1.104.4-wigner.1-linux-amd64.tar.gz"
    sha256 "d6b68e300d2f8aad13a6bcfabb2580af9ee5dcbf9c4fbda14049c7491a463153"
  end

  conflicts_with "tailscale", because: "both install the tailscale command"

  def install
    bin.install "tailscale"
    sbin.install "tailscaled"
    pkgshare.install "SOURCE_COMMIT", "UPSTREAM_COMMIT", "SHA256SUMS"
  end
end
