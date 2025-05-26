class DevProxyBeta < Formula
  proxyVersion = "0.28.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "0BBA2016277A9E958CFBFF66BF60198FFE9107E5C37894D0CF5C3CEF4A989269"
  else
    proxyArch = "osx-x64"
    proxySha = "6976562F52A3D98C9AD29696DDC6A9FEA496FED361BFE10445C42DFE2061EB7A"
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