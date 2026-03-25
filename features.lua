local features = {
    clipboard_manager = {
        title = "Clipboard Manager",
        description = "Show history clipboard (Max 100 items)",
        hotkey = "Cmd + Shift + C",
        enabled = true,
        module = "features.clipboard-manager"
    }
}

local loadedModules = {}

local stateFile = (hs and hs.configdir and (hs.configdir .. "/feature-state.json")) or "feature-state.json"

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

local function serializeState()
    local enabledMap = {}
    for name, info in pairs(features) do
        enabledMap[name] = info.enabled and true or false
    end
    return {
        features = enabledMap
    }
end

local function saveState()
    if not (hs and hs.json and hs.json.encode) then
        return false
    end
    local payload = serializeState()
    local ok, encoded = pcall(hs.json.encode, payload)
    if not ok or type(encoded) ~= "string" then
        return false
    end
    return writeFileAtomic(stateFile, encoded)
end

local function loadState()
    if not (hs and hs.json and hs.json.decode) then
        return false
    end
    local raw = readFile(stateFile)
    if not raw or raw == "" then
        return false
    end

    local ok, decoded = pcall(hs.json.decode, raw)
    if not ok or type(decoded) ~= "table" then
        return false
    end

    local enabledMap = decoded.features
    if type(enabledMap) ~= "table" then
        enabledMap = decoded
    end

    if type(enabledMap) ~= "table" then
        return false
    end
    for name, enabled in pairs(enabledMap) do
        if features[name] and type(enabled) == "boolean" then
            features[name].enabled = enabled
        end
    end
    return true
end

local function ensureStateFileExists()
    if not (hs and hs.fs and hs.fs.attributes) then
        return
    end
    if hs.fs.attributes(stateFile) == nil then
        saveState()
    end
end

local function loadFeature(name)
    local info = features[name]
    if not info then
        return
    end

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
    saveState()
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

loadState()
ensureStateFileExists()

return {
    toggleFeature = toggleFeature,
    getFeatureList = getFeatureList,
    initAll = initAll,
    trimToNumberLines = trimToNumberLines
}
