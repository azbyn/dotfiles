f=~/$1
dotfile=~/dotfiles/$1

if [ -h $f ]; then 
	echo link $f already exists
	exit
fi

if [ -f $f ]; then
	mv $f $f.og
	echo created backup: $f.og
elif [ -d $dotfile ]; then
	echo "directory"
	if [ -d $f ]; then
		mv $f $f.og
		echo created backup: $f.og
	fi
fi

ln -s $dotfile $f
echo created link for $f
