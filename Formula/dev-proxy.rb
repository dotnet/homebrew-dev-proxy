class DevProxy < Formula
  proxyVersion = "0.29.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "9a7c24057c9746b2bfdb2f3cc68066ed3dd73411638a5e71c8538b977cea1717"
  else
    proxyArch = "osx-x64"
    proxySha = "33d5e30b7951697a81c3c6daebcbdfd609978b065fecbcf70f617c43295e54eb"
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