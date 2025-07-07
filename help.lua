local features = require("features")

hs.hotkey.bind(
    {"cmd", "shift"},
    "H",
    function()
        local list = features.getFeatureList()
        local choices = {}

        for key, info in pairs(list) do
            local status = info.enabled and "✅" or "❌"
            table.insert(
                choices,
                {
                    title = info.title,
                    text = string.format("%s %s", status, info.title),
                    subText = info.description .. " – " .. info.hotkey,
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
                    hs.alert((newState and "Enable" or "Disable") .. " Feature `" .. choice.title .. "` Successfully")
                end
            end
        )
        :choices(choices)
        :placeholderText("Enter name feature")
        :show()
    end
)
