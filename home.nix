{ pkgs, mac-app-util, username, ... }: {
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
  
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-surround ];
    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };

  home.packages = with pkgs; [
      ripgrep
      neovim
      starship
      zoxide
      neofetch
      alacritty
      fzf
      repgrep

      # What mac-app-util does for you, is that you can also just
      # install derivations here which have a `/Applications/`
      # directory, and it will be available in Spotlight and in your App
      # Launcher, no further configuration needed:
  ];
}
