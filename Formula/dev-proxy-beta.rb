class DevProxyBeta < Formula
  proxyVersion = "2.1.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "de8e9a14d73ee941532290c3ae507e162a4bb14c8b168fa6a7d740b56e25ac76"
  else
    proxyArch = "osx-x64"
    proxySha = "1ad0755761f2b31d33850e687d36bc5921cda23346927d70d3990f2d2d345b6b"
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