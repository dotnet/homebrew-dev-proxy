class DevProxyBeta < Formula
  proxyVersion = "0.28.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "E91913F3A72DF003643AB809A82C5B8FB5F66AED6200DF8A22F722B299B965B0"
  else
    proxyArch = "osx-x64"
    proxySha = "523E36ABDDA946078796370786E2BF702DE318D4DFC3959D8C447B40706AF961"
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