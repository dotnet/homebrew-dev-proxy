class DevProxy < Formula
  proxyVersion = "1.1.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "255a724328af6d88dff0d4b0dd7c1354869e768b7292abbb2b146097c5811524"
  else
    proxyArch = "osx-x64"
    proxySha = "a9326ddf4113acb2f9b3c0493bb28457bf6e91483732dbbba900faf73c968385"
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