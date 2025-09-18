function dianoche --description "Toggle between light/dark GTK theme"

	set --local GTK_SETTINGS   -- "$HOME/.config/gtk-3.0/settings.ini"
	set --local GTK_THEME_NAME -- (cat $GTK_SETTINGS | string match --entire gtk-theme-name)

	if string match --quiet --regex 'dark$' $GTK_THEME_NAME
		sed '/gtk-theme-name/s/-dark$//' -i $GTK_SETTINGS
	else
		sed '/gtk-theme-name/s/$/-dark/' -i $GTK_SETTINGS
	end

	import-gsettings &>/dev/null
end
