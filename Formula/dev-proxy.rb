class DevProxy < Formula
  proxyVersion = "0.29.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "f1ced02fc6204fa37c109c6f9f8a2a53a8d5de3b1d547172c6f8488c3d853694"
  else
    proxyArch = "osx-x64"
    proxySha = "907b1209ff55d5458aad275507a95350575e23c12ca33e5296d19062ba0ddb91"
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