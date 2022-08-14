--[[

ModernCG Update Assist
 (Assists in updating, obviously)

--]]

local BaseURL = "https://cdn.jsdelivr.net/gh/raymonable/ModernCG/"
local APIURL = "https://api.github.com/repos/raymonable/ModernCG/releases"
local ReleaseData = HS:JSONDecode(syn.request({
    Url = APIURL,
    Type = "GET" 
}).Body)[1] -- Gets the latest release data

return {
  CheckForUpdates = function()
    if isfile("modern_cg/ver.sion") then
      local CurrentVersion = readfile("modern_cg/ver.sion")
      return not tostring(CurrentVersion) == ReleaseData["tag_name"]
    else
      return true
    end
  end,
  Update = function()
    local AssetsToDownload = HS:JSONDecode(syn.request({
        Url = BaseURL .. "resources.json",
        Type = "GET" 
    }).Body)
    for OriginalURL, Path in pairs(AssetsToDownload) do
        local FileData = syn.request({
            Url = BaseURL .. OriginalURL,
            Type = "GET" 
        }).Body
        writefile(Path, FileData)
        print(OriginalURL)
    end
  end
}
