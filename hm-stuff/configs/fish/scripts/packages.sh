#!/usr/bin/env sh

package=$((ls ~/.nix-profile/bin/;ls ~/.config/fish/functions/;ls ~/.config/fish/scripts/|grep -v "README.md") | dmenu -p " Packages :")

if [[ $package =~ ".fish" ]] || [[ $package =~ ".sh" ]];then
  package=$(echo $package|sed 's/.fish//; s/.sh//') #remove all .fish/.sh
  if [[ $package == "cdev" ]]; then
    fish -c "$package"
  else
    kitty -e fish -c "$package;read -P \n'Press Enter to exit !!' key"
  fi
else
  exec $package
fi
