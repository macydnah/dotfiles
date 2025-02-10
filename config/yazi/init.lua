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
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Span("[" .. ya.user_name() .. "@" .. ya.host_name() .. "]"):fg("green")
end, 500, Header.LEFT)

-- [Show symlink in status bar](https://yazi-rs.github.io/docs/tips/#symlink-in-status)
function Status:name()
	local h = self._tab.current.hovered
	if not h then
		return ui.Line {}
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Line(" " .. h.name .. linked)
end
