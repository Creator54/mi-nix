#!/usr/bin/env bash

set -e -o pipefail

# Function to list unique executables in a directory
list_executables() {
	ls -1 "$1" 2>/dev/null | awk '!seen[$0]++'
}

# List unique executables in directories from $PATH and additional locations
package=$( (
	IFS=: read -ra PATH_DIRS <<<"$PATH"
	for dir in "${PATH_DIRS[@]}"; do
		list_executables "$dir"
	done
	list_executables ~/.config/fish/functions/
	list_executables ~/.config/fish/scripts/ | grep -v "README.md"
) | dmenu -p "Packages:")

if [ -n "$package" ]; then
	if [[ $package =~ ".fish" ]] || [[ $package =~ ".sh" ]]; then
		package=$(echo $package | sed 's/.fish//; s/.sh//') # remove .fish/.sh extensions
		if [[ $package == "cdev" ]]; then
			exec "$package" &
		else
			$TERMINAL -e $SHELL -c "$package; read -p 'Press Enter to exit!!' key"
		fi
	else
		exec "$package" &
	fi
fi

exit 0
