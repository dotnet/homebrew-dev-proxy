class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.5"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "1f5017603a3a542cd1f01eb6cd2be7c982b9b40487e3845c1e3fd8c54535f2bc"
  else
    proxyArch = "osx-x64"
    proxySha = "e173b60827245ed6257e7517605b1b4237675b4ef5e13a2764f8d4e034241ed9"
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