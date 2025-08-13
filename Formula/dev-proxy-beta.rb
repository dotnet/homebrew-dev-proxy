class DevProxyBeta < Formula
  proxyVersion = "1.1.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "0b5adf6e6c91e23f79cd03a43c2febbafae8b1e867f37787f95f2b33249620c6"
  else
    proxyArch = "osx-x64"
    proxySha = "e75d746b4d4cce44e8f736d8906bcd3e76e08d459f4553f480e024950a3c482d"
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