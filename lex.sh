#!/bin/bash

usage() {
	echo "Usage:"
	echo "    lex.sh [OPTIONS] FILENAME"
	echo
	echo "Options:"
	echo "    --gcc Use the gcc preprocessor"
	echo
	echo "More info at:"
	echo "https://github.com/juanmisak/Analizador-Lexico"
	echo
}

while test "$1" != "" ; do
	case $1 in
		--gcc)
			GCC=1
		;;
		-*)
			echo "error: no such option $1"
			usage
			exit 1
		;;
		*)
			FILE=$1
		;;
	esac
	shift
done

test "$FILE" == "" && usage

if [ ! -r "$FILE" ]
then
	echo "error: file not readable"
	usage
	exit 1
fi

if [ -r "./lex" ]
then
	LEX='./lex'
else
	LEX='runhaskell lex.hs'
fi

if [ "$GCC" == 1 ]
then
	gcc -E $FILE | $LEX
else
	cat $FILE | sed -e 's/^#.*//' | sed -e 's/\/\/.*//' | $LEX
fi
