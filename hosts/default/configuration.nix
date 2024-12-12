# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, stable-pkgs, ... }:
let
  # tokyo-night-sddm =
    #pkgs.libsForQt5.callPackage ./../../modules/nixos/tokyo-night-sddm.nix { };
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # ./../../modules/nixos/sddm.nix
    ./../../modules/nixos/font.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";
  services.ntp.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec = 10s
    '';
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.package =
    inputs.hyprland.packages."${pkgs.system}".hyprland;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.theme = "tokyo-night-sddm";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.philo = {
    shell = "${pkgs.zsh}/bin/zsh";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "bluetooth"
      "networkmanager"
      "docker"
      "audio"
      "libvirtd"
      "kvm"
      "disk"
      "input"
      "media"
      "plugdev"
      "lxd"
      "adbusers"
      "users"
      "video"
    ];
    packages = with pkgs; [ ];
  };

  virtualisation.docker.enable = true;
  programs.dconf.enable = true;
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    # ELECTRON_ENABLE_STACK_DUMPING = "true";
    # ELECTRON_NO_ATTACH_CONSOLE = "true";
    # WARP_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
  };

  security.pam.services.swaylock = { };
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "philo" = import ./home.nix; };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    nixfmt-classic
    wget
    firefox
    gh
    kitty
    gcc
    git
    logiops
    libnotify
    blueman
    bluez
    unzip
    # stable-pkgs.prismlauncher-qt5
    # tokyo-night-sddm
  ];

  systemd.oomd.enableRootSlice = true;
  systemd.oomd.enableSystemSlice = true;
  systemd.oomd.enableUserSlices = true;

  zramSwap = {
    enable = true; # Enable zram swap

    # Total amount of zram memory. A percentage of total RAM is recommended.
    # For heavy workloads, considering your 16GB RAM, setting zram to use up to 50% of RAM.
    # Adjust based on your needs and experimentation.
    memoryPercent = 50;

    # Set the maximum amount of zram memory. This is a safety cap in absolute terms,
    # which is useful if you want to ensure zram never exceeds a certain size.
    # This is optional and can be adjusted or omitted based on preference.
    # memoryMax = "8G"; # Uncomment and adjust as necessary

    # Set the compression algorithm. Lz4 is fast with reasonable compression.
    # You may experiment with 'zstd' for potentially better compression at the cost of CPU.
    algorithm = "zstd";

    # Adjust the priority of the zram swap relative to other swap devices.
    # Higher numbers indicate higher priority. Default is usually sufficient.
    priority = 100;

    # This option is not directly part of NixOS's zram configuration but would be
    # relevant if configuring additional swap devices manually or using systemd services.
    # swapDevices = [ ... ];

    # For systems with a known fast storage device for swap, like an NVMe drive,
    # setting a writeback device can offload swapped out data from zram under pressure.
    # This is an advanced option and typically not necessary for most users.
    # writebackDevice = "/dev/nvme0n1"; # Example, adjust as per your system
  };

  swapDevices = [{
    device = "/swapfile";
    size = 8192; # Size in MB for an 8GB swap file
  }];

  systemd.services.logiops = {
    description = "An unofficial userspace driver for HID++ Logitech devices";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
    };
  };

  programs.nix-ld.enable = true;
  networking.firewall.enable = true;

  environment.etc."logid.cfg".text = ''
       // Logiops (Linux driver) configuration for Logitech MX Master 3.
    // Includes gestures, smartshift, DPI.
    // Tested on logid v0.2.3 - GNOME 3.38.4 on Zorin OS 16 Pro
    // What's working:
    //   1. Window snapping using Gesture button (Thumb)
    //   2. Forward Back Buttons
    //   3. Top button (Ratchet-Free wheel)
    // What's not working:
    //   1. Thumb scroll (H-scroll)
    //   2. Scroll button

    // File location: /etc/logid.cfg

    devices: ({
      name: "MX Master 3S";

      smartshift: {
        on: true;
        threshold: 15;
      };

     hiresscroll: {
       hires: true;
       invert: false;
       target: false;
     };

      dpi: 1000; // max=4000

      buttons: (
        // Forward button for Copy
        {
          cid: 0x53;
          action = {
            type: "Keypress";
            keys: [ "KEY_LEFTCTRL", "KEY_C" ];
          };
        },
        // Back button for Paste
        {
          cid: 0x56;
          action = {
            type: "Keypress";
            keys: [ "KEY_LEFTCTRL", "KEY_V" ];
          };
        },
        // Gesture button (hold and move)
        {
          cid: 0xc3;
          action = {
            type: "Gestures";
            gestures: (
              {
                direction: "None";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_S" ]; // Windows + S
                }
              },
    	 {
                direction: "Up";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTCTRL", "KEY_A" ]; // Ctrl+A to select all
                }
              },
              {
                direction: "Down";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_V" ]; // Windows+V
                }
              },
              {
                direction: "Right";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_X" ]; // Windows+X
                }
              },
              {
                direction: "Left";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_I" ]; // Windows+I
                }
              },
            );
          };
        },

        // Top button
        {
          cid: 0xc4;
          action = {
            type: "Gestures";
            gestures: (
              {
                direction: "None";
                mode: "OnRelease";
                action = {
                  type: "ToggleSmartShift";
                }
              },

              {
                direction: "Up";
                mode: "OnRelease";
                action = {
                  type: "ChangeDPI";
                  inc: 1000,
                }
              },

              {
                direction: "Down";
                mode: "OnRelease";
                action = {
                  type: "ChangeDPI";
                  inc: -1000,
                }
              }
            );
          };
        }
      );
    });
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
