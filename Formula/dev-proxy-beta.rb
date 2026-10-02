class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.6"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "4ea9693cbf78e432a28dfa8284ba193bcf8c03842db11cbbdfad078f1ecc2636"
  else
    proxyArch = "osx-x64"
    proxySha = "b7670ed5d3d1951733073f9445b7c695a0d0af876444576be89e071d978a9219"
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