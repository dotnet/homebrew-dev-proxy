class DevProxyBeta < Formula
  proxyVersion = "2.0.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6edd689124fb0c3fbbe9646c58f22c0e007e7592c459e7178c9b410544917a09"
  else
    proxyArch = "osx-x64"
    proxySha = "3e7e93862a24628ba148e5695e5e5071aa47637c27b3d77f2d3f54fd47b15644"
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