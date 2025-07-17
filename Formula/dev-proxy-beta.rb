class DevProxyBeta < Formula
  proxyVersion = "1.0.0-beta.8"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ded6095d45459e291c646137c6288958a279c98c3f90fd74e68405f2ae7e9071"
  else
    proxyArch = "osx-x64"
    proxySha = "b1501098d633ce84ae228b181450bc453ac27c52a7fe38b505117c8e86b01267"
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