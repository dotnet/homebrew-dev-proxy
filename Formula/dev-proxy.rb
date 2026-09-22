class DevProxy < Formula
  proxyVersion = "3.3.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "30e063b18b18cced031c7ef69f07d925abe7a8045551c27fe3d43c41f4e9969a"
  else
    proxyArch = "osx-x64"
    proxySha = "5721d3b7aa65d6719fc154ecdf9cf8f614785edca6b8f6bebfe7c1f7045a1faf"
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