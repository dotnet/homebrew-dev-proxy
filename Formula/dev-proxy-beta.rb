class DevProxyBeta < Formula
  proxyVersion = "2.4.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "bbbe26cfb3eae50fe902c77c948a636b85499f894cd0b54375537f02ae4f2b85"
  else
    proxyArch = "osx-x64"
    proxySha = "aed67244bb075a914b7d83a647207d736dd8ba42d03d7a560745da0baa358ba9"
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