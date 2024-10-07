{
  description = "Ns2Kracy's Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    vscode-server,
    alejandra,
    agenix,
    ...
  }: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosModules = import ./modules/nixos;

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      homelab = nixpkgs.lib.nixosSystem rec {
        inherit system;
        modules = [
          ./nixos/configuration.nix

          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }

          agenix.nixosModules.default

          vscode-server.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              users.ns2kracy = import ./home-manager/home.nix;
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = inputs;
            };
          }
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
