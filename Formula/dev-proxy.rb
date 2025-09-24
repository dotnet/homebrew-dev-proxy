class DevProxy < Formula
  proxyVersion = "1.2.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "707ce2db113f3b224ee88f6b2ef144378bf29a683c8437262ac82f6f15459e06"
  else
    proxyArch = "osx-x64"
    proxySha = "e59d10d37fd0bfa2ac024bc4904fa2a44627f5fa45f78079ea915da12bf36588"
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