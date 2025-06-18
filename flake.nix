{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util = {
	url = "github:hraban/mac-app-util";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    	username = "argus";
    	system = "aarch64-darwin";
	configuration = { pkgs, ... }: {
		# Set Git commit hash for darwin-version.
		system.configurationRevision = self.rev or self.dirtyRev or null;
	};
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Ians-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ ./configuration.nix ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      modules = [
        mac-app-util.homeManagerModules.default
	./home.nix
	({ ... }: {
	  home = {
	    inherit username;
	    homeDirectory = "/Users/${username}";
	  };
	})
      ];
    };

    darwinPackages = self.darwinConfigurations."Ians-MacBook-Pro".pkgs;
  };
}
