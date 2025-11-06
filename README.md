pulsar-hs
=========

> [!WARNING]
> This fork exists to explore if this library is feasible to be used at Wire. We
> may or may not maintain it later. This fork is owned by the backend team at
> Wire (especially @supersven). Its state should change in the next few months.

Provides libraries to deal with [Apache Pulsar](https://pulsar.apache.org/en/):

 * [`pulsar-admin`](pulsar-admin) to deal with the Admin REST API
 * [`pulsar-client-hs`](pulsar-client-hs) to deal with the server

## Building with Nix Flakes

This project uses Nix flakes for reproducible builds and development environments.

### Build all packages

```bash
nix build
```

### Build specific packages

```bash
nix build .#pulsar-client-hs
nix build .#pulsar-admin
nix build .#pulsar-client-cpp
```

### Development shell

Enter a development environment with all necessary tools (GHC 9.8, cabal, haskell-language-server, etc.):

```bash
nix develop
```

Or use direnv for automatic environment loading:

```bash
direnv allow
```
