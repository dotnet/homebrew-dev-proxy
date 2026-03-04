class DevProxy < Formula
  proxyVersion = "2.2.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ffa6fc3cb828d26416398bef3091e87ea126248f5e3ab18c065e98aa9a81bc79"
  else
    proxyArch = "osx-x64"
    proxySha = "078123a9a7be946ab7b00834b57f39c48ff8a14a2ae5a8e59bf510d6a6efafdd"
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