#!/bin/bash

# Description: Simple laravel installer & composer configurer for termux.
# Date: 01/09/2025
# Author: 7wp81x


function banner {
	printf "\033[1;91m __                        _ \n\033[0m"
	printf "\033[1;91m|  |   ___ ___ ___ _ _ ___| |\n\033[0m" 
	printf "\033[1;91m|  |__| .'|  _| .'| | | -_| |\n\033[0m"     
	printf "\033[1;91m|_____|__,|_| |__,|\_/|___|_|\n\033[0m" 
	printf "\033[1;92m _____         _       _ _   \n\033[0m"
	printf "\033[1;92m|     |___ ___| |_ ___| | |___ ___\n\033[0m"
	printf "\033[1;92m|-   -|   |_ -|  _| .'| | | -_|  _|\n\033[0m"
	printf "\033[1;92m|_____|_|_|___|_| |__,|_|_|___|_|\n\n\033[0m"

	printf "\033[1;92m[+]\033[0m Simple installer by \033[1;91m7wp8x.\033[0m\n"
	printf "\033[1;92m[+]\033[0m Github: \033[4;92mhttp://github.com/7wp8x.\033[0m\n\n\n"
}

function config_laravel {
    printf "\033[1;94m[*]\033[0m Configuring Laravel PATH...\n"

    local path_line="export PATH=\"\$HOME/.composer/vendor/bin:\$PATH\""
    local bashrc="$PREFIX/etc/bash.bashrc"	

    if ! grep -Fxq "$path_line" "$bashrc"; then
        echo "$path_line" >> "$bashrc"
        printf "\033[1;92m[+]\033[0m Added Laravel path to $bashrc\n"
    else
        printf "\033[1;94m[*]\033[0m Laravel path already configured in $bashrc\n"
    fi

    printf "\033[1;92m[+]\033[0m Configuration complete. Please restart your shell or run:\n"
    printf "    source %s\n" "$bashrc"
    printf "\033[1;92m[+]\033[0m You should be able to execute \033[1;92mlaravel\033[0m now.\n"
}

function install_laravel {
    if ! command -v termux-info >/dev/null 2>&1; then
        printf "\033[1;91m[!]\033[0m This installer is made for Termux only.\n"
        exit 1
    fi

    if ! curl -fsSL https://example.com >/dev/null 2>&1; then
        printf "\033[1;91m[!]\033[0m Please check your internet connection.\n"
        exit 1
    fi

    pkg update && pkg upgrade -y
    pkg install php composer -y

    printf "\033[1;94m[*]\033[0m Installing Laravel installer globally...\n"
    composer global require laravel/installer --no-interaction

    config_laravel
}

function check_sys {
    local laravel_bin="$HOME/.composer/vendor/bin/laravel"

    if [ -f "$laravel_bin" ]; then
        printf "\033[1;94m[*]\033[0m Laravel is already installed.\n"
        if ! command -v laravel >/dev/null 2>&1; then
            printf "\033[1;91m[!]\033[0m Laravel is not properly configured in PATH.\n"
            config_laravel
        fi
    else
        install_laravel
    fi
}


banner
check_sys