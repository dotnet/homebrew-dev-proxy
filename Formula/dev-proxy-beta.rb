class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.10"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "36d334bb08c24f4a2d265afced64ef4911809ce961ebf8e059b3bdc5cabf8b1e"
    else
      proxyArch = "linux-x64"
      proxySha = "2d8bc870550b3b3ce215f8b6c366c24117b74413f764d1ea0be1691bb82ed9b7"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "f545beb00f39577b28bb5bcd9d47e828990b9cd7b2488b987e9fe5f5dc3e368b"
    else
      proxyArch = "osx-x64"
      proxySha = "84a2e1b3c5ecffda17e4f9abce363a783789ba3b1a7c59d585587a647d6ff37d"
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