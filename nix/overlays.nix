{inputs, ...}: {
  modifications = final: prev: let
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  in {
    # Use stable versions (broken in unstable)
    # https://github.com/golang/go/issues/74462
    # https://github.com/go-swagger/go-swagger/issues/3220
    go-swagger = stable.go-swagger;

    gimp = stable.gimp;

    # broken login on unstable 31.10.25
    insomnia = stable.insomnia;

    neovim = inputs.neovim-nightly-overlay.packages.${final.system}.default;
    zen-browser = inputs.zen-browser.packages.${final.system}.default;
  };
}
