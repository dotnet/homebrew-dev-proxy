class DevProxy < Formula
  proxyVersion = "3.0.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "145a53fff08c167db93ff601a3584704f0bfb1e721612ce08372ff6b584199d8"
  else
    proxyArch = "osx-x64"
    proxySha = "102fbf98761283cfdf0d4607ac7115c2436e9eb8ee738d15e5e28f4bbd673c70"
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