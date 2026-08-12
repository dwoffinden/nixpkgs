{
  lib,
  fetchFromGitHub,
  fetchpatch,
  python3Packages,
  withTeXLive ? true,
  texliveSmall,
}:
python3Packages.buildPythonApplication (finalAttrs: {
  pname = "cgt-calc";
  version = "2.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "KapJI";
    repo = "capital-gains-calculator";
    #tag = "v${finalAttrs.version}";
    rev = "076d236ea7592cf1cabf38d879a3cbd93470736e";
    hash = "sha256-RaIERprly+3+CqXHxPHpK0b7HkjfM/a6DeoHOW4mYCI=";
  };

  patches = [
  ];

  build-system = with python3Packages; [
    uv-build
  ];

  dependencies = with python3Packages; [
    defusedxml
    jinja2
    pandas
    requests
    pyrate-limiter
    types-requests
    yfinance
    colorama
    openpyxl
    xlrd
    iso4217parse
    pdfplumber
  ];

  makeWrapperArgs = lib.optionals withTeXLive [
    "--prefix"
    "PATH"
    ":"
    "${lib.getBin texliveSmall}/bin"
  ];

  meta = {
    description = "UK capital gains tax calculator";
    homepage = "https://github.com/KapJI/capital-gains-calculator";
    license = lib.licenses.mit;
    mainProgram = "cgt-calc";
    maintainers = with lib.maintainers; [ ambroisie ];
    platforms = lib.platforms.unix;
  };
})
