# vim:filetype=sh
xrdb -load $HOME/.Xresources
xrdb -merge $HOME/.colors/xresources
setxkbmap ro
#numlockx &
xmodmap ~/.xmodmaprc
#
# turn off default screensaver
xset s off
# turn off default standby, hibernate, ... after n minutes
xset -dpms

session=${1:-awesome}

case $session in
	awesome|awesomewm )
		touch /tmp/awesome_just_started
		exec awesome;;
	# No known session, try to run it as command
	*                 ) exec $1;;
esac

