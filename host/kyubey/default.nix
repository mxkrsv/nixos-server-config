{ ... }: {
  imports = [
    ../common
    ../common/baremetal

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
}
