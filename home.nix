{ pkgs, ... }: {
  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    # This is where you would install any programs as usual:
    packages = with pkgs; [
      ripgrep
      neovim
      starship

      # What mac-app-util does for you, is that you can also just
      # install derivations here which have a `/Applications/`
      # directory, and it will be available in Spotlight and in your App
      # Launcher, no further configuration needed:
    ];
    stateVersion = "24.05";
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-surround ];
    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };
}
