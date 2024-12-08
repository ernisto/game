call scripts/wally-install.cmd dev.project.json &

mkdir out\rojo &
rojo build dev.project.json --output out/rojo/game.rbxl
