-- [Cross-instance Yank](https://yazi-rs.github.io/docs/dds/#session.lua)
require("session"):setup {
	sync_yanked = true,
}

-- [Folder-specific rules](https://yazi-rs.github.io/docs/tips/#folder-rules)
require("folder-rules"):setup()

-- [Show full border](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi#usage)
--[[
require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}
--]]

-- [Show username and hostname in header](https://yazi-rs.github.io/docs/tips/#username-hostname-in-header)
--[[
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Span("[" .. ya.user_name() .. "@" .. ya.host_name() .. "]"):fg("green")
end, 500, Header.LEFT)
--]]

-- [Show symlink in status bar](https://yazi-rs.github.io/docs/tips/#symlink-in-status)
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)
