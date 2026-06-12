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
          aspell = pkgs.aspellWithDicts (dicts: with dicts; [ en ]);
          aspellForPyspelling = pkgs.writeShellScriptBin "aspell" ''
            exec ${aspell}/bin/aspell --data-dir ${aspell}/lib/aspell --dict-dir ${aspell}/lib/aspell "$@"
          '';
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              aspellForPyspelling
              dart-sass
              dprint
              go
              hugo
              ibm-plex
              just
              liberation_ttf
              nushell
              pandoc
              python3Packages.pyspelling
              typst
              nerd-fonts.fira-code
            ];

            shellHook = ''
              export TYPST_FONT_PATHS=${pkgs.nerd-fonts.fira-code}/share/fonts:${pkgs.ibm-plex}/share/fonts:${pkgs.liberation_ttf}/share/fonts/truetype
            '';
          };
        });
    };
}
