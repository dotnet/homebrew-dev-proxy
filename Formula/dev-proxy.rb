class DevProxy < Formula
  proxyVersion = "1.3.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "45476f1a5e4b43f8cd2f69a0d7cb0c2be20495857bbec37df3793b377bf41987"
  else
    proxyArch = "osx-x64"
    proxySha = "f8ca4d5cffaca361584911901e8a0378283cb9ad4bae0736945f05d9f7546046"
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/dotnet/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy --version")
  end

  livecheck do
    url :stable
    strategy :github_latest
  end
end