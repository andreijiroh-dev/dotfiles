# ~ajhalili2006's dotfiles

This is the redesigned dotfiles repo for ~ajhalili2006, because my first repo became a mess so hard
to fix it in, built from scratch and based on <https://drewdevault.com/2019/12/30/dotfiles.html>.

## Quick deploy

```bash
# Working on it soon.
curl -fsSL https://scripts.andreijiroh.xyz/dotfiles/setup.sh | bash -
```

## Available Git mirrors

This project is hosted on [hosted instance of sourcehut git](https://git.sr.ht) at the
[`~ajhalili2006/dotfiles`][git.sr.ht] Git repository, alongside the following
Git mirrors:

* mau.dev: <https://mau.dev/andreijiroh.dev/dotfiles> (technically canonical due
to how mirroring work and usualy pushed there first)
* GitHub: <https://github.com/ajhalili2006/dotfiles>
* Launchpad.net: <https://git.launchpad.net/ajhalili2006-dotfiles>
* ~vern git: <https://git.vern.cc/ajhalili2006/dotfiles-modern>
* tildegit: <https://tildegit.org/ajhalili2006/dotfiles-modern>

[git.sr.ht]: https://git.sr.ht/~ajhalili2006/dotfiles

## Setup

### With yadm

```shell
# on a Alpine Linux sandbox VM (or chroot)
apk add yadm git gnupg

yadm clone https://mau.dev/andreijiroh.dev/dotfiles
yadm restore --staged $HOME
yadm checkout -- $HOME

# run the bootstrap script
yadm bootstrap
```

### Without yadm

It's easy, although this will be different because `git clone <clone-url-above>` will
scream some errors when attempt to do so after creating a user with their own home directory.

```bash
# go back to your $HOME
cd ~

# init repo, add origin to git.sr.ht repo (have you got your SSH keys?)
git init
git remote add origin git@git.sr.ht:~ajhalili2006/dotfiles-modern

# another route here is cloning the repo before the user creation take place
# so you can skip the "fetch and force checkout hellscape"
git clone git@git.sr.ht:~ajhalili2006/dotfiles-modern /home/ajhalili2006
# ...create user "ajhalili2006" here
chown ajhalili2006:ajhalili2006 -Rv /home/ajhalili2006

# fetch and force checkout, RIP any unstashed hellscapes
git fetch
git checkout -f main

# logout and login again to refresh your shell env
```

## Codespaces + Gitpod specifics

Because this cause confusion to most cloud dev environment services, although they'll symlink
stuff when there's no install script, but that is a design flaw to be work around in the future.

## License

TL;DR before we dive in to legalese:

* Everything is licensed under both MIT + MPL 2.0, unless otherwise noted. Most third-party
  code and submodules used here aren't covered by this policy.
* Open source !== open contribution. Since this is just a personal project, expect your contributions to be
  either rewritten or declined.
* For contributors who wish to send patches, either an agreement to the DCO (via `--signoff` flag on commits and
  when sending email patches via `~ajhalili2006/public-inbox@lists.sr.ht`) or through signing the project-specific
  [Individual CLA][sign-link] alongside this specific [copyright transfer agreement on this project][cta-ajhalili2006-dotfiles]
  (requires separate signature, uses FSFe's FLA 2.0) is mostly enough. Doing both is recommended to avoid further legal headaches down the line, atlhough ~sircmpwn recommends
  against signing the CLA, especially due to legalities around copyright assignments in OSS.

[cta-ajhalili2006-dotfiles]: https://cla.recaptime.eu.org/sign/copyright-assignment?project=ajhalili2006-dotfiles&requireClaSignature=true&claType=FLA-FSFE
[sign-link]: https://cla.recaptime.eu.org/sign/per-project-basis?type=individual&project=ajhalili2006-dotfiles&claType=FLA-FSFE
