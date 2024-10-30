mkdir Packages &
mkdir DevPackages &
mkdir ServerPackages &
wally-patch-package &
call scripts/rojo-sourcemap.cmd

wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages