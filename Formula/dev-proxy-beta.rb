class DevProxyBeta < Formula
  proxyVersion = "3.2.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "4585b70e5adcfbd695626fff9e18d99bbe675b6e8b6f60a4fd96c0007b56b489"
  else
    proxyArch = "osx-x64"
    proxySha = "7d811ef64c1d02454219361d661cd80ae552223a750a041a05c9198b1fb78726"
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