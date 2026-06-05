class DevProxy < Formula
  proxyVersion = "3.0.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "870ba80453804fe16a8fb857779ff4887896fa488dfa1de6e8829f88d8c99de6"
  else
    proxyArch = "osx-x64"
    proxySha = "2c0c2546817309a7d8a1636e041dc15c7a5bd7ae48f99c75484dbece8c35783d"
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