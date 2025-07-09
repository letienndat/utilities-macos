--============================================================================
--=============OPEN CURRENT FOLDER WITH TERMINAL -- [CMD+SHIFT+T]=============
--============================================================================

local M = {}

local hotkey = nil

-- Get the path of the folder currently open in Finder
local function getCurrentFolderInFinder()
    local ok, path = hs.osascript.applescript([[
        tell application "Finder"
            if (count of windows) = 0 then
                return ""
            else
                return POSIX path of (target of front window as alias)
            end if
        end tell
    ]])
    if ok and path ~= "" then
        return path
    else
        return nil
    end
end

-- Open Terminal.app in this path (always new window)
local function openTerminalAt(path)
    local script =
    (path and string.format([[
        if application "Terminal" is running then
            tell application "Terminal"
                do script "cd '%s'"
                activate
            end tell
        else
            tell application "Terminal"
                activate
                repeat until exists window 1
                    delay 0.1
                end repeat
                do script "cd '%s'" in window 1
            end tell
        end if
    ]], path, path)) or [[
        if application "Terminal" is running then
            tell application "Terminal"
                do script ""
                activate
            end tell
        else
            tell application "Terminal"
                activate
                repeat until exists window 1
                    delay 0.1
                end repeat
            end tell
        end if
    ]]
    hs.osascript.applescript(script)
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
