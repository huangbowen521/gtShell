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
			CURDIR=$(echo $PWD| sed "s#^$HOME#\$HOME#g")
			echo "$2=$CURDIR" >> $DIRS
			;;
		-l)
			cat $DIRS
			;;
		*)   
			cd "$(awk -F '=' '/^$1=/ {print $2 }' $DIRS)"
	esac
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




