local features = require("features")

hs.hotkey.bind(
    {"cmd", "shift"},
    "H",
    function()
        local list = features.getFeatureList()
        local choices = {}

        for key, info in pairs(list) do
            local status = info.enabled and "✅ Đang bật: " or "❌ Đã tắt: "
            table.insert(
                choices,
                {
                    title = info.title,
                    text = string.format("%s %s -- %s", status, info.title, info.hotkey),
                    subText = info.description,
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
)
