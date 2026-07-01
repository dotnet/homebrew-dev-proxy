class DevProxy < Formula
  proxyVersion = "3.1.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "a08507570ea012bbe145348eef3adf9a0eb2cf6a7b34583d53ad5ec32b6bf009"
  else
    proxyArch = "osx-x64"
    proxySha = "e86c431f3f696abdf4501ac05fd00b86d674f0e6ecd8c83e06797abbb654deda"
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