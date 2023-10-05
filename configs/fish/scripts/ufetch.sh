#!/bin/sh
#
# ufetch-nixos - tiny system info for nixos

## INFO

# user is already defined
host="$(hostname)"
os="$(nixos-version)"
kernel="$(uname -sr)"
uptime="$(uptime | awk -F, '{sub(".*up ",x,$1);print $1}' | sed -e 's/^[ \t]*//')"
packages="$(ls -d -1 /nix/store/ | wc -l)"
shell="$(basename "$SHELL")"

## UI DETECTION

if [ -n "${DE}" ]; then
	ui="${DE}"
	uitype='DE'
elif [ -n "${WM}" ]; then
	ui="${WM}"
	uitype='WM'
elif [ -n "${XDG_CURRENT_DESKTOP}" ]; then
	ui="${XDG_CURRENT_DESKTOP}"
	uitype='DE'
elif [ -n "${DESKTOP_SESSION}" ]; then
	ui="${DESKTOP_SESSION}"
	uitype='DE'
elif [ -f "${HOME}/.xinitrc" ]; then
	ui="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	uitype='WM'
elif [ -f "${HOME}/.xsession" ]; then
	ui="$(tail -n 1 "${HOME}/.xsession" | cut -d ' ' -f 2)"
	uitype='WM'
else
	ui='unknown'
	uitype='UI'
fi

## DEFINE COLORS

# probably don't change these
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
	reset="$(tput sgr0)"
fi

# you can change these
lc="${reset}${bold}${blue}"         # labels
nc="${reset}${bold}${blue}"         # user and hostname
ic="${reset}${bold}${white}"        # info
c0="${reset}${blue}"                # first color
c1="${reset}${bold}${blue}"         # second color

## OUTPUT

sed 's/\\/\\\\/g' <<EOF

${c0}    \\   ${c1}\\ //    ${nc}${USER}${ic}@${nc}${host}${reset}
${c0}   ==\\___${c1}\\/ ${c0}//  ${lc}OS:        ${ic}${os}${reset}
${c1}     //    \\${c0}//   ${lc}KERNEL:    ${ic}${kernel}${reset}
${c1}  ==//      ${c0}//==  ${lc}UPTIME:    ${ic}${uptime}${reset}
${c1}   //${c0}\\${c1}____${c0}//     ${lc}PACKAGES:  ${ic}${packages}${reset}
${c1}  // ${c0}/\\   ${c1}\\==   ${lc}SHELL:     ${ic}${shell}${reset}
${c0}    // \\   ${c1}\\    ${lc}${uitype}:        ${ic}${ui}${reset}

EOF

