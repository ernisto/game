wally install
mkdir Packages
mkdir DevPackages
mkdir ServerPackages
wally-patch-packages

call scripts/rojo-sourcemap
wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages