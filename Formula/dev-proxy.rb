class DevProxy < Formula
  proxyVersion = "3.3.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "29f4699a26ec541201698310c929474237da7ebabf295234a3864e14592134b1"
  else
    proxyArch = "osx-x64"
    proxySha = "ab07002a7e22b6dc19ce03d4097ad646c75cb28fd9f7040d1aeebd3531b95bd4"
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