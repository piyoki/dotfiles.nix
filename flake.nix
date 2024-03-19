{
  description = "A flake that encapsulates all my dotfiles from other repositories";

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        src = {
          # universal
          inherit (inputs) qutebrowser-universal;
          inherit (inputs) waybar-universal;
          inherit (inputs) nvim-universal;
          inherit (inputs) lf-universal;
          inherit (inputs) lazygit-universal;
          inherit (inputs) rofi-universal;
          inherit (inputs) swaylock-universal;
          inherit (inputs) swappy-universal;
          inherit (inputs) tmux-universal;
          inherit (inputs) fish-universal;
          inherit (inputs) hypr-universal;
          inherit (inputs) dunst-universal;
          inherit (inputs) kitty-universal;
          inherit (inputs) alacritty-universal;
          inherit (inputs) foot-universal;

          # host-specific
          inherit (inputs) rofi-laptop;
          inherit (inputs) waybar-laptop;
          inherit (inputs) hypr-laptop;
          inherit (inputs) dunst-laptop;
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
          inherit (cfg) foot-universal;

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
    qutebrowser-universal = { url = "github:yqlbu/dot-qutebrowser"; flake = false; };
    nvim-universal = { url = "github:yqlbu/dot-nvim"; flake = false; };
    lf-universal = { url = "github:yqlbu/dot-lf"; flake = false; };
    lazygit-universal = { url = "github:yqlbu/dot-lazygit"; flake = false; };
    rofi-universal = { url = "github:yqlbu/dot-rofi"; flake = false; };
    swaylock-universal = { url = "github:yqlbu/dot-swaylock"; flake = false; };
    swappy-universal = { url = "github:yqlbu/dot-swappy"; flake = false; };
    waybar-universal = { url = "github:yqlbu/dot-waybar"; flake = false; };
    tmux-universal = { url = "github:yqlbu/dot-tmux"; flake = false; };
    fish-universal = { url = "github:yqlbu/dot-fish"; flake = false; };
    hypr-universal = { url = "github:yqlbu/dot-hypr"; flake = false; };
    kitty-universal = { url = "github:yqlbu/dot-kitty"; flake = false; };
    alacritty-universal = { url = "github:yqlbu/dot-alacritty"; flake = false; };
    foot-universal = { url = "github:yqlbu/dot-foot"; flake = false; };
    dunst-universal = { url = "github:yqlbu/dot-dunst"; flake = false; };

    # host-specific
    rofi-laptop = { url = "github:yqlbu/dot-rofi/x1-carbon"; flake = false; };
    waybar-laptop = { url = "github:yqlbu/dot-waybar/x1-carbon"; flake = false; };
    hypr-laptop = { url = "github:yqlbu/dot-hypr/x1-carbon"; flake = false; };
    dunst-laptop = { url = "github:yqlbu/dot-dunst/x1-carbon"; flake = false; };
  };
}
