class DevProxyBeta < Formula
  proxyVersion = "0.24.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "531085D163BCECB25A7B2A5F3A8E3553F2E354E8AA629C3D14233C7B89C52A3B"
  else
    proxyArch = "osx-x64"
    proxySha = "650773271914CB165CCAB38EE121270D5772FF82958F5C6E9E173CDF582F2CD9"
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