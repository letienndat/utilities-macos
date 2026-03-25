-- ==================================================================================================
-- =============CLIPBOARD-MANAGER - SHOW LIST TEXT COPIED -- [CMD+SHIFT+C]===========================
-- ==================================================================================================
local features = require("features")

local M = {}

local clipboardHistory = {}
local maxHistorySize = 100
local numberLinesSubText = 3

local historyFile = (hs and hs.configdir and (hs.configdir .. "/clipboard-history.json")) or "clipboard-history.json"
local nextId = 1
local saveTimer = nil

local watcher = nil
local hotkey = nil

local function readFile(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*a")
    f:close()
    return content
end

local function writeFileAtomic(path, content)
    local tmpPath = path .. ".tmp"
    local f = io.open(tmpPath, "w")
    if not f then
        return false
    end
    f:write(content)
    f:close()
    os.rename(tmpPath, path)
    return true
end

local function normalizeHistoryItem(item)
    if type(item) == "string" then
        local id = nextId
        nextId = nextId + 1
        return {
            id = id,
            value = item
        }
    end

    if type(item) == "table" and type(item.value) == "string" then
        local id = tonumber(item.id)
        if not id then
            id = nextId
            nextId = nextId + 1
        end

        return {
            id = id,
            value = item.value
        }
    end

    return nil
end

local function serializeHistory()
    return {
        nextId = nextId,
        items = clipboardHistory
    }
end

local function saveHistoryNow()
    if not (hs and hs.json and hs.json.encode) then
        return false
    end
    local payload = serializeHistory()
    local ok, encoded = pcall(hs.json.encode, payload)
    if not ok or type(encoded) ~= "string" then
        return false
    end
    return writeFileAtomic(historyFile, encoded)
end

local function scheduleSave()
    if saveTimer then
        saveTimer:stop()
    end
    saveTimer =
        hs.timer.doAfter(
        0.25,
        function()
            saveTimer = nil
            saveHistoryNow()
        end
    )
end

local function loadHistory()
    if not (hs and hs.json and hs.json.decode) then
        return false
    end
    local raw = readFile(historyFile)
    if not raw or raw == "" then
        return false
    end

    local ok, decoded = pcall(hs.json.decode, raw)
    if not ok or type(decoded) ~= "table" then
        return false
    end

    local items = decoded.items
    if type(items) ~= "table" then
        items = decoded
    end
    if type(items) ~= "table" then
        return false
    end

    clipboardHistory = {}
    nextId = tonumber(decoded.nextId) or 1
    local maxSeenId = 0

    for _, rawItem in ipairs(items) do
        local item = normalizeHistoryItem(rawItem)
        if item and item.value ~= "" then
            table.insert(clipboardHistory, item)
            if item.id > maxSeenId then
                maxSeenId = item.id
            end
        end
    end

    if nextId <= maxSeenId then
        nextId = maxSeenId + 1
    end
    if #clipboardHistory > maxHistorySize then
        while #clipboardHistory > maxHistorySize do
            table.remove(clipboardHistory, 1)
        end
    end
    return true
end

local function ensureHistoryFileExists()
    if not (hs and hs.fs and hs.fs.attributes) then
        return
    end
    if hs.fs.attributes(historyFile) == nil then
        saveHistoryNow()
    end
end

local function onClipboardChange()
    local content = hs.pasteboard.getContents()
    if content and content ~= "" then
        local last = clipboardHistory[#clipboardHistory]
        local lastValue = (type(last) == "table") and last.value or last
        if content ~= lastValue then
            local item = {
                id = nextId,
                value = content
            }
            nextId = nextId + 1
            table.insert(clipboardHistory, item)
            if #clipboardHistory > maxHistorySize then
                table.remove(clipboardHistory, 1)
            end
            scheduleSave()
        end
    end
end

-- Start watcher + bind hotkey
function M.start()
    loadHistory()
    ensureHistoryFileExists()

    if not watcher then
        watcher = hs.pasteboard.watcher.new(onClipboardChange)
    end
    watcher:start()

    if not hotkey then
        -- Assign hotkey Cmd + Shift + C
        hotkey =
            hs.hotkey.bind(
            {"cmd", "shift"},
            "C",
            function()
                if #clipboardHistory == 0 then
                    hs.alert("Clipboard is empty")
                    return
                end

                local choices = {}
                for i = #clipboardHistory, 1, -1 do
                    local item = clipboardHistory[i]
                    local text = (type(item) == "table") and item.value or tostring(item)
                    local preview = text:gsub("[\n\r]", " ")
                    if #preview > 100 then
                        preview = preview:sub(1, 100) .. "..."
                    end
                    local textTrim = features.trimToNumberLines(text, numberLinesSubText)
                    table.insert(
                        choices,
                        {
                            text = preview,
                            subText = "\n" .. textTrim,
                            value = text,
                            id = (type(item) == "table") and item.id or nil
                        }
                    )
                end

                hs.chooser.new(
                    function(choice)
                        if not choice then
                            return
                        end
                        local value = choice.value or choice.subText or choice.text
                        hs.pasteboard.setContents(value)
                        hs.timer.doAfter(
                            0.15,
                            function()
                                hs.eventtap.keyStroke({"cmd"}, "v")
                            end
                        )
                    end
                ):choices(choices):bgDark(true):placeholderText("Search item"):searchSubText(true):show()
            end
        )
    end
end

-- Stop watcher + unbind hotkey
function M.stop()
    if watcher then
        watcher:stop()
    end
    if saveTimer then
        saveTimer:stop()
        saveTimer = nil
        saveHistoryNow()
    end
    if hotkey then
        hotkey:delete()
        hotkey = nil
    end
end

return M
