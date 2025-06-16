class DevProxyBeta < Formula
  proxyVersion = "0.29.0-beta.2"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "A8124149F42C18F4E3E91EE06645E79E66041F039CA153CF7C501B21B3045612"
  else
    proxyArch = "osx-x64"
    proxySha = "5B4AAE0A46A5AA997283189EC41361CB3E9D7FA0CD8B66A2D13387AB0B913A19"
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