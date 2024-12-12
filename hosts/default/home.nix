{ config, pkgs, inputs, stable-pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/sh.nix
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/spicetify.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "philo";
  home.homeDirectory = "/home/philo";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neovim
    bun
    vscode
    deno
    dotnet-sdk_8
    python313Full
    rustup
    nodePackages_latest.pnpm
    signal-desktop
    xdragon
    zoom-us
    toilet
    fortune
    nitch
    neofetch
    httpie
    wlogout
    prismlauncher
    zathura
    mpd
    mpv
    playerctl
    wf-recorder
    wl-clipboard
    gitkraken
    sl
    pokemonsay
    zellij
    du-dust
    skim
    fd
    ripgrep
    jq
    lolcat
    tty-clock
    cmatrix
    nms
    pipes
    pciutils
    tree
    pamixer
    vesktop
    libnotify
    brightnessctl
    light
    catppuccin-kvantum
    jetbrains-toolbox
    bat
    k9s
    btop
    devbox
    lazydocker
    hyprpicker
    gammastep
    gitflow
    lavat
    nautilus
    boxes
    blanket
    ponysay
    nyancat
    zoxide
    pokeget-rs
    tmux
    eza
    yazi
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/philo/etc/profile.d/hm-session-vars.sh
  #
  programs.git = {
    enable = true;
    userName = "Felopater Melika";
    userEmail = "felopatermelika@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = "$$EDITOR $f";
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    "QT_STYLE_OVERRIDE" = "kvantum";
    SHELL = "${pkgs.zsh}/bin/zsh";
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
