call scripts/wally-install.cmd game.project.json &

mkdir out\remotes &
blink src/remotes/init --yes &

mkdir out\rojo &
rojo build game.project.json --output out/rojo/game.rbxl
