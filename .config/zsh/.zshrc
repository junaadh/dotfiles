eval "$(starship init zsh)"

if type brew &>/dev/null
then
	FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

	autoload -Uz compinit
	compinit
fi

dev() {
	local search_term="$1"
	local open="$2"
	local hx="h"
	local code="c"
	local path="$HOME/Developer"
	local dirs=($("/usr/bin/find" "$path" -type d -mindepth 2 -maxdepth 2 -name "$search_term*"))

	if [ -n "$search_term" ]; then
		if [ "${#dirs[@]}" -gt 0 ]; then
			cd "$dirs[1]" || echo "ERROR: Unable to change directory to $dirs[1]"

			if [ -n "$open" ]; then
				if [ "$open" = "$hx" ]; then
					hx .
				elif [ "$open" = "$code" ]; then
					code .
				else
					echo "ERROR: Unknown value for 'open': $open\nAccepted values are h: Helix, c: VSCode\n"
				fi
			fi
		else
			echo "ERROR: Project with name startin with $search_term not found in $path"
		fi
	else
		echo "ERROR: Search term not provided"
	fi
}

alias refresh="source $ZDOTDIR/.zshrc"
alias cls="clear"

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/junaadh/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
