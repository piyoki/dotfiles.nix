{
  description = "A flake that encapsulates all my dotfiles from other repositories";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        src = {
          inherit (inputs) qutebrowser;
          inherit (inputs) waybar;
          inherit (inputs) nvim;
          inherit (inputs) lf;
          inherit (inputs) lazygit;
          inherit (inputs) rofi;
          inherit (inputs) swaylock;
          inherit (inputs) swappy;
          inherit (inputs) tmux;
          inherit (inputs) fish;
          inherit (inputs) hypr;
          inherit (inputs) dunst;
          inherit (inputs) kitty;
        };
        cfg = builtins.mapAttrs
          (module: src:
            pkgs.stdenv.mkDerivation {
              name = module;
              inherit src;
              installPhase = ''
                cp -r . $out/
                # install -Dm444 -t "$out/$name" config.py
              '';
            }
          )
          src;
      in
      {
        # define output packages
        packages = {
          default = nixpkgs.legacyPackages.${system}.neofetch;
          inherit (cfg) qutebrowser;
          inherit (cfg) waybar;
          inherit (cfg) nvim;
          inherit (cfg) lf;
          inherit (cfg) lazygit;
          inherit (cfg) rofi;
          inherit (cfg) swaylock;
          inherit (cfg) swappy;
          inherit (cfg) tmux;
          inherit (cfg) fish;
          inherit (cfg) hypr;
          inherit (cfg) dunst;
          inherit (cfg) kitty;
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
    rofi = {
      url = "github:yqlbu/dot-rofi/x1-carbon";
      flake = false;
    };
    swaylock = {
      url = "github:yqlbu/dot-swaylock/x1-carbon";
      flake = false;
    };
    swappy = {
      url = "github:yqlbu/dot-swappy/master";
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
