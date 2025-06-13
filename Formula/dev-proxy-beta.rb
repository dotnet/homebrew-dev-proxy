class DevProxyBeta < Formula
  proxyVersion = "0.29.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "D455A81AE796720D97BAD3B97C57505B84F9E65AC5560B6A783B233EE42F4B69"
  else
    proxyArch = "osx-x64"
    proxySha = "F853487992E1BABCAB47CA70FAD9A07F36B39D937F843E530879315E628D18FB"
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