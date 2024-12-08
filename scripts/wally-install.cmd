wally install
mkdir Packages &
mkdir DevPackages &
mkdir ServerPackages &
wally-patch-package &

mkdir out\remotes &
blink src/remotes/init --yes &

rojo sourcemap %1 -o sourcemap.json --include-non-scripts

wally-package-types --sourcemap sourcemap.json Packages
wally-package-types --sourcemap sourcemap.json ServerPackages

if %1 == dev.project.json (
    wally-package-types --sourcemap sourcemap.json DevPackages
)