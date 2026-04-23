class DevProxy < Formula
  proxyVersion = "2.3.4"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "ea4bcbf5393a2ff135ecd41359e49f416243f4100c6cc9ebae12853f6a7f95d0"
  else
    proxyArch = "osx-x64"
    proxySha = "55777c68f5f9b924f64a147f36cb9ae7c742d92dada6e481d659cd20a0688470"
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