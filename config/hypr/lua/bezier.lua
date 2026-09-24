-- ~/.config/hypr/lua/bezier.lua

-- https://easings.net/

hl.curve("overshot",       { type = "bezier", points = { {0.05, 0.90}, {0.10, 1.00} } })
hl.curve("overshotIn",     { type = "bezier", points = { {0.05, 0.90}, {0.10, 1.00} } })
hl.curve("overshotOut",    { type = "bezier", points = { {0.05, -1.0}, {0.10, 1.00} } })

hl.curve("easeInSine",     { type = "bezier", points = { {0.12, 0.00}, {0.39, 0.00} } })
hl.curve("easeOutSine",    { type = "bezier", points = { {0.61, 1.00}, {0.88, 1.00} } })
hl.curve("easeInOutSine",  { type = "bezier", points = { {0.37, 0.00}, {0.63, 1.00} } })

hl.curve("easeInQuad",     { type = "bezier", points = { {0.11, 0.00}, {0.50, 0.00} } })
hl.curve("easeOutQuad",    { type = "bezier", points = { {0.50, 1.00}, {0.89, 1.00} } })
hl.curve("easeInOutQuad",  { type = "bezier", points = { {0.45, 0.00}, {0.55, 1.00} } })

hl.curve("easeInCubic",    { type = "bezier", points = { {0.32, 0.00}, {0.67, 0.00} } })
hl.curve("easeOutCubic",   { type = "bezier", points = { {0.33, 1.00}, {0.68, 1.00} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.00}, {0.35, 1.00} } })

hl.curve("easeInQuart",    { type = "bezier", points = { {0.50, 0.00}, {0.75, 0.00} } })
hl.curve("easeOutQuart",   { type = "bezier", points = { {0.25, 1.00}, {0.50, 1.00} } })
hl.curve("easeInOutQuart", { type = "bezier", points = { {0.76, 0.00}, {0.24, 1.00} } })

hl.curve("easeInQuint",    { type = "bezier", points = { {0.64, 0.00}, {0.78, 0.00} } })
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.22, 1.00}, {0.36, 1.00} } })
hl.curve("easeInOutQuint", { type = "bezier", points = { {0.83, 0.00}, {0.17, 1.00} } })

hl.curve("easeInExpo",     { type = "bezier", points = { {0.70, 0.00}, {0.84, 0.00} } })
hl.curve("easeOutExpo",    { type = "bezier", points = { {0.16, 1.00}, {0.30, 1.00} } })
hl.curve("easeInOutExpo",  { type = "bezier", points = { {0.87, 0.00}, {0.13, 1.00} } })

hl.curve("easeInCirc",     { type = "bezier", points = { {0.55, 0.00}, {1.00, 0.45} } })
hl.curve("easeOutCirc",    { type = "bezier", points = { {0.00, 0.55}, {0.45, 1.00} } })
hl.curve("easeInOutCirc",  { type = "bezier", points = { {0.85, 0.00}, {0.15, 1.00} } })

hl.curve("easeInBack",     { type = "bezier", points = { {0.36, 0.00}, {0.66, -0.56} } })
hl.curve("easeOutBack",    { type = "bezier", points = { {0.34, 1.56}, {0.64, 1.00} } })
hl.curve("easeInOutBack",  { type = "bezier", points = { {0.68, -0.6}, {0.32, 1.60} } })
