class DevProxy < Formula
  proxyVersion = "0.29.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "1bb143b162cb95cb63a09b2b56b69dc4ae20c95d013ec4fee148cd215dab3781"
  else
    proxyArch = "osx-x64"
    proxySha = "27e62a1eac28624d691d283848620f2d4868bd90b583bd0013bf4b47c0ce49be"
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