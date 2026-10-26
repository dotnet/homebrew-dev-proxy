class DevProxyBeta < Formula
  proxyVersion = "4.0.0-beta.12"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "f108553956383d0189977109c45840e4e0e622bde3639c10970c48e2112bbd7a"
    else
      proxyArch = "linux-x64"
      proxySha = "0208f693cef1a2a33ba4bda54759ad6c667baedf77dadd2d76f89d499a55cc1b"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "fd55304c5388788889582678df6d53f407932b0dbe44bfbbbe3aab9ec4e61e83"
    else
      proxyArch = "osx-x64"
      proxySha = "9065ff4ea697a65da259756a4de5667de34b60fc6f9817ee40cb7f4ce7fc8edd"
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