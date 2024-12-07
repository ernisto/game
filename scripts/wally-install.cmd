wally install
mkdir Packages &
mkdir DevPackages &
mkdir ServerPackages &
wally-patch-package &

if %1 == dev.project.json goto skip
echo --!nocheck> Packages/init.luau
echo return require(script.package) >> Packages/init.luau
:skip

rojo sourcemap %1 -o sourcemap.json --include-non-scripts

wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json DevPackages
wally-package-types --sourcemap sourcemap.json ServerPackages