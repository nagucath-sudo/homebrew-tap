class TailscaleWigner < Formula
  desc "Tailscale with direct CGNAT routing support"
  homepage "https://github.com/nagucath-sudo/tailscale"
  version "1.104.4-wigner.1"
  license "BSD-3-Clause"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/nagucath-sudo/tailscale/releases/download/v1.104.4-wigner.1/tailscale-v1.104.4-wigner.1-darwin-arm64.tar.gz"
    sha256 "6c907945fe2e0d8bcce76cafa55676d3d5fa0d8d41efb22b506aeccd3478f6d9"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/nagucath-sudo/tailscale/releases/download/v1.104.4-wigner.1/tailscale-v1.104.4-wigner.1-linux-amd64.tar.gz"
    sha256 "1bcf61fbac4b00d36c4b3293e2d0770b9289fea796023853b61fb48c0dc2ab7b"
  end

  conflicts_with "tailscale", because: "both install the tailscale command"

  def install
    bin.install "tailscale"
    sbin.install "tailscaled"
    pkgshare.install "SOURCE_COMMIT", "UPSTREAM_COMMIT", "SHA256SUMS"
  end
end
