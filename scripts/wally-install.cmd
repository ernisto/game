chmod +x scripts/wally-install.cmd

mkdir Packages
mkdir DevPackages
mkdir ServerPackages
wally-patch-package

scripts/rojo-sourcemap.cmd
wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages