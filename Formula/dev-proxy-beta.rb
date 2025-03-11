class DevProxyBeta < Formula
  proxyVersion = "0.26.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "BB5C8F44E2A7A28E130BB41E6E8624D4A34F927382DB1C0CA48500B693A9CC7C"
  else
    proxyArch = "osx-x64"
    proxySha = "0E30251A788D618A0DFAB37E1BDF165A2BB8F77CC8B5FE0B30A719B61E7E57EE"
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