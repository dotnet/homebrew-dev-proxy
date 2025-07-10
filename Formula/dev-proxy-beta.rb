class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "9d9a8c344792b0540ce5f907424ee13aa378c6565ec73db4ada562a7efca105c"
  else
    proxyArch = "osx-x64"
    proxySha = "b4286be2efdb1e5f6d5d2935902091997a38ac80ffaffa391d9ea2c34c64ed31"
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