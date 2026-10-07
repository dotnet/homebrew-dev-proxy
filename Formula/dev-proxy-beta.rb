class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.9"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "fd59915af205fb6c6fbd3034cf54d42bfab5f280c54c3c58a10afcb204559b23"
    else
      proxyArch = "linux-x64"
      proxySha = "37bb98dfbb5012448c595728fa00e229e2d61f7cbae506c5f7dc90c7e7227241"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "e6c4888f306a9a30dc0a0f2d98566de4ba7d2a40c72b35073120cbd71f0acec4"
    else
      proxyArch = "osx-x64"
      proxySha = "7c280901004859f7af3c1d1651f088398a4518cdfa1574e216abfa5ae61de190"
    end
  end

  desc "Dev Proxy #{proxyVersion}"
  homepage "https://aka.ms/devproxy"
  url "https://github.com/dotnet/dev-proxy/releases/download/v#{proxyVersion}/dev-proxy-#{proxyArch}-v#{proxyVersion}.zip"
  sha256 proxySha
  version proxyVersion

  def install
    prefix.install Dir["*"]
    chmod 0555, prefix/"devproxy-beta"
    if OS.mac?
      chmod 0555, prefix/"libe_sqlite3.dylib"
    else
      chmod 0555, prefix/"libe_sqlite3.so"
    end
    bin.install_symlink prefix/"devproxy-beta"
  end

  test do
    assert_match proxyVersion.to_s, shell_output("#{bin}/devproxy-beta --version")
  end

  livecheck do
    url :head
    regex(/^v(.*)$/i)
  end
end