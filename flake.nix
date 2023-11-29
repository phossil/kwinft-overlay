{
  description = "Overlay for KWinFT/Disman/KDisplay/Wrapland";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils/v1.0.0;
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      makeScope = nixpkgs.lib.makeScope;
      libsForQt5 = pkgs.libsForQt5;

      # check the packages directory to see
      # what is available
      all-packages = import ./packages { inherit pkgs makeScope libsForQt5; };
    in
    {
      # these are yet to be added to nixpkgs
      packages.${system} = flake-utils.lib.flattenTree all-packages;

      # make the flake look pretty :)
      formatter.${system} = pkgs.nixpkgs-fmt;
    } // {
      overlays.default = import ./overlay.nix;
    };
}
