# `@andreijiroh-dev/dotfiles@nixos` - @ajhalili2006's dotfiles under nixos + nixpkgs!

Yup, I'm starting a fresh for my dotfiles for 2025 and beyond, now with
[nixpkgs](https://nixos.org) and [home-manager](https://nix-community.github.io/home-manager).
(Don't worry, I'll be maintaining the yadm-era setup for non-Nix setups seperately
as seperate branches for prosperity.)

## Usage

### Plain dotfiles

Make sure Git is installed in your non NixOS/nixpkgs setup for the setup to work.

```bash
cd ~
git init
git remote add origin https://mau.dev/andreijiroh-dev/dotfiles
git checkout -f main
```

If you prefer to cook up with yadm:

```bash
yadm clone https://github.com/andreijiroh-dev/dotfiles
ln -s ./.local/share/yadm/TBD ./.git # so that we can normally use git here
```

### Using nix flakes + home-manager

```bash
# A quick home-manager switch should do the trick
nix run home-manager/master -- switch --flake github:andreijiroh-dev/nixops-config

# otherwise a quick copy paste configs should fix 'em if you use a different username
# (not different home directory yet!)
```

#### Updating `authorized_keys` with Nix

1. Update [`shared/ssh-keys.nix`][ssh-keys] and `users.users.<gildedguy|ajhalili2006>.openssh.authorizedKeys.keys`
2. Run `nixos-rebuild switch` to regenerate `/etc/ssh/authorized_keys.d/<gildedguy|ajhalili2006>`.
3. Copy that file back to `.ssh/authorized_keys`. Commit changes and push.
4. On the affected machines, just `git pull` away.

### Using 1Password SSH Agent integration

> [!WARNING]
> 1Password Desktop app must be installed and enabled `Use SSH Agent` in
> **Settings** -> **Developer** -> **SSH Agent** after signing in.

Note that this should work on most desktop apps, although if you're in Nest (and friends
with RDP access), connect to there first and authenicate. You may need to adjust security
settings in the desktop app to ensure nothing go wrong.

## Directory + File Map

### Essientials

* [`.config/nixos`](./.config/nixos/) - my NixOS configuration as a flake, including system tools,
usually in sync (TODO: Swap into Git module of <https://github.com/andreijiroh-dev/nixops-config> soon)
* [`.config/home-manager`](./.config/home-manager/) - Home-manager configs, mostly CLI and desktop apps go here
* [`bin`](./bin) - Shell scripts! (because Nix looks like Haskell to me)

## Related repositories

* [`@andreijiroh-dev/nixops-config`][nixops-config] - my NixOS + home-manager configs, with flake support (TODO: turn `.config/nixos` into submodule)
* [`@andreijiroh-dev/infraops`][infraops] - the homelab config in pure Docker Compose insanity, alongside DNS records YAML files for octoDNS
* [`@recaptime-dev/infra`][rtdev-infra] - @recaptime-dev's infra configurations and home for our Infra Issue Tracker
* [`@recaptime-dev/infra-internals`][rtdev-infra-internals] - @recaptime-dev's infra configs for Portainer (the public repo version only have `stack.env` files removed via `git-filter-repo`)

## License

MPL-2.0

[nixops-config]: https://github.com/andreijiroh-dev/nixops-config
[infraops]: https://github.com/andreijiroh-dev/infraops
[rtdev-infra]: https://github.com/recaptime-dev/infra
[rtdev-infra-internals]: https://github.com/internal-recaptime-dev/infra-internals-public
