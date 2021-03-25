# vim:filetype=sh
xrdb -load $HOME/.Xresources
#xrdb -merge $HOME/.colors/xresources
setxkbmap azb
#numlockx &
xmodmap $HOME/.xmodmaprc

#TODO remove
export QT_FONT_DPI=120
export SHELL=/usr/bin/zsh
#<tadeusz>
xinput set-button-map "TPPS/2 IBM TrackPoint" 1 0 3 4 5 6 7
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
xinput -disable 'SYNAPTICS Synaptics Touch Digitizer V04'

sh ~/.profile
#</tadeusz>


#xcape -e 'ISO_Level3_Shift=backslash' -t 170
#
# turn off default screensaver
xset s off
# turn off default standby, hibernate, ... after n minutes
xset -dpms

session=awesome

case $session in
	awesome|awesomewm )
		touch /tmp/awesome_just_started
		exec awesome;;
	# No known session, try to run it as command
	*                 ) exec $1;;
esac

