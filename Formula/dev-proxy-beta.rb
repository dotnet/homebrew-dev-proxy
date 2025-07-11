class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "e5e0cdbe4377edc293406bf40bc9d9d386553431e67c83413cb17085263ca59d"
  else
    proxyArch = "osx-x64"
    proxySha = "b367b867f38cfbac79b7cbe688577aacb1c743d1cfa3c9c0214aa060c67e9321"
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