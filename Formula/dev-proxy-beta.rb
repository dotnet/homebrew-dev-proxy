class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ec12ab67e810a91e966fb3cbe4209bc7b7cf34cd458fe3d0f1d2d4b2f705e815"
  else
    proxyArch = "osx-x64"
    proxySha = "865d4a3c80e443e01e6f553b78f8401bb6fc6fe84067163c8db92efb38704ef1"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/dotnet/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy-beta"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy-beta"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy-beta --version")
  end

  livecheck do
    url :head
    regex(/^v(.*)$/i)
  end
end