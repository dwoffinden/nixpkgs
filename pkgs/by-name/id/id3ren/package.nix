{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
  installShellFiles,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "id3ren";
  version = "0-unstable-2013-05-21";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "sebcode";
    repo = "id3ren";
    rev = "b061aba2bfa25bcde732776262cc2a19d66b416a";
    hash = "sha256-F3s84PbfM0nZjLGn+mx7Hr6xSX42aoyUda7iyk/XT8Y=";
  };

  installFlags = [ "INSTALL_DIR=$(out)/bin" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installManPage man/id3ren.1
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Id3ren - slighly modified to be compilable on osx";
    homepage = "https://github.com/sebcode/id3ren";
    changelog = "https://github.com/sebcode/id3ren/blob/${finalAttrs.src.rev}/ChangeLog";
    license = lib.licenses.gpl2Only;
    maintainers = [ lib.maintainers.dwoffinden ];
    mainProgram = "id3ren";
    platforms = lib.platforms.all;
  };
})
