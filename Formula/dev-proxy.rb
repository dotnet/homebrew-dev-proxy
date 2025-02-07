class DevProxy < Formula
  proxyVersion = "0.24.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "BD960F9219E55003F136BD16C5CB4A86C0290A36A06A7A749EA3937571DC5E5D"
  else
    proxyArch = "osx-x64"
    proxySha = "0E8717ADFEBD45F7218F58BAB6F1E0197AF14ED09DBDCE8E494E0763F72DD883"
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