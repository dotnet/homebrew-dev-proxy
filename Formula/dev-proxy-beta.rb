class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.14"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "d6777a9674ba16a805460adac4d390c84cf389240856db71b311bc49da104bee"
    else
      proxyArch = "linux-x64"
      proxySha = "499e722a30b1785b027f6f2ba8f2d7ca9c8d60c03b25b6e45fea60e33169729e"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "f9ca9074d5cd8be8d00500486d34b7d8b6f4e514ec7d09c6fdc974e9c803de3c"
    else
      proxyArch = "osx-x64"
      proxySha = "05920e0445c586e0f423cf2b75f59b984e240e20b5ec5afb301a7498fdd98cd8"
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