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
        lf = pkgs.stdenv.mkDerivation {
          name = "lf";
          src = inputs.lf;
          inherit installPhase;
        };
        lazygit = pkgs.stdenv.mkDerivation {
          name = "lazygit";
          src = inputs.lazygit;
          inherit installPhase;
        };
        rofi = pkgs.stdenv.mkDerivation {
          name = "rofi";
          src = inputs.rofi;
          inherit installPhase;
        };
        swaylock = pkgs.stdenv.mkDerivation {
          name = "swaylock";
          src = inputs.rofi;
          inherit installPhase;
        };
        swappy = pkgs.stdenv.mkDerivation {
          name = "swappy";
          src = inputs.swappy;
          inherit installPhase;
        };
        tmux = pkgs.stdenv.mkDerivation {
          name = "tmux";
          src = inputs.tmux;
          inherit installPhase;
        };
        fish = pkgs.stdenv.mkDerivation {
          name = "fish";
          src = inputs.fish;
          inherit installPhase;
        };
        hypr = pkgs.stdenv.mkDerivation {
          name = "hypr";
          src = inputs.hypr;
          inherit installPhase;
        };
        dunst = pkgs.stdenv.mkDerivation {
          name = "dunst";
          src = inputs.dunst;
          inherit installPhase;
        };
        kitty = pkgs.stdenv.mkDerivation {
          name = "kitty";
          src = inputs.kitty;
          inherit installPhase;
        };
      in
      {
        # define output packages
        packages = {
          default = nixpkgs.legacyPackages.${system}.neofetch;
          inherit dunst;
          inherit fish;
          inherit hypr;
          inherit kitty;
          inherit lazygit;
          inherit lf;
          inherit nvim;
          inherit qutebrowser;
          inherit rofi;
          inherit swappy;
          inherit swaylock;
          inherit tmux;
          inherit waybar;
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
