{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs/git.nix
  ];

  home.username = "ns2kracy";
  home.homeDirectory = "/home/ns2kracy";

  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    GPG_TTY = "$(tty)";
  };

  home.packages = with pkgs; [
    # terminal
    alacritty
    kitty

    # shell
    fish
    zsh
  ];

  # wayland.windowManager.hyprland.enable = true;

  programs.git = {
    enable = true;
    userName = "Ns2Kracy";
    userEmail = "ns2kracy@gmail.com";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
