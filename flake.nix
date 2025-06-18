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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
  let
    	username = "argus";
    	system = "aarch64-darwin";
	configuration = { pkgs, ... }: {
	  users = {
	    users.${username} = {
	      home = "/Users/${username}";
	      name = "${username}";
	    };
	  };
	  nixpkgs.hostPlatform = system;
	  # Set Git commit hash for darwin-version.
	  system.configurationRevision = self.rev or self.dirtyRev or null;
	};
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."Ians-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
	configuration
	./configuration.nix
        mac-app-util.darwinModules.default
	home-manager.darwinModules.home-manager
	{
		nixpkgs = {
			config = { allowUnfree = true; };
		};
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.${username} = import ./home.nix;
		home-manager.extraSpecialArgs = { inherit mac-app-util; inherit username; };
	}
      ];
    };

    darwinPackages = self.darwinConfigurations."Ians-MacBook-Pro".pkgs;
  };
}
