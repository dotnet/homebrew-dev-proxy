class DevProxyBeta < Formula
  proxyVersion = "2.0.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "0e960e7fd002eebdc7f2672d0f330101d594f57617545e47c752b5d7186c1f33"
  else
    proxyArch = "osx-x64"
    proxySha = "d40baf81962b6ba92f4a7a940cce937b6b5f57a19be7621867329ac40823cbb8"
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