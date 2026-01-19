class DevProxyBeta < Formula
  proxyVersion = "2.1.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "53060fcd8beb23a157378d387b8df7f38e30dcebc289423a246eab9e4168b272"
  else
    proxyArch = "osx-x64"
    proxySha = "17c5c67a41724fceca48975c6b1658a3a2f66b7f9c9461934c608d33d7ae30e1"
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