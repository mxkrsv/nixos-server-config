{ ... }: {
  imports = [
    ../common

    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  boot.cleanTmpDir = true;

  zramSwap.enable = true;
}
