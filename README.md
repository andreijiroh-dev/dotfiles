# `@andreijiroh-dev/dotfiles@nixos` - @ajhalili2006's dotfiles under nixos + nixpkgs!

Yup, I'm starting a fresh for my dotfiles for 2025 and beyond, now with
[nixpkgs](https://nixos.org) and [home-manager](https://nix-community.github.io/home-manager).
(Don't worry, I'll be maintaining the yadm-era setup for non-Nix setups seperately)

## Usage

### Using my Nixpkgs config

Make sure Git is installed in your NixOS/nixpkgs setup (via `/etc/nixos/configuration.nix` or
the usual `nix-env -iA nixpkgs.gitFull` or `nix profile install nixpkgs#gitFull` if using
Flakes) for the setup to work.

```bash
cd ~
git init
git remote add origin https://mau.dev/andreijiroh-dev/dotfiles
# TODO: add the rest
```

## Directory + File Map

### Essientials

* [`.config/nixos`](./.config/nixos/) - my NixOS configuration as a flake, including system tools,
usually in sync
* [`.config/home-manager`](./.config/home-manager/) - Home-manager configs, mostly CLI and desktop apps go here
* [`bin`](./bin) - Shell scripts! (because Nix looks like Haskell to me)
