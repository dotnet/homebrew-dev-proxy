class DevProxy < Formula
  proxyVersion = "0.25.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "27028D1C1D54C590C346F91E9389593BDE6898C75C333EC8E5BF1D38429A90B1"
  else
    proxyArch = "osx-x64"
    proxySha = "B61B6260AEFCA69C0F97688A6E20FE8424D91D2DA5C3B1D05CE6F413B8ADBD9D"
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