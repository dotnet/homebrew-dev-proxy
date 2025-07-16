class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.7"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ea12d6808551947534b982e23b0655172dcbb5475214b267a1164a2015fdeb3c"
  else
    proxyArch = "osx-x64"
    proxySha = "7941ebaf2ebb73b022a03be3ae6262c01572a25024f7b36db7887b210230ef93"
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