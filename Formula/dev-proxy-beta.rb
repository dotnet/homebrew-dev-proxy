class DevProxyBeta < Formula
  proxyVersion = "0.27.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "72357C50D94F1F022F54ADB3FC2C8D4FD51901E31F5C0630C0D7F3B722EE4B55"
  else
    proxyArch = "osx-x64"
    proxySha = "D5687276F53DBFF4155F8E8C8891387E27146CAE32F6AB7D5F0ED804FBF26484"
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