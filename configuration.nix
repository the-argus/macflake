{ pkgs, ... }: {
	ids.gids.nixbld = 350;

	services.yabai = {
		enable = true;
		config = {
			focus_follows_mouse = "autoraise";
			mouse_follows_focus = "off";
			window_placement    = "second_child";
			window_opacity      = "off";
			top_padding         = 36;
			bottom_padding      = 10;
			left_padding        = 10;
			right_padding       = 10;
			window_gap          = 10;
        	};
	};

	environment.systemPackages = with pkgs; [
		vim
		git
		ripgrep
		fd
		tldr
		home-manager
	];

	# Auto upgrade nix package 
	# nix.package = pkgs.nix;

	nix.settings.experimental-features = "nix-command flakes";

	# Create /etc/zshrc that loads the nix-darwin environment.
	programs.zsh.enable = true;  # default shell on catalina

	system.stateVersion = 4;
	nixpkgs.hostPlatform = "aarch64-darwin";
}
