local help = require("help")
local menubar = hs.menubar.new()

if menubar then
    menubar:setTitle("📋")
    menubar:setMenu({
        { title = "Reload Config", fn = function() hs.reload() end },
        { title = "-" },
        { title = "Help",          fn = function() help.show() end },
        { title = "Force Quit",    fn = function() hs.application.get("Hammerspoon"):kill() end }
    })
end
