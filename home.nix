{ pkgs, mac-app-util, username, nvim-config, ... }: {
  imports = [
    mac-app-util.homeManagerModules.default
    ./zsh.nix
    ./git.nix
    ./lf.nix
  ];

  home = {
    inherit username;
    stateVersion = "24.05";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-surround ];
    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };

  home.packages = with pkgs; [
      vimv-rs
      ripgrep
      starship
      zoxide
      neofetch
      alacritty
      fzf
      repgrep
      (nvim-config.packages.${pkgs.system}.mkNeovim {
       pluginsArgs = {
         # bannerPalette = config.system.theme.scheme;
       };
       wrapperArgs = {
         useQmlls = false;
         viAlias = true;
         vimAlias = true;
       };
      })

      # What mac-app-util does for you, is that you can also just
      # install derivations here which have a `/Applications/`
      # directory, and it will be available in Spotlight and in your App
      # Launcher, no further configuration needed:
  ];
}
