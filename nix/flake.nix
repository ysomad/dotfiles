{
  description = "ysomad nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      specialArgs = { inherit inputs outputs; };
    in {
    nixosConfigurations.nixos = nixosSystem {
      specialArgs = specialArgs;
      modules = [
        ./configuration.nix
	# nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.ysomad = import ./home.nix;
	  home-manager.extraSpecialArgs = specialArgs;
	}
      ];
    };
  };
}
