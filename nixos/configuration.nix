{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include the networking configuration.
    ./networking.nix

    # Include the openssh configuration.
    ./services/openssh.nix
  ];

  # Enable OpenGL
  hardware = {
    opengl = {
      enable = true;
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        sync.enable = true;
        amdgpuBusId = "PCI:54:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Power management
  powerManagement.enable = false;

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };

  time = {
    timeZone = "Asia/Shanghai";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ns2kracy = {
    isNormalUser = true;
    description = "ns2kracy";
    openssh = {
      authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMiTv3lrg8AFtjqBkcgNe4Czm3rBjOi0QhrHrrg5FGX ns2kracy@gmail.com"
      ];
    };
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nil
    gnupg
  ];

  # Enable the Virtualisation to use Docker.
  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon = {
        settings = {
          "registry-mirrors" = [
            "https://dockerproxy.cn"
          ];
        };
      };
    };
  };

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  ###  List services that you want to enable:
  services = {
    # Configure the display manager.
    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
      };
    };

    xserver = {
      # Load nvidia driver for Xorg and Wayland
      videoDrivers = ["nvidia"];
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable the Caddy web server.
    caddy = {
      enable = true;
    };

    # Enable the VSCode Server
    vscode-server.enable = true;
  };

  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
