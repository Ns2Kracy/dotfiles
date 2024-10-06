{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:

{
  home.username = "ns2kracy";
  home.homeDirectory = "/home/ns2kracy";

  home.enableNixpkgsReleaseCheck = false;

  home.packages = with pkgs; [ ];

  programs.git = {
    enable = true;
    userName = "Ns2Kracy";
    userEmail = "ns2kracy@gmail.com";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
