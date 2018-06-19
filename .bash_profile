#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


ANDROID_NDK_HOME=~/Android/Sdk/ndk-bundle
PATH=~/bin:~/Android/Sdk/tools/bin:~/Android/Sdk/tools/:~/Android/Sdk/ndk-bundle:$PATH

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec startx
fi
