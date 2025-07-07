--============================================================================
--=============OPEN CURRENT FOLDER WITH TERMINAL -- [CMD+SHIFT+T]=============
--============================================================================

-- Get the path of the folder currently open in Finder
local function getCurrentFolderInFinder()
    local _, output =
        hs.osascript.applescript(
        [[
        tell application "Finder"
            try
                set thePath to (POSIX path of (target of front window as alias))
                return thePath
            on error
                return ""
            end try
        end tell
    ]]
    )
    return output
end

-- Open Terminal.app in this path
local function openTerminalAt(path)
    if path ~= "" then
        local script =
            [[
            tell application "Terminal"
                if not (exists window 1) then reopen
                do script "cd ']] ..
            path .. [['" in front window
                activate
            end tell
        ]]
        hs.osascript.applescript(script)
    else
        hs.alert("There are no open folders in Finder")
    end
end

local M = {}

function M.bind()
    -- Assign hotkey Cmd + Shift + T
    return hs.hotkey.bind(
        {"cmd", "shift"},
        "T",
        function()
            local folder = getCurrentFolderInFinder()
            openTerminalAt(folder)
        end
    )
end

return M
