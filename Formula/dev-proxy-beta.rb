class DevProxyBeta < Formula
  proxyVersion = "2.3.0-beta.1"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "701e08bfb519c9b60f2fa3907ae6f18b91a90b9eb11b06c9c84bffb72fcfe734"
  else
    proxyArch = "osx-x64"
    proxySha = "14b821bfe0d6dfc83aab307611a2774262db66edcb9011c844e3029d0956af62"
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