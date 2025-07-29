class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.9"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "a54c0d8f816a6adc7be6f6b9c8c52527be4c254cbb4aac658638227f8c360511"
  else
    proxyArch = "osx-x64"
    proxySha = "125aca73fd66200ed6e1923e58d812f531dff92e23d0b56aeb1c934c5993253e"
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
