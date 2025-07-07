local features = {
    clipboard_manager = {
        title = "Clipboard Manager",
        description = "Hiển thị và dán lịch sử clipboard",
        hotkey = "Cmd + Shift + C",
        enabled = true,
        module = "clipboard-manager"
    },
    paste_branch_sourcetree = {
        title = "Paste Git Branch",
        description = "Dán phần cuối tên nhánh git",
        hotkey = "Cmd + Shift + V",
        enabled = true,
        module = "paste-branch-sourcetree"
    },
    open_terminal = {
        title = "Open Current Folder With Terminal",
        description = "Mở thư mục hiện tại ở Finder với Terminal",
        hotkey = "Cmd + Shift + T",
        enabled = true,
        module = "open-terminal"
    }
}

local hotkeyRefs = {}

local function loadFeature(name)
    local info = features[name]
    if not info then
        return
    end
    local mod = require(info.module)
    if type(mod.bind) == "function" then
        hotkeyRefs[name] = mod.bind()
    end
end

local function unloadFeature(name)
    if hotkeyRefs[name] then
        hotkeyRefs[name]:disable()
        hotkeyRefs[name]:delete()
        hotkeyRefs[name] = nil
    end
end

local function toggleFeature(name, on)
    unloadFeature(name)
    if on then
        loadFeature(name)
    end
    features[name].enabled = on
end

local function initAll()
    for name, f in pairs(features) do
        if f.enabled then
            loadFeature(name)
        end
    end
end

local function getFeatureList()
    return features
end

return {
    toggleFeature = toggleFeature,
    getFeatureList = getFeatureList,
    initAll = initAll
}
