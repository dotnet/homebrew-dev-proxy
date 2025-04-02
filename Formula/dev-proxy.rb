class DevProxy < Formula
  proxyVersion = "0.26.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "6D8D847C2E37FE8AC45707CC41CABC552FCF04ED097DE556F0DAF59A0C7E99D1"
  else
    proxyArch = "osx-x64"
    proxySha = "3499F9E41EF737C26231FE8904A089D50E2A3A88EFEE4E31613823B4FDA38EDC"
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