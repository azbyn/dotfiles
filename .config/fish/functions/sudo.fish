function sudo
	if test "$argv" = !!
		echo "sudo -E" $history[1]
		eval command 'sudo' '-E' $history[1]
	else
		command "sudo" "-E" $argv
	end
end

