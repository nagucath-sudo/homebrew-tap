# bmfv4smm7g-hash Homebrew tap

Patched CLIProxyAPI and network packages. The key-policy plugin ships from its own repository releases.

## Install

The standard `cliproxyapi` formula builds the patched host from the
`bmfv4smm7g-hash/cpa-plugin-key-policy` monorepo's `main` branch. The monorepo has
not published a versioned host release yet, so install the rolling formula with
`--HEAD`.

```sh
brew tap bmfv4smm7g-hash/tap
brew install --HEAD bmfv4smm7g-hash/tap/cliproxyapi
```

The default host configuration is installed at
`$(brew --prefix)/etc/cliproxyapi.conf`. The key-policy plugin is distributed
separately from the [plugin repository releases](https://github.com/bmfv4smm7g-hash/cpa-plugin-key-policy/releases).
Put its platform library in a private plugins directory, set that directory as
`plugins.dir`, and enable `cpa-key-policy`. See the
[plugin example](https://github.com/bmfv4smm7g-hash/cpa-plugin-key-policy/blob/main/config.example.yaml)
for the complete shape.

Start the service with:

```sh
brew services start bmfv4smm7g-hash/tap/cliproxyapi
```

## Update

Fetch the latest patched host with:

```sh
brew update
brew upgrade --fetch-HEAD bmfv4smm7g-hash/tap/cliproxyapi
brew services restart bmfv4smm7g-hash/tap/cliproxyapi
```
