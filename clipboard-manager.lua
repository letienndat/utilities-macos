--==================================================================================================
--=============CLIPBOARD-MANAGER - SHOW LIST TEXT COPIED -- [CMD+SHIFT+C]===========================
--==================================================================================================

-- Clipboard history table
local clipboardHistory = {}
local maxHistorySize = 50

-- Clipboard watcher
local watcher = hs.pasteboard.watcher.new(function()
    local content = hs.pasteboard.getContents()
    if content and content ~= "" then
        local last = clipboardHistory[#clipboardHistory]
        if content ~= last then
            table.insert(clipboardHistory, content)
            if #clipboardHistory > maxHistorySize then
                table.remove(clipboardHistory, 1)
            end
        end
    end
end)

watcher:start()

-- Assign hotkey Cmd + Shift + C
hs.hotkey.bind({"cmd", "shift"}, "C", function()
    if #clipboardHistory == 0 then
        hs.alert("Clipboard nil")
        return
    end

    local choices = {}
    for i = #clipboardHistory, 1, -1 do
        local text = clipboardHistory[i]
        local preview = text:gsub("[\n\r]", " ")
        if #preview > 100 then preview = preview:sub(1, 100) .. "…" end
        table.insert(choices, { text = preview, subText = text })
    end

    hs.chooser
        .new(function(choice)
            if not choice then return end
            local value = choice.subText or choice.text
            hs.pasteboard.setContents(value)
            hs.timer.doAfter(0.15, function()
                hs.eventtap.keyStroke({"cmd"}, "v")
            end)
        end)
        :choices(choices)
        :placeholderText("Enter value of paste")
        :searchSubText(true)
        :show()
end)