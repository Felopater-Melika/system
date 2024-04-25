{ config, pkgs, lib, ... }:

let tokyo-night-sddm = import ./tokyo-night-sddm.nix { inherit pkgs; };
in {
  options = {
    services.displayManager.tokyo-night-sddm.enable =
      lib.mkEnableOption "Enable Tokyo Night theme for SDDM";
  };

  config = lib.mkIf config.services.displayManager.tokyo-night-sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "tokyo-night-sddm";
    };

    environment.systemPackages = with pkgs; [ tokyo-night-sddm ];
  };
}

