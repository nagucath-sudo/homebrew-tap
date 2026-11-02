# wignerStan Homebrew tap

Patched CLIProxyAPI and network packages. The key-policy plugin ships from its own repository releases.

## Install

The standard `cliproxyapi` formula builds the patched host from the
`wignerStan/cpa-plugin-key-policy` monorepo's `main` branch. The monorepo has
not published a versioned host release yet, so install the rolling formula with
`--HEAD`.

```sh
brew tap wignerStan/tap
brew install --HEAD wignerStan/tap/cliproxyapi
```

The default host configuration is installed at
`$(brew --prefix)/etc/cliproxyapi.conf`. The key-policy plugin is distributed
separately from the [plugin repository releases](https://github.com/wignerStan/cpa-plugin-key-policy/releases).
Put its platform library in a private plugins directory, set that directory as
`plugins.dir`, and enable `cpa-key-policy`. See the
[plugin example](https://github.com/wignerStan/cpa-plugin-key-policy/blob/main/config.example.yaml)
for the complete shape.

Start the service with:

```sh
brew services start wignerStan/tap/cliproxyapi
```

## Update

Fetch the latest patched host with:

```sh
brew update
brew upgrade --fetch-HEAD wignerStan/tap/cliproxyapi
brew services restart wignerStan/tap/cliproxyapi
```
