#! /bin/bash

DIRS="$HOME/.gtDirs"
if test ! -e $DIRS 
then
	touch $DIRS
fi

gt () {
	case $1 in
		-d)
			temp=`mktemp -t .gtDirs-XXXXXX` 
			sed "/^$2=/"d $DIRS > $temp
			mv $temp $DIRS
			rm -f $temp
			;;
		-a)
			isValidName "$@"
			if [ -z "$result" ]; then
				CURDIR=$(echo $PWD)
				echo "$2=$CURDIR" >> $DIRS
			fi
			;;
		-l)
			cat $DIRS
			;;
		-h)
			print_help
			;;
		*)   
			if [ -z $1 ]; then
				print_help
			elif [[ ! -z `awk -F '=' '/^'"$1"'=/ {print $2 }' $DIRS` ]]; then
				cd `awk -F '=' '/^'"$1"'=/ {print $2 }' $DIRS`
				else
					echo 'error: bookmark name not found'

			fi
	
	esac
}

#validate names
function isValidName {
	result="" 
	if [ -z $2 ]
		then
		result='error: name required!'
		echo $result
	elif [ "$2" != "$(echo $2 | sed 's/[^A-Za-z0-9_]//g')" ]; then
		result='error: name is not valid'
		echo $result
	fi

}

function print_help {
	    echo 'Usage:'
        echo '-a <bookmark_name> - Saves the current directory as "bookmark_name"'
        echo '-d <bookmark_name> - Deletes the bookmark'
        echo '-l                 - Lists all available bookmarks'
        echo '-h(-help,--help)   - List usage'
        echo '<bookmark_name>    - Jump to the bookmark'   
}


function _comp {
    local curw
    COMPREPLY=()
    return 0
}

# ZSH completion command
function _compzsh {
    reply=($(_l))
}


if [ $ZSH_VERSION ]; then
	compctl -K _compzsh gt
else
	shopt -s progcomp
	complete -F _comp gt
fi

