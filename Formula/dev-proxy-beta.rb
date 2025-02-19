class DevProxyBeta < Formula
  proxyVersion = "0.25.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "2FB1B953A2E907E67D7D3129E8D736AACD891C8AE80F137EBF3A49B9CBF5FC21"
  else
    proxyArch = "osx-x64"
    proxySha = "48B1DB5E8D2AAD3F786F19B4ECCFB4C5387CED3E7566A816CB829164C1844DBC"
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