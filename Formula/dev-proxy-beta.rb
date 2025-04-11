class DevProxyBeta < Formula
  proxyVersion = "0.27.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "5A7E4D4667CB7E7D7B8266B45D9D733409D610BEE071D0D56FA08561746A76AE"
  else
    proxyArch = "osx-x64"
    proxySha = "6B060C1000F5ED74CB8DD28583BC2FE01D11FEC66BAAB54F92C8D7718315AA06"
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