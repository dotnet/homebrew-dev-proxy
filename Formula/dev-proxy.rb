class DevProxy < Formula
  proxyVersion = "0.28.0"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "E6F725A1B78A99F339A12DFCA8290AF5559396398EBBEBC275FFA40E32AEDE9B"
  else
    proxyArch = "osx-x64"
    proxySha = "988CB1D1EE82921A27E99A978CFB49554CA0726A0A3C4D774A7CF9567B85EDFF"
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