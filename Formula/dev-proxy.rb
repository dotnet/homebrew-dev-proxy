class DevProxy < Formula
  proxyVersion = "0.29.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "9eba89eaa9854508da24642d2438ec5bcb59d64cdc254a490392d8581dc47bad"
  else
    proxyArch = "osx-x64"
    proxySha = "ae50a5f66c30dae0e1971fc9fa4ff5f46c5f85a1a16cc924e84a01696c1e4df2"
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