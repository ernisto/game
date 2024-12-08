call scripts/wally-install.cmd game.project.json &

mkdir out\rojo &
rojo build game.project.json --output out/rojo/game.rbxl
