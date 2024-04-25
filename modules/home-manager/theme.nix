{ config, pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Blue";
    };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
  };

  gtk = {
    enable = true;

    gtk2 = {
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };

    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };
}
