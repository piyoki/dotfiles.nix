{
  description = "A flake that encapsulates all my dotfiles from other repositories";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        src = {
          # universal
          qutebrowser-universal = inputs.dot-qutebrowser;
          waybar-universal = inputs.dot-waybar;
          nvim-universal = inputs.dot-nvim;
          lf-universal = inputs.dot-lf;
          lazygit-universal = inputs.dot-lazygit;
          rofi-universal = inputs.dot-rofi;
          swaylock-universal = inputs.dot-swaylock;
          swappy-universal = inputs.dot-swappy;
          tmux-universal = inputs.dot-tmux;
          fish-universal = inputs.dot-fish;
          hypr-universal = inputs.dot-hypr;
          dunst-universal = inputs.dot-dunst;
          kitty-universal = inputs.dot-kitty;
          alacritty-universal = inputs.dot-alacritty;

          # host-specific
          rofi-laptop = inputs.dot-rofi-laptop;
          waybar-laptop = inputs.dot-waybar-laptop;
          hypr-laptop = inputs.dot-hypr-laptop;
          dunst-laptop = inputs.dot-dunst-laptop;
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
          # universal
          inherit (cfg) qutebrowser-universal;
          inherit (cfg) waybar-universal;
          inherit (cfg) nvim-universal;
          inherit (cfg) lf-universal;
          inherit (cfg) lazygit-universal;
          inherit (cfg) rofi-universal;
          inherit (cfg) swaylock-universal;
          inherit (cfg) swappy-universal;
          inherit (cfg) tmux-universal;
          inherit (cfg) dunst-universal;
          inherit (cfg) fish-universal;
          inherit (cfg) hypr-universal;
          inherit (cfg) kitty-universal;
          inherit (cfg) alacritty-universal;

          # host-specific
          inherit (cfg) rofi-laptop;
          inherit (cfg) waybar-laptop;
          inherit (cfg) hypr-laptop;
          inherit (cfg) dunst-laptop;
        };
        # dev environment
        devShells.default = with pkgs; mkShell {
          packages = [ vim ];
        };
      });

  inputs = {
    # nix and flake
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # universal configs
    dot-qutebrowser = { url = "github:yqlbu/dot-qutebrowser"; flake = false; };
    dot-nvim = { url = "github:yqlbu/dot-nvim"; flake = false; };
    dot-lf = { url = "github:yqlbu/dot-lf"; flake = false; };
    dot-lazygit = { url = "github:yqlbu/dot-lazygit"; flake = false; };
    dot-rofi = { url = "github:yqlbu/dot-rofi"; flake = false; };
    dot-swaylock = { url = "github:yqlbu/dot-swaylock"; flake = false; };
    dot-swappy = { url = "github:yqlbu/dot-swappy"; flake = false; };
    dot-waybar = { url = "github:yqlbu/dot-waybar"; flake = false; };
    dot-tmux = { url = "github:yqlbu/dot-tmux"; flake = false; };
    dot-fish = { url = "github:yqlbu/dot-fish"; flake = false; };
    dot-hypr = { url = "github:yqlbu/dot-hypr"; flake = false; };
    dot-kitty = { url = "github:yqlbu/dot-kitty"; flake = false; };
    dot-alacritty = { url = "github:yqlbu/dot-alacritty"; flake = false; };
    dot-dunst = { url = "github:yqlbu/dot-dunst"; flake = false; };

    # host-specific
    dot-rofi-laptop = { url = "github:yqlbu/dot-rofi/x1-carbon"; flake = false; };
    dot-waybar-laptop = { url = "github:yqlbu/dot-waybar/x1-carbon"; flake = false; };
    dot-hypr-laptop = { url = "github:yqlbu/dot-hypr/x1-carbon"; flake = false; };
    dot-dunst-laptop = { url = "github:yqlbu/dot-dunst/x1-carbon"; flake = false; };
  };
}
