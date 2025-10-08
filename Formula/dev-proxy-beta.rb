class DevProxyBeta < Formula
  proxyVersion = "1.3.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "d1e1dc7f568937bce698d1a2c277762c071290343eb228d73124cf14ec48ef7f"
  else
    proxyArch = "osx-x64"
    proxySha = "248e0f13d64f236ddf2323be3efbd3bb927cecdbd8bc78353e7c28777ca65a4b"
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