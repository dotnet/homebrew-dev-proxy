class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.13"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "3770a77a565aa1415754644878004c4939265b9dca5d110004cfb01776e0eafa"
    else
      proxyArch = "linux-x64"
      proxySha = "cec6b106786654a63ed500ddd7fb1e8fc7ef48bcfe8657599b43aabed05a454d"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "5663f479ddd9f84e10055eb115233e618edb3c87293598ca8b8509dbc0bab574"
    else
      proxyArch = "osx-x64"
      proxySha = "1dd7fd4bc157190654dc55f0acc2769543cb82cffecc6f78975ec6a17e2225db"
    end
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