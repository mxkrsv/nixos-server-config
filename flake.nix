{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    disko.url = "github:nix-community/disko";
  };

  outputs = { nixpkgs, disko, ... }@inputs: {
    nixosConfigurations = {
      kyubey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/kyubey

          disko.nixosModules.disko

          ({ ... }: { networking.hostName = "kyubey"; })
        ];
      };
      kyoko = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./host/kyoko

          ({ ... }: {
            networking = {
              hostName = "kyoko";
              domain = "aeza.network";
            };
          })
        ];
      };
    };
  };
}
