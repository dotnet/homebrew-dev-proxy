class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.9"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "2deac2ba4da8234b5c64d2cbfc99518f88cb32124993a0c8086c496027f2826e"
  else
    proxyArch = "osx-x64"
    proxySha = "b021764e80dc76877376b5e0a1113e15fcdc198417d24340c4789ce043f09230"
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