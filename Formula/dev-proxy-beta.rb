class DevProxyBeta < Formula
  proxyVersion = "1.1.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "f2c010f53024e559ca4206a5a013440645d8a29033bbddb0fb230330cf998603"
  else
    proxyArch = "osx-x64"
    proxySha = "a60bf23cf88a44143ff30e85ec47a416c29728a374a340a7ddd037b14c9293b1"
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