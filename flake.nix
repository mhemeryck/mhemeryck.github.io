{
  description = "Tooling for mhemeryck.github.io";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              dart-sass
              dprint
              go
              hugo
              just
              liberation_ttf
              nushell
              pandoc
              typst
            ];

            shellHook = ''
              export TYPST_FONT_PATHS=${pkgs.liberation_ttf}/share/fonts/truetype
            '';
          };
        });
    };
}
