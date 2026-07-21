class DevProxy < Formula
  proxyVersion = "3.2.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "4d3aba145cb7d1a97326f2f80bb8b64ca14b4b6f164b728ab5612d1800634f62"
  else
    proxyArch = "osx-x64"
    proxySha = "35fe9558f49980bff80d4e8c50cee755a402cf6a8fa5b8a8c053a1f762509401"
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