--===================================================================
--=============MENU HELP -- [CMD+SHIFT+H]============================
--===================================================================

local features = require("features")

local M = {}

function M.show()
    local list = features.getFeatureList()
    local choices = {}
    local numberLinesSubText = 5

    for key, info in pairs(list) do
        local status = string.format("%s [%s] %s", info.enabled and "✅" or "❌", info.hotkey, info.enabled and "Đang bật" or "Đã tắt")
        local subTextFormatted = features.trimToNumberLines(info.description, numberLinesSubText)

        table.insert(
            choices,
            {
                title = info.title,
                text = string.format("%s: %s", status, info.title),
                subText = "\n" .. subTextFormatted,
                uuid = key
            }
        )
    end

    hs.chooser.new(
        function(choice)
            if choice then
                local key = choice.uuid
                local newState = not list[key].enabled
                features.toggleFeature(key, newState)
                hs.alert((newState and "Đã bật" or "Đã tắt") .. " feature: " .. choice.title)
            end
        end
    )
        :choices(choices)
        :placeholderText("Tìm feature (Ở đây chỉ BẬT/TẮT feature)")
        :show()
end

-- Assign hotkey Cmd + Shift + C
hs.hotkey.bind(
    { "cmd", "shift" },
    "H",
    M.show
)

return M
