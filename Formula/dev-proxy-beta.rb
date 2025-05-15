class DevProxyBeta < Formula
  proxyVersion = "0.28.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "EDB18F5171CA4230114857E68394FF5541AF6B1101654FAA3266E9FBA3E3885F"
  else
    proxyArch = "osx-x64"
    proxySha = "15F0CC56854DAAB828EB33607DE9E3CDA8019548BAB956CAFEB0A49A5B9D5B2E"
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