class DevProxyBeta < Formula
  proxyVersion = "1.2.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "d6fd14f11e8014fa553e0a977334f6f387bdd740a7bc5e264e69adef4c9fdb01"
  else
    proxyArch = "osx-x64"
    proxySha = "baa4f3aba7cc3d868792f21ab478667409fcdff9afd26226dcdcea23db337b41"
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