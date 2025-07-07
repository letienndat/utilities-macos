local features = {
    clipboard_manager = {
        title = "Clipboard Manager",
        description = "Hiển thị và dán lịch sử clipboard (Tối đa 50 mục)",
        hotkey = "Cmd + Shift + C",
        enabled = true,
        module = "features.clipboard-manager"
    },
    paste_branch_sourcetree = {
        title = "Paste Git Branch",
        description = "Dán phần cuối tên nhánh git (Sử dụng đối với Sourcetree)",
        hotkey = "Cmd + Shift + V",
        enabled = true,
        module = "features.paste-branch-sourcetree"
    },
    open_terminal = {
        title = "Open Current Folder With Terminal",
        description = "Mở thư mục hiện tại ở Finder với Terminal",
        hotkey = "Cmd + Shift + T",
        enabled = true,
        module = "features.open-terminal"
    }
}

local loadedModules = {}

local function loadFeature(name)
    local info = features[name]
    if not info then return end

    local mod = require(info.module)
    if mod and type(mod.start) == "function" then
        loadedModules[name] = mod
        mod.start()
    end
end

local function unloadFeature(name)
    local mod = loadedModules[name]
    if mod and type(mod.stop) == "function" then
        mod.stop()
        loadedModules[name] = nil
    end
end

local function toggleFeature(name, on)
    if on then
        loadFeature(name)
    else
        unloadFeature(name)
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