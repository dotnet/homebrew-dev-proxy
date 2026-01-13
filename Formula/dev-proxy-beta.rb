class DevProxyBeta < Formula
  proxyVersion = "2.1.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "12af7f3a0fe23385d323b11581b3f7b54160e43fac39bc508fe49e0787604ac7"
  else
    proxyArch = "osx-x64"
    proxySha = "ebb58fa2017e590f73bb77947369a841ca9f76e238a935a0dd1d37df22e5ebb8"
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