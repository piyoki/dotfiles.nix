{
  description = "A flake that encapsulates all my dotfiles from other repositories";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        installPhase = ''
          mkdir -p $out/$name
          cp -r . $out/$name/
          # install -Dm444 -t "$out/$name" config.py
        '';
        pkgs = (import nixpkgs) { inherit system; };
        qutebrowser = pkgs.stdenv.mkDerivation {
          name = "qutebrowser";
          src = inputs.qutebrowser;
          inherit installPhase;
        };
        waybar = pkgs.stdenv.mkDerivation {
          name = "waybar";
          src = inputs.waybar;
          inherit installPhase;
        };
        nvim = pkgs.stdenv.mkDerivation {
          name = "nvim";
          src = inputs.nvim;
          inherit installPhase;
        };
      in
      {
        # define output packages
        packages = {
          default = nixpkgs.legacyPackages.${system}.neofetch;
          inherit qutebrowser;
          inherit waybar;
          inherit nvim;
        };

        # dev environment
        devShells.default = with pkgs; mkShell {
          packages = [ vim ];
        };
      });

  inputs = {
    # nix and flake
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    # personal dotfiles
    qutebrowser = {
      url = "github:yqlbu/dot-qutebrowser";
      flake = false;
    };
    nvim = {
      url = "github:yqlbu/dot-nvim";
      flake = false;
    };
    lf = {
      url = "github:yqlbu/dot-lf";
      flake = false;
    };
    lazygit = {
      url = "github:yqlbu/dot-lazygit";
      flake = false;
    };
    swappy = {
      url = "github:yqlbu/dot-swappy";
      flake = false;
    };
    rofi = {
      url = "github:yqlbu/dot-rofi/x1-carbon";
      flake = false;
    };
    swaylock = {
      url = "github:yqlbu/dot-swaylock/x1-carbon";
      flake = false;
    };
    waybar = {
      url = "github:yqlbu/dot-waybar/x1-carbon";
      flake = false;
    };
    tmux = {
      url = "github:yqlbu/dot-tmux/x1-carbon";
      flake = false;
    };
    fish = {
      url = "github:yqlbu/dot-fish/x1-carbon";
      flake = false;
    };
    hypr = {
      url = "github:yqlbu/dot-hypr/x1-carbon";
      flake = false;
    };
    dunst = {
      url = "github:yqlbu/dot-dunst/x1-carbon";
      flake = false;
    };
    kitty = {
      url = "github:yqlbu/dot-kitty/x1-carbon";
      flake = false;
    };
  };
}
