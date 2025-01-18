set shell := ["bash", "-c"]
set windows-shell := ["pwsh", "-Command"]

# Even in Windows, use XDG_DATA_HOME if it is set
local := if env_var("XDG_DATA_HOME") != "" {env_var("XDG_DATA_HOME")} \
    else if env_var("LOCALAPPDATA") != "" {env_var("LOCALAPPDATA")} \
    else if os() != "windows" {env_var("HOME") + "/.local/share"} \
    else {"C:\\Users\\" + env_var("USERNAME") + "\\AppData\\Local"}

rime_install := \
    if os() == "windows" {".\\rime-install.bat"} \
    else if os() == "macos" {"bash rime-install"} \
    else if os() == "linux" {"rime_frontend=fcitx5-rime bash rime-install"} \
    else {"echo 'Unsupported OS' && exit 1"}


[private]
default:
    @just --list

test:
    echo {{local}}
    echo {{rime_install}}

update:
    cd {{local}}/plum && {{rime_install}} plum && {{rime_install}} iDvel/rime-ice:others/recipes/cn_dicts

push:
    git push github master
    git push codeberg master

pull:
    git pull github master
    git pull codeberg master

init:
    just set_remote
    just clone_plum

clone_plum:
    cd {{local}} && git clone https://github.com/rime/plum.git --depth=1

[private]
set_remote:
    git remote remove origin
    git remote add github git@github.com:js0ny/Rime.git
    git remote add codeberg git@codeberg.org:js0ny/Rime.git

[windows]
install_rime:
    winget install --id=Rime.Weasel -e

[macos]
install_rime:
    command -v brew > /dev/null || echo "Make sure you have installed homebrew"
    brew install squirrel

[linux]
install_rime:
    sudo pacman -S fcitx5-rime
