{ mkDerivation, base, lib, SDL, ...}:
mkDerivation {
  pname = "Descartes";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base ];
  librarySystemDepends = [ SDL ];
  testHaskellDepends = [ base ];
  license = lib.licenses.gpl2Only;
}
