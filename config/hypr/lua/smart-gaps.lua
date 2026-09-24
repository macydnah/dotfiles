-- ~/.config/hypr/lua/smart-gaps.lua

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/#smart-gaps-ignoring-special-workspaces

hl.workspace_rule({ workspace = "w[tv1]s[false]",
  gaps_out = 0,
  gaps_in = 0,
  no_shadow = true,
})
hl.workspace_rule({ workspace = "f[1]s[false]",
  gaps_out = 0,
  gaps_in = 0,
  no_shadow = true,
})
hl.window_rule({ match = { workspace = "w[tv1]s[false]", float = false },
  border_size = 0,
  -- rounding = 0,
})
hl.window_rule({ match = { workspace = "f[1]s[false]",   float = false },
  border_size = 0,
  -- rounding = 0,
})
