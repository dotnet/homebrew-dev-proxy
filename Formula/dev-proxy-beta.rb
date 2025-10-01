class DevProxyBeta < Formula
  proxyVersion = "1.3.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "d52b6a748fc0a4117d51a90ded33b8e93fa8fc0f62f64d6fd522f006ed4cf65f"
  else
    proxyArch = "osx-x64"
    proxySha = "e67a98253027ef4af156bab4e6b672159ee79938d798c07a147ecc4227c94ee9"
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