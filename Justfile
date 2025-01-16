set shell := ["bash", "-c"]

[macos]
update:
    cd ~/.local/share/plum && bash rime-install plum && bash rime-install iDvel/rime-ice:others/recipes/all_dicts

[linux]
update:
    cd ~/.local/share/plum && bash rime-install plum &&rime_frontend=fcitx5-rime bash rime-install iDvel/rime-ice:others/recipes/all_dicts


[unix]
init:
    just set_remote
    just clone_plum

[windows]
init:
    just set_remote

push:
    git push github master
    git push codeberg master

pull:
    git pull github master
    git pull codeberg master

clone_plum:
    cd ~/.local/share && git clone --depth 1

set_remote:
    git remote remove origin
    git remote add github git@github.com:js0ny/Rime.git
    git remote add codeberg git@codeberg.org:js0ny/Rime.git