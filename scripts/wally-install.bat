wally install
call scripts/rojo-sourcemap
wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages