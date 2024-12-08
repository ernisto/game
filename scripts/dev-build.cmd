call scripts/wally-install.cmd dev.project.json &

mkdir out\remotes &
blink src/remotes/init --yes &

mkdir out\rojo &
rojo build dev.project.json --output out/rojo/game.rbxl
