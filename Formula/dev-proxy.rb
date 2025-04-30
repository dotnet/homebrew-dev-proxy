class DevProxy < Formula
  proxyVersion = "0.27.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "5C9BB0ED3108006BDC9147266F258D4B44951EB638C4EC6444579674CCF7C00C"
  else
    proxyArch = "osx-x64"
    proxySha = "9FE497880B4ED2BA1740B1F70F84DDAEBEE6BFD0FBD391B190F80FE14916305B"
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