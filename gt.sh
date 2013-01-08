DIRS="$HOME/.gtDirs"
if test ! -e $DIRS 
then
	touch $DIRS
fi

 
gt () {
	case $1 in
		-d)
			_purge_line "$DIRS" "export DIR_$2="
			unset "DIR_$2"
			;;
		-a)
			CURDIR=$(echo $PWD| sed "s#^$HOME#\$HOME#g")
			_purge_line "$DIRS" "export DIR_$2="
			echo "export DIR_$2=\"$CURDIR\"" >> $DIRS
			;;
		-l)
			source $DIRS
			env | grep "^DIR_" | cut -c5- | sort | grep "^.*="
			;;
		*)   
			source $DIRS
			cd "$(eval $(echo echo $(echo \$DIR_$1)))"

	esac
}

function _l {
    source $SDIRS
    env | grep "^DIR_" | cut -c5- | sort | grep "^.*=" | cut -f1 -d "=" 
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

function _purge_line {
    if [ -s "$1" ]; then
        # safely create a temp file
        t=$(mktemp -t bashmarks.XXXXXX) || exit 1
        trap "rm -f -- '$t'" EXIT

        # purge line
        sed "/$2/d" "$1" > "$t"
        mv "$t" "$1"

        # cleanup temp file
        rm -f -- "$t"
        trap - EXIT
    fi
}



if [ $ZSH_VERSION ]; then
	compctl -K _compzsh gt
else
	shopt -s progcomp
	complete -F _comp gt
fi




