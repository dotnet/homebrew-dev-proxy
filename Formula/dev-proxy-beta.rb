class DevProxyBeta < Formula
  proxyVersion = "0.26.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "8F7BE062890A902DD414768AFAFEC7C385AB998A24F52CFD2A30D9E8FB6CAA19"
  else
    proxyArch = "osx-x64"
    proxySha = "FA6D018161D8C4CE4387D3DA6E85039A41B73FC094A817763DD7860B0BDEB418"
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