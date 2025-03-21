class DevProxyBeta < Formula
  proxyVersion = "0.26.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "991CABFAFF44CC231F739B0E9E38B74E892819423D7B1A5ACE8AAD3645BC4B33"
  else
    proxyArch = "osx-x64"
    proxySha = "678FB9FF292CE7A92724BE95C301C6012C937B0BFE22DD13358FB63CFF105876"
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