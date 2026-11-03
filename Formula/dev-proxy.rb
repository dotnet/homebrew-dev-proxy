class DevProxy < Formula
  proxyVersion = "4.0.0"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "4db4772f9eab805c5d33971517d02734cebcf0a79a324354a797e610298493d0"
    else
      proxyArch = "linux-x64"
      proxySha = "c4aee02e1f6bcee4587d4d769b96bc8bbe745b699dac73e69e6b71b00d5e83a2"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "b7024cff57708b2f9b8dd8cc4bfec21b67aceef46aa472d72638a1f4f2e03ed7"
    else
      proxyArch = "osx-x64"
      proxySha = "634e2a2999c07fb9e4b04473e32b0327e6bfaab5ed82500d8cca12407b815f14"
    end
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