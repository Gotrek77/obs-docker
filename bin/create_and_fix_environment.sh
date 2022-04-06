#!/bin/bash
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

echo "You are in: $(pwd)"
yes_or_no "Do you want to create symbolic link to logs:
ln -sf $HOME/.config/obs-studio/logs ./logs" && ln -sf $HOME/.config/obs-studio/logs ./logs
yes_or_no "Do you want to create .env file to propagate permission for host user to docker user? " && echo "UID=$(id -u $USER)" > ./.env
