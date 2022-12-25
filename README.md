# ~ajhalili2006's dotfiles

This is the redesigned dotfiles repo for ~ajhalili2006, because my first repo became a mess so hard
to fix it in, built from scratch and based on <https://git.sr.ht/~ajhalili2006/dotfiles-refreshed-staging>.

## Available Git mirrors

TBD

## Setup

It's easy, although this will be different because `git clone <clone-url-below>` will
scream some errors when attempt to do so after creating a user with their own home directory.

```bash
# go back to your $HOME
cd ~

# init repo, add origin to git.sr.ht repo (have you got your SSH keys?)
git init
git remote add origin git@git.sr.ht:~ajhalili2006/dotfiles-refreshed-staging

# fetch and force checkout
git fetch
git checkout -f main

# logout and login again to refresh your shell env or...
source ~/bin/postinstall-shell-init
```

## Codespaces + Gitpod specifics

Because this cause confusion to most cloud dev environment services, although they'll symlink
stuff when there's no install script, but that is a design flaw to be work around in the future.

## License

TL;DR before we dive in to legalese:

* Everything is licensed under both MIT + MPL 2.0, unless otherwise noted. Most third-party
  code and submodules used here aren't covered by this policy.
* For contributors, either an agreement to the DCO (via `--signoff` flag on commits and when sending
  email patches via `~ajhalili2006/public-inbox@lists.sr.ht`) or through signing the Recap Time Squad
  [Individual CLA](https://go.recaptime.eu.org/cla/sign?type=individual) alongside this specific
  [copyright transfer agreement on this project][cta-ajhalili2006-dotfiles] (requires separate signature
  because the Copyright Assignment clause is not part of our CLAs but mentioned and not included by default in
  most signatures) is mostly enough. Doing both is recommended to avoid further legal headaches down the line.

[cta-ajhalili2006-dotfiles]: https://go.recaptime.eu.org/cla/oss-cta/sign?project=ajhalili2006-dotfiles&require_cla_signature=true
