# `@andreijiroh-dev/dotfiles@nixos` - @ajhalili2006's dotfiles under nixos + nixpkgs!

Yup, I'm starting a fresh for my dotfiles for 2025 and beyond, now with
[nixpkgs](https://nixos.org) and [home-manager](https://nix-community.github.io/home-manager).
(Don't worry, I'll be maintaining the yadm-era setup for non-Nix setups seperately
as seperate branches for prosperity.)

## Usage

### Using my Nixpkgs config

Make sure Git is installed in your NixOS/nixpkgs setup (via `/etc/nixos/configuration.nix` or
the usual `nix-env -iA nixpkgs.gitFull` or `nix profile install nixpkgs#gitFull` if using
Flakes) for the setup to work.

```bash
cd ~
git init
git remote add origin https://mau.dev/andreijiroh-dev/dotfiles
git checkout -f main
```

## Directory + File Map

### Essientials

* [`.config/nixos`](./.config/nixos/) - my NixOS configuration as a flake, including system tools,
usually in sync
* [`.config/home-manager`](./.config/home-manager/) - Home-manager configs, mostly CLI and desktop apps go here
* [`bin`](./bin) - Shell scripts! (because Nix looks like Haskell to me)

## Related repositories

* [`@andreijiroh-dev/nixops-config`][nixops-config] - my NixOS + home-manager configs, with flake support (TODO: turn `.config/nixos` into submodule)
* [`@andreijiroh-dev/infraops`][infraops] - the homelab config in pure Docker Compose insanity, alongside DNS records YAML files for octoDNS
* [`@recaptime-dev/infra`][rtdev-infra] - @recaptime-dev's infra configurations and home for our Infra Issue Tracker
* [`@recaptime-dev/infra-internals`][rtdev-infra-internals] - @recaptime-dev's infra configs for Portainer (the public repo version only have `stack.env` files removed via `git-filter-repo`)

[nixops-config]: https://github.com/andreijiroh-dev/nixops-config
[infraops]: https://github.com/andreijiroh-dev/infraops
[rtdev-infra]: https://github.com/recaptime-dev/infra
[rtdev-infra-internals]: https://github.com/internal-recaptime-dev/infra-internals-public
