class DevProxy < Formula
  proxyVersion = "2.4.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "458588d4f541f1bb5ac225d389e454a5242cb8251cad4ba9a6abd40da8c0c9d7"
  else
    proxyArch = "osx-x64"
    proxySha = "f31e68a32a8392cd18cf44f4530dcc6c52e491cbbe9baa61df30c2139de2e7fb"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/dotnet/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy --version")
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end