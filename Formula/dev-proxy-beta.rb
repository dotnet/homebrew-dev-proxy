class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "e3efcc1d1a82da64627a57c1d3176e78a836aeb2df4272f5099b85468945ff8d"
  else
    proxyArch = "osx-x64"
    proxySha = "152e39f2cd2346679c189e4bea54cd4d822e256b0646e2fa8f23cd329fb05ebc"
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