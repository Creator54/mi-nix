#!/usr/bin/env bash

set -e

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
BACKUP_DIR="$SCRIPT_PATH/gnome3-keybind-backup"

function backup_keys() {
	mkdir -p "$BACKUP_DIR"

	dconf dump '/org/gnome/desktop/wm/keybindings/' >"$BACKUP_DIR/keybindings.dconf"
	dconf dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' >"$BACKUP_DIR/custom-values.dconf"
	dconf read '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings' >"$BACKUP_DIR/custom-keys.dconf"
	echo "KeyBindings Backup done"
}

function restore_keys() {
	dconf reset -f '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/'
	dconf reset -f '/org/gnome/desktop/wm/keybindings/'
	dconf load '/org/gnome/desktop/wm/keybindings/' <"$BACKUP_DIR/keybindings.dconf"
	dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' <"$BACKUP_DIR/custom-values.dconf"
	dconf write '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings' "$(cat "$BACKUP_DIR/custom-keys.dconf")"
	echo "KeyBindings Restore done"
}

function main() {
	if ! command -v nix &>/dev/null; then
		sudo sh <(curl -L https://nixos.org/nix/install) --daemon
	fi

	if ! nix-channel --list | grep -q "nixpkgs"; then
		echo "Adding nixpkgs channel !"
		nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
		if ! nix-channel --list | grep -q "home-manager"; then
			echo "Adding home-manager channel !"
			nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
		fi
		nix-channel --update
	fi

	if ! command -v home-manager &>/dev/null; then
		export NIX_PATH="${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels"
		nix-env -iA nixpkgs.home-manager
	fi

	if [[ ! -e "$SCRIPT_PATH/hm-stuff/home.nix" ]]; then
		mkdir -p "$HOME/.config/home-manager"
		echo "Symlinking home.nix !"
		ln -s "$SCRIPT_PATH/hm-stuff/home.nix" "$HOME/.config/home-manager/home.nix"
	fi

	echo "Updating setup !"
	nix build $SCRIPT_PATH#home-config.activationPackage --impure
	$SCRIPT_PATH/result/activate
}

case "$1" in
backup)
	backup_keys
	;;
restore)
	restore_keys
	main
	;;
up)
	main
	;;
*)
	echo "Usage: $0 [backup|restore|up]"
	exit 1
	;;
esac
