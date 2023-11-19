#!/usr/bin/env bash

set -e -o pipefail

# Function to list unique executables in a directory
list_executables() {
	ls -1 "$1" 2>/dev/null | awk '!seen[$0]++'
}

# List unique executables in directories from $PATH and additional locations
selected_package=$( (
	IFS=: read -ra PATH_DIRS <<<"$PATH"
	for dir in "${PATH_DIRS[@]}"; do
		list_executables "$dir"
	done
	list_executables ~/.config/fish/functions/
	list_executables ~/.config/fish/scripts/ | grep -v "README.md"
	echo "windows11"
	echo "macos-catalina"
) | dmenu -p "Packages:")

if [ -n "$selected_package" ]; then
	if [[ $selected_package == "windows11" ]]; then
		cd /home/$USER/VMS/
		quickemu --vm windows-11.conf --screen 0
	elif [[ $selected_package == "macos-catalina" ]]; then
		cd /home/$USER/VMS/
		quickemu --vm macos-catalina.conf --screen 0
	elif [[ $selected_package =~ \.fish$|\.sh$ ]]; then
		selected_package=$(echo "$selected_package" | sed 's/.fish//; s/.sh//') # remove .fish/.sh extensions
		if [[ $selected_package == "cdev" ]]; then
			exec "$selected_package" &
		else
			$TERMINAL -e $SHELL -c "$selected_package; read -p 'Press Enter to exit!!' key"
		fi
	else
		exec "$selected_package" &
	fi
fi

exit 0
