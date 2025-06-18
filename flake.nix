{
  description = "macos home manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin"; # or "x86_64-darwin" for Intel Macs
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeConfigurations.my-user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = { inherit system; };
      };
    };
}

