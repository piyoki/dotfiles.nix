{
  description = "A flake that encapsulates all my dotfiles from other repositories";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        src = {
          qutebrowser = inputs.dot-qutebrowser;
          waybar = inputs.dot-waybar;
          nvim = inputs.dot-nvim;
          lf = inputs.dot-lf;
          lazygit = inputs.dot-lazygit;
          rofi = inputs.dot-rofi;
          swaylock = inputs.dot-swaylock;
          swappy = inputs.dot-swappy;
          tmux = inputs.dot-tmux;
          fish = inputs.dot-fish;
          hypr = inputs.dot-hypr;
          dunst = inputs.dot-dunst;
          swaync = inputs.dot-swaync;
          kitty = inputs.dot-kitty;
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
          inherit (cfg) dunst;
          inherit (cfg) swaync;
          inherit (cfg) fish;
          inherit (cfg) hypr;
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
    dot-qutebrowser = {
      url = "github:yqlbu/dot-qutebrowser";
      flake = false;
    };
    dot-nvim = {
      url = "github:yqlbu/dot-nvim";
      flake = false;
    };
    dot-lf = {
      url = "github:yqlbu/dot-lf";
      flake = false;
    };
    dot-lazygit = {
      url = "github:yqlbu/dot-lazygit";
      flake = false;
    };
    dot-rofi = {
      url = "github:yqlbu/dot-rofi/x1-carbon";
      flake = false;
    };
    dot-swaylock = {
      url = "github:yqlbu/dot-swaylock/x1-carbon";
      flake = false;
    };
    dot-swappy = {
      url = "github:yqlbu/dot-swappy/master";
      flake = false;
    };
    dot-waybar = {
      url = "github:yqlbu/dot-waybar/x1-carbon";
      flake = false;
    };
    dot-tmux = {
      url = "github:yqlbu/dot-tmux/x1-carbon";
      flake = false;
    };
    dot-fish = {
      url = "github:yqlbu/dot-fish/x1-carbon";
      flake = false;
    };
    dot-hypr = {
      url = "github:yqlbu/dot-hypr/x1-carbon";
      flake = false;
    };
    dot-dunst = {
      url = "github:yqlbu/dot-dunst/x1-carbon";
      flake = false;
    };
    dot-swaync = {
      url = "github:yqlbu/dot-swaync/x1-carbon";
      flake = false;
    };
    dot-kitty = {
      url = "github:yqlbu/dot-kitty/x1-carbon";
      flake = false;
    };
  };
}
