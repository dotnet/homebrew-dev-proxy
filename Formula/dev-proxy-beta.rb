class DevProxyBeta < Formula
  proxyVersion = "3.0.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ac0b9e30ce12208e16ed21e7ccd45af15686cee93431d2245dbd9855320bbb01"
  else
    proxyArch = "osx-x64"
    proxySha = "0a9e05fce49130088e6b5242a2563aa2becd7730e898934c39c24dce63cf23b2"
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