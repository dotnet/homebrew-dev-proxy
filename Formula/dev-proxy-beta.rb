class DevProxyBeta < Formula
  proxyVersion = "2.1.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "a6871befee0c22a3bbb50e501045f075660be974fcd92bbcdee1735b6e5d032a"
  else
    proxyArch = "osx-x64"
    proxySha = "a6871befee0c22a3bbb50e501045f075660be974fcd92bbcdee1735b6e5d032a"
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