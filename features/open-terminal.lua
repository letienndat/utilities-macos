--============================================================================
--=============OPEN CURRENT FOLDER WITH TERMINAL -- [CMD+SHIFT+T]=============
--============================================================================

local M = {}

local hotkey = nil

-- Get the path of the folder currently open in Finder
local function getCurrentFolderInFinder()
    local _, output = hs.osascript.applescript([[
        tell application "Finder"
            try
                set thePath to (POSIX path of (target of front window as alias))
                return thePath
            on error
                return ""
            end try
        end tell
    ]])
    return output
end

-- Open Terminal.app in this path (always new window)
local function openTerminalAt(path)
    if path ~= "" then
        local script = [[
            tell application "Terminal"
                if not running then
                    reopen
                    repeat until exists window 1
                        delay 0.1
                    end repeat
                    do script "cd ']] .. path .. [['" in window 1
                else
                    do script "cd ']] .. path .. [['"
                    do script "clear" in (do script "")
                end if
                activate
            end tell
        ]]
        hs.osascript.applescript(script)
    else
        hs.alert("There are no open folders in Finder")
    end
end

-- Start feature
function M.start()
    if not hotkey then
        -- Assign hotkey Cmd + Shift + T
        hotkey = hs.hotkey.bind({ "cmd", "shift" }, "T", function()
            local folder = getCurrentFolderInFinder()
            openTerminalAt(folder)
        end)
    end
end

-- Stop feature
function M.stop()
    if hotkey then
        hotkey:delete()
        hotkey = nil
    end
end

return M
