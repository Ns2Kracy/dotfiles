{ config, pkgs, pkgs-stable, inputs, ... }:

{
  home.username = "ns2kracy";
  home.homeDirectory = "/home/ns2kracy";

  home.packages = with pkgs;[];

  # git 相关配置
  programs.git = {
    enable = true;
    userName = "Ns2Kracy";
    userEmail = "ns2kracy@gmail.com";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
