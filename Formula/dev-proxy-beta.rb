class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.7"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "7bb8f83adbfdec784cff06e52b6f1097a3803a3cae7788645daf30fda9ad59a2"
  else
    proxyArch = "osx-x64"
    proxySha = "e3ad0250d10619438d2248f8b96472f95eb72edb423b6e5a63d2595727f90b5d"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/dotnet/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy-beta"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy-beta"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy-beta --version")
  end

  livecheck do
    url :head
    regex(/^v(.*)$/i)
  end
end