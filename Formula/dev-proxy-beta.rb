class DevProxyBeta < Formula
  proxyVersion = "0.29.0-beta.3"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "32c69b1a6e1163fa60bd50d485bc48d3edb3287e9f3ab01f26d7426910d8fefe"
  else
    proxyArch = "osx-x64"
    proxySha = "ec2be6a0a0e9f4a93068df4c7a94d921348f223d7eaa4ec2c4760e2327f290a5"
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