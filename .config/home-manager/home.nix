{ config, ... }:

{
  imports = [
    ../nixos/shared/home-manager/main.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage. Also don't ask how we got here on the roleplaying part on the main
  # nixpkgs branch of the dotfiles.
  # TODO: Update the username and homeDirectory when switching between host-specific
  # branches.
  home = {
    username = "gildedguy";
    homeDirectory = "/home/gildedguy";
  };
}