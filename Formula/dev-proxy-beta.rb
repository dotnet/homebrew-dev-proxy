class DevProxyBeta < Formula
  proxyVersion = "3.1.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "d4963e811abe8c6a2c3de095c6ea2f057b30e466bb9e67418b1c72ee8df84e0b"
  else
    proxyArch = "osx-x64"
    proxySha = "b66e7b4d01f85a32c72ca83ef08e168263a722b7893013faeea29440f65b4784"
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