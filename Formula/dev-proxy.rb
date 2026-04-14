class DevProxy < Formula
  proxyVersion = "2.3.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "81765b7f22d19bdf1c51b0297df41e6f608bf888c567f87d4fa93a34424fb629"
  else
    proxyArch = "osx-x64"
    proxySha = "79b882be80b24845bfcb7ab32573c3f1ffc135bf198468708445b37f89722981"
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