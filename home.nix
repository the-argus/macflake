{ config, pkgs, ... }:

{
  home.username = "your-username";
  home.homeDirectory = "/Users/your-username";

  home.stateVersion = "23.11"; # Adjust to your current Nixpkgs/Home Manager version

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.brew # Needed to run Homebrew-installed binaries
  ];

  # Install yabai using homebrew
  homebrew = {
    enable = true;
    brews = [
      "koekeishiya/formulae/yabai"
    ];
    taps = [
      "koekeishiya/formulae"
    ];
  };

  # Optionally add yabai config file
  home.file.".yabairc".text = ''
    yabai -m config layout bsp
    yabai -m config window_gap 10
    yabai -m config top_padding 10
    yabai -m config bottom_padding 10
    yabai -m config left_padding 10
    yabai -m config right_padding 10
  '';
}

