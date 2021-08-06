#!/bin/bash

function micvolume() {

	micvolume=$(pacmd list-sources | grep volume | grep front-left | cut -d$'\n' -f2 | awk '{ print $5 }')
	micmute=$(pacmd list-sources | grep mute | cut -d$'\n' -f2 | awk '{ print $2 }')

	if [ $micmute == 'yes' ]; then
		echo "%{T1}%{T-} %{T1}shhh!%{T-}" 
	elif [ $micvolume == '0%' ]; then
	  echo "%{T2}%{T-} %{T2}shhh!%{T-}"
	else
	  echo "%{T0}%{T-} %{T0}$micvolume%{T-}"
	fi

}

main () {

	if [ "$1" == "-m" ]; then
		micvolume
	fi

}

main $1
