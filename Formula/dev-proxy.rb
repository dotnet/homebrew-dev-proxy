class DevProxy < Formula
  proxyVersion = "2.1.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "21cf002dd8b5c5ba254d75e42d7bdd3e76257f63d28894bda6840929a015897a"
  else
    proxyArch = "osx-x64"
    proxySha = "9183269a65306ca4eae76f2f7b3e69c4738fbee6d86a2e3b306a14a20ab5784a"
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