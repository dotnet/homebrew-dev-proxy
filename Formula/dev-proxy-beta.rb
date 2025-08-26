class DevProxyBeta < Formula
  proxyVersion = "1.1.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "0718ee973e740e2a18a9e8718f7f1010aaf4be5da30d3fa03fe8712b7d811a58"
  else
    proxyArch = "osx-x64"
    proxySha = "101acd21e682f82b37c19e5896090ebfd3aacc497582b51b0333646046ce7178"
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