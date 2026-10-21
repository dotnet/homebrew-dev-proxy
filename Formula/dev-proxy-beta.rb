class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.11"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "2d5b2fe6e03dabf06252df188a3ea57126af9378bbdbe45d90b2edc249996926"
    else
      proxyArch = "linux-x64"
      proxySha = "3c722d455243220868c5f7d56658468396dee239fe692113043f1eb1eb93dc2d"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "535386eabd13eab0e27ce188df2c0c00289ed6b78dcb3a7468219449e4ee0c0a"
    else
      proxyArch = "osx-x64"
      proxySha = "3ff1ce9a8529e76d25e27d08816d09d01a5db37cd3f45505170632427ab1bf7e"
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