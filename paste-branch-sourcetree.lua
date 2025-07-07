--===========================================================================
--=============PASTE NAME BRANCH IN SOURCETREE -- [CMD+SHIFT+V]==============
--===========================================================================

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

local M = {}

function M.bind()
    -- Assign hotkey Cmd + Shift + V
    return hs.hotkey.bind(
        {"cmd", "shift"},
        "V",
        function()
            local nameBranch = getBranchFromClipboard()
            hs.pasteboard.setContents(nameBranch)
            hs.timer.doAfter(
            0.15,
                function()
                    hs.eventtap.keyStroke({"cmd"}, "v")
                end
            )
        end
    )
end

return M
