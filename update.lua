--[[

ModernCG Update Assist
 (Assists in updating, obviously)

--]]

local HS = game:GetService('HttpService')
local TS = game:GetService('TeleportService')

local APIURL = "https://api.github.com/repos/raymonable/ModernCG/releases"
local fixed_request = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
local ReleaseData = HS:JSONDecode(fixed_request({
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
  Update = function(Installing)
    print('Updating ModernCG!')
    makefolder("modern_cg")
    makefolder("modern_cg/resources")
    local BaseURL = string.format("https://cdn.jsdelivr.net/gh/raymonable/ModernCG@%s/", ReleaseData["tag_name"])
    local AssetsToDownload = HS:JSONDecode(fixed_request({
        Url = BaseURL .. "resources.json",
        Type = "GET" 
    }).Body)
    for OriginalURL, Path in pairs(AssetsToDownload) do
        local FileData = syn.request({
            Url = BaseURL .. OriginalURL,
            Type = "GET" 
        }).Body
        writefile(Path, FileData)
    end
    writefile("modern_cg/ver.sion", ReleaseData["tag_name"])
    print('Download finished!')
    game:Shutdown() -- Shutdown so player has to rejoin
  end
}
