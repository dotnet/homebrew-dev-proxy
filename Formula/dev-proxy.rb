class DevProxy < Formula
  proxyVersion = "2.3.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "a30b91970899c4341a4e3ac3cd9eed4c9010320e3a455bf929cbbb6e2071aea1"
  else
    proxyArch = "osx-x64"
    proxySha = "9aef3ebc8c5a6dcf0b0ea350648012eecc23203583945ceb7a2b2458d14b1cb3"
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