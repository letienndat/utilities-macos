--===========================================================================
--=============PASTE NAME BRANCH IN SOURCETREE -- [CMD+SHIFT+V]==============
--===========================================================================

local M = {}

local hotkey = nil

-- Split string with delimiter
local function split(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Get last name branch from name branch splited
local function getBranchFromClipboard()
    local clip = hs.pasteboard.getContents()
    local splitStr = split(clip, "/")
    local last = splitStr[#splitStr]
    return last
end

-- Start feature
function M.start()
    if not hotkey then
        -- Assign hotkey Cmd + Shift + V - Can permission Accessibility (access in settings macos)
        hotkey = hs.hotkey.bind({ "cmd", "shift" }, "V", function()
            local nameBranch = getBranchFromClipboard()
            hs.pasteboard.setContents(nameBranch)
            hs.timer.doAfter(0.2, function()
                hs.eventtap.keyStroke({ "cmd" }, "v")
            end)
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
