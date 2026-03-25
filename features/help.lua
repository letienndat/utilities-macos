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
        local status =
            string.format("%s [%s] %s", info.enabled and "✅" or "❌", info.hotkey, info.enabled and "ON" or "OFF")
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
                hs.alert((newState and "Turn ON" or "Turn OFF") .. " feature: " .. choice.title)
            end
        end
    ):choices(choices):bgDark(true):placeholderText("Search feature (ON / OFF feature in here)"):show()
end

-- Assign hotkey Cmd + Shift + C
hs.hotkey.bind({"cmd", "shift"}, "H", M.show)

return M
