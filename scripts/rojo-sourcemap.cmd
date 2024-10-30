mkdir -p out/remotes
&& blink src/remotes/init --yes
&& rojo sourcemap -o sourcemap.json game.project.json