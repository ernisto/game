wally install
mkdir Packages &
mkdir DevPackages &
mkdir ServerPackages &
wally-patch-package &

rojo sourcemap %1 -o sourcemap.json --include-non-scripts

wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages