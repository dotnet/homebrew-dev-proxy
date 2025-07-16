class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.6"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "70305d9f2c851b320aa4145319aab0bb8fe72f0ff230f779605fce5075e31515"
  else
    proxyArch = "osx-x64"
    proxySha = "732eff28a135356fb957f8ddc4c5399a1cbdb4ba8053d410f0c4fd8a410e81d3"
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