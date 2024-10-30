chmod +x scripts/wally-install.cmd
scripts/wally-install.cmd
&& mkdir -p out/rojo
&& rojo build game.project.json --output out/rojo/game.rbxl