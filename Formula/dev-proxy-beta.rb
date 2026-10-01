class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.5"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "5ac39e7e7a29247c9107ca991148a5681aaede581d750737c98f4b778f99c77c"
  else
    proxyArch = "osx-x64"
    proxySha = "cbffac36b7eb4eebafa6095bb9ed6999eeaf9af5c77071833118a949edf0b145"
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