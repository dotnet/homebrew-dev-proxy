class DevProxy < Formula
  proxyVersion = "1.0.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "035e73e2ecb98032cd0417203ef8998e35d475f115e55960ac37844ec04897a8"
  else
    proxyArch = "osx-x64"
    proxySha = "730ca9cd15e428fb039034afb887ba920087c9d641fd73069b527551e8ed403c"
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