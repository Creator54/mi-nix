#!/usr/bin/env sh

set -e -o pipefail

package=$((ls ~/.nix-profile/bin/;ls ~/.config/fish/functions/;ls ~/.config/fish/scripts/|grep -v "README.md") | dmenu -p " Packages :")

if [[ $package =~ ".fish" ]] || [[ $package =~ ".sh" ]];then
  package=$(echo $package|sed 's/.fish//; s/.sh//') #remove all .fish/.sh
  if [[ $package == "cdev" ]]; then
    exec "$package" &
  else
    $TERMINAL -e $SHELL -c "$package;read -P \n'Press Enter to exit !!' key"
  fi
else
  exec $package &
fi
exit 0