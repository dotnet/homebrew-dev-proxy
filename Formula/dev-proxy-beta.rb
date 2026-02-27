class DevProxyBeta < Formula
  proxyVersion = "2.2.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "113beb77be5e719c84d33a674f624f886df55d9a5bb90064748376fe369e868e"
  else
    proxyArch = "osx-x64"
    proxySha = "d6a30f2a5aed45530bd73a72d1dd05681d747985460c1e4284a7f31e7190920a"
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