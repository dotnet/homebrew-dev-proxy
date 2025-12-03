class DevProxy < Formula
  proxyVersion = "2.0.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "cccaff506c70a75c0dfc7529ec848e32e32355b8af679a5cf08729fbcfa97907"
  else
    proxyArch = "osx-x64"
    proxySha = "8068d0b4cf3fe699bbea6a71ab2a0e785c0c82f99b6ef7c6474d53da791538fe"
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