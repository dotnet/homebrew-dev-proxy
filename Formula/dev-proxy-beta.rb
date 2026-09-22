class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "781d80c367c26257b8a33d5e6ede47dcc662f4565aa47d4c6d97ceb9f35e13c9"
  else
    proxyArch = "osx-x64"
    proxySha = "75002a04eb1d987c6fd3177c973f67a10f5dc6eca8ece33e4137b03a63669cd6"
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