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

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    stylix,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs.lib) nixosSystem;
    specialArgs = {inherit inputs outputs hyprland;};
  in {
    nixosConfigurations.nixos = nixosSystem {
      specialArgs = specialArgs;
      modules = [
        stylix.nixosModules.stylix
        ./nix/configuration.nix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ysomad = import ./nix/home.nix;
          home-manager.extraSpecialArgs = specialArgs;
        }
        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
      ];
    };
  };
}
