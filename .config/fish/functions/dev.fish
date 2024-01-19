function dev
    set search_term $argv[1]
    set open $argv[2]
    set hx "h"
    set code "c"
    set path "$HOME/Developer"
    set -l dirs (find "$path" -type d -mindepth 2 -maxdepth 2 -name "$search_term*")

    if test -n "$search_term"
        if test (count $dirs) -gt 0
            cd $dirs[1]; or echo "ERROR: Unable to change directory to $dirs[1]"

            if test -n "$open"
                if test "$open" = "$hx"
                    hx .
                else if test "$open" = "$code"
                    code .
                else
					echo "ERROR: Unknown value for 'open': $open\nAccepted values are h: Helix, c: VSCode\n"
                end
            end
        else
			echo "ERROR: Project with name startin with $search_term not found in $path"
        end
    else
		echo "ERROR: Search term not provided"
    end
end
