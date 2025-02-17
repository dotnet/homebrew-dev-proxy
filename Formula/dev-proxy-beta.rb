class DevProxyBeta < Formula
  proxyVersion = "0.25.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "DE0EF0EE5C34B69C04E77BC0A9848E5B811A00CA5D0CF07C06F37C1F88E43E97"
  else
    proxyArch = "osx-x64"
    proxySha = "05A8BDB4102395B0DA03034E29BF4A1C67800AD1232DD7901E868CC32EECFE6A"
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