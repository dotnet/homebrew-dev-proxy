---
name: update-release
description: This skill should be used when the user asks to "update the beta release", "update the stable release", "bump dev-proxy", "bump dev-proxy-beta", "update formula", "get latest release", "get latest pre-release", or needs to update the Homebrew formula with a new Dev Proxy version.
---

# Update Dev Proxy Homebrew Formula

Update the Homebrew formula with a new Dev Proxy release from the GitHub repository.

## Determine Release Type

Based on the user's request, determine which formula to update:

| User mentions | Formula file | Release type |
|---------------|--------------|--------------|
| beta, pre-release | `Formula/dev-proxy-beta.rb` | Pre-release (e.g., `vX.Y.Z-beta.N`) |
| stable, latest, (unspecified) | `Formula/dev-proxy.rb` | Latest stable (e.g., `vX.Y.Z`) |

## Workflow

### Step 1: Check Current Version

Read the appropriate formula file to identify the current `proxyVersion` value.

### Step 2: Find Target Release

Fetch the GitHub releases page:

```
https://github.com/dotnet/dev-proxy/releases
```

- **Beta**: Find the most recent release marked "Pre-release"
- **Stable**: Find the most recent release marked "Latest" (not pre-release)

### Step 3: Calculate SHA256 Checksums

Download each platform's zip file and calculate the SHA256 checksum. Which platforms you need depends on the formula:

| Formula | Platforms |
|---------|-----------|
| Stable (`dev-proxy.rb`) | `osx-x64`, `linux-x64` |
| Beta (`dev-proxy-beta.rb`) | `osx-x64`, `osx-arm64`, `linux-x64`, `linux-arm64` |

Generic command (replace `{ARCH}` with the platform, e.g. `osx-arm64`):
```bash
curl -sL "https://github.com/dotnet/dev-proxy/releases/download/v{VERSION}/dev-proxy-{ARCH}-v{VERSION}.zip" | shasum -a 256
```

Alternatively, read the digests GitHub publishes for the release assets:
```bash
gh release view v{VERSION} -R dotnet/dev-proxy --json assets --jq '.assets[] | .name + " " + .digest'
```

If a release is missing an asset the formula needs (e.g. no `osx-arm64` zip), stop and tell the user. Don't update the formula with a partial set of platforms.

**macOS (osx-x64):**
```bash
curl -sL "https://github.com/dotnet/dev-proxy/releases/download/v{VERSION}/dev-proxy-osx-x64-v{VERSION}.zip" | shasum -a 256
```

**Linux (linux-x64):**
```bash
curl -sL "https://github.com/dotnet/dev-proxy/releases/download/v{VERSION}/dev-proxy-linux-x64-v{VERSION}.zip" | shasum -a 256
```

Replace `{VERSION}` with the version number (e.g., `2.1.0-beta.4` or `2.0.0`).

### Step 4: Update the Formula

Update the formula file with:

1. New `proxyVersion` value (without the `v` prefix)
2. New `proxySha` for every platform in the formula

Stable formula structure (x64 only):

```ruby
class DevProxy < Formula
  proxyVersion = "{VERSION}"
  if OS.linux?
    proxyArch = "linux-x64"
    proxySha = "{LINUX_X64_SHA256}"
  else
    proxyArch = "osx-x64"
    proxySha = "{OSX_X64_SHA256}"
  end
  # ... rest of formula
end
```

Beta formula structure (x64 and arm64):

```ruby
class DevProxyBeta < Formula
  proxyVersion = "{VERSION}"
  if OS.linux?
    if Hardware::CPU.arm?
      proxyArch = "linux-arm64"
      proxySha = "{LINUX_ARM64_SHA256}"
    else
      proxyArch = "linux-x64"
      proxySha = "{LINUX_X64_SHA256}"
    end
  else
    if Hardware::CPU.arm?
      proxyArch = "osx-arm64"
      proxySha = "{OSX_ARM64_SHA256}"
    else
      proxyArch = "osx-x64"
      proxySha = "{OSX_X64_SHA256}"
    end
  end
  # ... rest of formula
end
```

## Key Differences Between Formulas

| Aspect | Stable | Beta |
|--------|--------|------|
| File | `Formula/dev-proxy.rb` | `Formula/dev-proxy-beta.rb` |
| Class | `DevProxy` | `DevProxyBeta` |
| Binary | `devproxy` | `devproxy-beta` |
| Livecheck | `strategy :github_latest` | `regex(/^v(.*)$/i)` |
| Architectures | x64 (macOS, Linux) | x64 + arm64 (macOS, Linux) |

## Important Notes

- The version in the formula should NOT include the `v` prefix
- Each platform has a different SHA256 checksum
- Run the SHA256 commands sequentially (not in parallel) to avoid terminal conflicts
- The download URL includes the `v` prefix in the tag name
