class DevProxy < Formula
  proxyVersion = "1.2.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "12329853c5383e71c4c09ed551b1a782396ae3a69bc071e9ceb359c26a882531"
  else
    proxyArch = "osx-x64"
    proxySha = "d5a4fc419457c6899b55e61dde9ee505550b9c55b1face9e50b0295353630155"
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