class DevProxyBeta < Formula
  proxyVersion = "3.0.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "aa923124f2cd7e77020051d507f2357c41f3fb4bf9594d894acc42b743feb0c1"
  else
    proxyArch = "osx-x64"
    proxySha = "d610fd98b7254cc074bccadd4dc5e43a17ea4b13eaba5afcd71c3be921cf4b04"
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