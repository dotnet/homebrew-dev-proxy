class DevProxyBeta < Formula
  proxyVersion = "0.28.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "1986600B904E3380EBE76D3A6AA9A8442C6B864448A4FEC66AA970A1BFEF4BB7"
  else
    proxyArch = "osx-x64"
    proxySha = "DA64A291C239EE70CDEA881BAFAE8227909AB6CE0A0CBB03226C2DF78CDAC922"
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