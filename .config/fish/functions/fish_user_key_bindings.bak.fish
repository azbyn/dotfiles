function fish_user_key_bindings
	fish_vi_key_bindings
	
	#set fish_key_bindings fish_default_key_bindings
	#__fish_shared_key_bindings
	#vi inspired
	bind \n execute
	bind \r execute

	bind \ch backward-char
	bind \cj down-or-search

	bind \ck up-or-search
	bind \cl forward-char

	bind \cH backward-char
	bind \cJ backward-char
	bind \cK backward-char
	bind \cL forward-char
	
	bind \c[ history-token-search-backward
	bind \c] history-token-search-forward

	bind \cu history-search-backward
	bind \cr history-search-forward
	
	bind \cs history-search-forward beginning-of-buffer

	bind -k home beginning-of-line 2>/dev/null
	bind -k end end-of-line 2>/dev/null

	bind \cb backward-word
	bind \cB backward-bigword
	bind \cp forward-char
	bind \cP complete
	bind \ci beginning-of-line
	bind \cI beginning-of-buffer
	bind \ca end-of-line
	bind \cA end-of-buffer
	bind \cd kill-whole-line
	bind \cc kill-word force-repaint
	bind \cC kill-bigword force-repaint
	bind \cw forward-word forward-char
	bind \cW forward-bigword forward-char
	bind \ce forward-char forward-word backward-char
	bind \cE forward-bigword backward-char

	bind \cx forward-char delete-char
	bind \cX backward-delete-char

end

