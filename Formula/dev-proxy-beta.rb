class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "8e6594cdb574c2daf205f9e6a39dd81eb895b785f75cac5b7d572440fee93516"
  else
    proxyArch = "osx-x64"
    proxySha = "f7bcaa3a149a623cd3fd86e6d5d893829f7204e99b8bce0852bafee4cdd990f5"
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