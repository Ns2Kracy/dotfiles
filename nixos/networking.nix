{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking = {
    hostName = "homelab";

    useDHCP = false;

    networkmanager.enable = true;
  };
}
