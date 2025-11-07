{
  description = "ysomad nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    specialArgs = {inherit inputs outputs;};
  in {
    overlays = import ./nix/overlays.nix {inherit inputs;};
    nixosConfigurations.nixos = nixosSystem {
      specialArgs = specialArgs;
      modules = [
        ./nix/configuration.nix
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ysomad = import ./nix/home.nix;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.sharedModules = [
            inputs.zen-browser.homeModules.default
          ];
        }
        nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
      ];
    };
  };
}
