function fish_user_key_bindings
	fzf_key_bindings

	function __ctrl_z_handler
		if jobs -q
			fg
		else
			commandline -f undo
		end
	end
	bind ctrl-z __ctrl_z_handler
end
