class DevProxy < Formula
  proxyVersion = "2.3.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "81bfdb63aeb61671069bc949221a1ed20e3c5643f13360cbe1e33313c0e6f691"
  else
    proxyArch = "osx-x64"
    proxySha = "633a363b30e05f093bc5614d1df4aa2f014300b1f9475a7636571dd5159857ad"
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