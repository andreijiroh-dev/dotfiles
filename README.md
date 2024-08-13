# ~ajhalili2006's dotfiles in Termux

> [!note]
> For the main documentation itself, [see the README on the main branch](https://mau.dev/andreijiroh-dev/dotfiles/blob/main/README.md).

My dotfiles, customized for [Termux](https://termux.dev) and friends (context: Android OS).
Based off <https://drewdevault.com/2019/12/30/dotfiles.html>, but uses `yadm` to manage home directory's version control
as if I do prefixing commands with `git -C ~`.

## Quick deploy / Speedrun

```bash
# The script should detect that we're inside Termux, although we can force it
# with the --termux flag.
curl -fsSL https://scripts.andreijiroh.xyz/dotfiles/setup.sh | bash -s --termux
```

Alternatively:

```bash
pkg install git git-lfs yadm gh glab-cli openssh
git init -m main
git remote add lab https://mau.dev/andreijiroh-dev/dotfiles
git fetch --all
git switch lab/termux
yadm bootstrap
```

## Differences from main branch

* Termux app customizations are stored in [`.termux/termux.properties`](.termux/termux.properties) file.
* Heavy usage of `safe.storage` in Git user config for cross-app storage access, especially for Git repos via Obsidian.
* Shell shebang patches via `termux-fix-shebang`
* Some workarounds for using `keychain`
