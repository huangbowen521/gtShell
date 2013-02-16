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
			validate_bookmark_name "$@"
			if [ -z "$result" ]; then
				CURDIR=$( $PWD)
				 "$2=$CURDIR" >> $DIRS
			fi
			;;
		-l)
			cat $DIRS
			;;
		-h)
			print_usage
			;;
		*)   
			if [ -z $1 ]; then
				print_usage
			elif [[ ! -z `awk -F '=' '/^'"$1"'=/ {print $2 }' $DIRS` ]]; then
				cd `awk -F '=' '/^'"$1"'=/ {print $2 }' $DIRS`
				else
					 'error: bookmark name not found'

			fi
	
	esac
}

#validate names
function validate_bookmark_name {
	result="" 
	if [ -z $2 ]; then
		result='error: bookmark name required!'
		 $result
	elif [ "$2" != "$( $2 | sed 's/[^A-Za-z0-9_]//g')" ]; then
		result='error: bookmark name is invalid!'
		 $result
	fi

}

function print_usage {
	     'Usage:'
         '-a <bookmark_name> - Saves the current directory as "bookmark_name"'
         '-d <bookmark_name> - Deletes the bookmark'
         '-l                 - Lists all available bookmarks'
         '-h(-help,--help)   - Lists usage'
         '<bookmark_name>    - Jump to the bookmark'   
}

function _l {
	awk -F '=' ' {print $1} ' $DIRS
}


function _comp {
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W '`_l`' -- $curw))
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

