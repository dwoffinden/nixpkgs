{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  writers,
  python3Packages,
}:
let
  src = fetchFromGitHub {
    owner = "amedeedaboville";
    repo = "gix-of-theseus";
    rev = "33ae4919c326cfcf6ab50fde5eaac425145b905c";
    hash = "sha256-79JfmLlmUftdxw7NI/VWuDBFqaxLaG6eHIPuYip4hfg=";
  };
  stackplotBin = writers.writePython3 "stackplot" {
    libraries = with python3Packages; [
      matplotlib
      numpy
    ];
    doCheck = false; # disable lint
  } (builtins.readFile "${src}/src/stackplot.py");
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "gix-of-theseus";
  version = "0-unstable-2025-11-04";
  __structuredAttrs = true;

  inherit src;

  cargoHash = "sha256-GLfHQeJGAbFQVTek1hBZ8U2omyiuty2nnnHdbdlG0/4=";

  passthru.updateScript = nix-update-script { };

  installPhase = ''
    mkdir -p $out/bin
    cp ${stackplotBin} $out/bin/stackplot
    chmod +x $out/bin/stackplot
  '';

  meta = {
    description = "A Rust rewrite of git-of-theseus";
    homepage = "https://github.com/amedeedaboville/gix-of-theseus";
    changelog = "https://github.com/amedeedaboville/gix-of-theseus/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "gix-of-theseus";
  };
})
