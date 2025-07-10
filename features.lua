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
        description = "Mở Terminal với đường dẫn hiện tại ở Finder",
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

local function trimToNumberLines(text, numberLines)
    text = tostring(text or "")
    numberLines = numberLines or 5
    local lines = {}
    for line in text:gmatch("[^\n]+") do
        table.insert(lines, line)
    end

    if #lines > numberLines then
        local trimmed = {}
        for i = 1, numberLines do
            table.insert(trimmed, lines[i])
        end
        trimmed[numberLines] = trimmed[numberLines] .. "…"
        return table.concat(trimmed, "\n")
    else
        return text
    end
end

return {
    toggleFeature = toggleFeature,
    getFeatureList = getFeatureList,
    initAll = initAll,
    trimToNumberLines = trimToNumberLines
}