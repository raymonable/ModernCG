local CG = game:GetService('CoreGui')
local TS = game:GetService('TweenService')

local _PlaceIcon
local _PlaceLabel
local _Loaders
local OverlayGui
local LoadingAudio
local Demojify

pcall(function() -- Wrapping it in a pcall so if it can't find what it needs, it doesn't error
    coroutine.wrap(function()
        while true do
            if CG:FindFirstChild('RobloxLoadingGui') then
                CG:FindFirstChild('RobloxLoadingGui').IgnoreGuiInset = true
                if CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('BlackFrame') then
                    if CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('BlackFrame').Visible then
                        -- Add new gui.
                        local RealOverlayGui = Instance.new('ScreenGui', CG)
                        RealOverlayGui.IgnoreGuiInset = true
                        RealOverlayGui.DisplayOrder = 1000
                        OverlayGui = Instance.new('Frame', RealOverlayGui)--CG:FindFirstChild('RobloxLoadingGui'))
                        OverlayGui.Size = UDim2.new(1, 0, 1, 0)
                        OverlayGui.ZIndex = 10
                        OverlayGui.BackgroundColor3 = Color3.fromRGB(9, 12, 17)
                        LoadingAudio = Instance.new('Sound', workspace)
                        LoadingAudio.Looped = true
                        LoadingAudio.SoundId = getsynasset('modern_cg/resources/load.wav')
                        LoadingAudio.Playing = true
                        LoadingAudio.Volume = 0.25
                        local PlaceIcon = Instance.new('ImageLabel', OverlayGui)
                        PlaceIcon.Position = UDim2.new(0, 0, 0.85 + 0.5, 0)
                        PlaceIcon.Size = UDim2.new(0.15, 0, 0.125, 0)
                        PlaceIcon.ScaleType = "Fit"
                        PlaceIcon.BackgroundTransparency = 1
                        PlaceIcon.AnchorPoint = Vector2.new(0, 0.5)
                        PlaceIcon.Image = ""
                        PlaceIcon.ZIndex = 15
                        PlaceIcon.ImageTransparency = 1
                        _PlaceIcon = PlaceIcon
                        Instance.new('UICorner', PlaceIcon).CornerRadius = UDim.new(0, 8)
                        local PlaceLabel = Instance.new('TextLabel', OverlayGui)
                        PlaceLabel.Size = UDim2.new(0.75, 0, 0.075, 0)
                        PlaceLabel.Position = UDim2.new(0.15, 0, 0.85 + 0.5, 0)
                        PlaceLabel.Text = ""
                        PlaceLabel.Font = Enum.Font.Roboto
                        PlaceLabel.TextScaled = true
                        PlaceLabel.TextWrapped = true
                        PlaceLabel.TextXAlignment = Enum.TextXAlignment.Left
                        PlaceLabel.TextColor3 = Color3.fromRGB(248, 248, 248)
                        PlaceLabel.BackgroundTransparency = 1
                        PlaceLabel.ZIndex = 15
                        PlaceLabel.TextTransparency = 1
                        _PlaceLabel = PlaceLabel
                        local LoaderContainer = Instance.new('Frame', OverlayGui)
                        LoaderContainer.Position = UDim2.new(0.95, 0, 0.9 + 0.5, 0)
                        LoaderContainer.Size = UDim2.new(0, 0, 0, 0)
                        LoaderContainer.BackgroundTransparency = 1
                        LoaderContainer.ZIndex = 15
                        local Loaders = {}
                        for i = 1, 3 do
                            local Loader = Instance.new('Frame', LoaderContainer) 
                            Loader.Position = UDim2.new(0, 15 * (i - 1), 0, 0)
                            Loader.Size = UDim2.new(0, 10, 0, 10)
                            Loader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Loader.AnchorPoint = Vector2.new(0.5, 0.5)
                            Loader.BackgroundTransparency = 1
                            Loader.ZIndex = 15
                            Instance.new('UICorner', Loader).CornerRadius = UDim.new(0, 2)
                            TS:Create(Loader, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
                            local _i = i
                            table.insert(Loaders, Loader)
                        end
                        coroutine.wrap(function()
                            while true do
                                for i = 1, 3 do
                                    local _Loader = Loaders[i]
                                    if _Loader then
                                        TS:Create(_Loader, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true), {Position = _Loader.Position + UDim2.new(0, 0, 0, -25)}):Play()
                                        wait(0.5)  
                                    end
                                end 
                            end
                        end)()
                        _Loaders = LoaderContainer
                    end
                    CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('BlackFrame').Visible = false
                end
                if _PlaceLabel and CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('PlaceLabel', true) and Demojify then
                    _PlaceLabel.Text = Demojify(CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('PlaceLabel', true).Text:lower())
                end
                if _PlaceIcon and CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('PlaceIcon', true) then
                    _PlaceIcon.Image = CG:FindFirstChild('RobloxLoadingGui'):FindFirstChild('PlaceIcon', true).Image 
                end
            end
            task.wait()
        end 
    end)()
    coroutine.wrap(function()
        repeat wait() until _PlaceIcon and _PlaceLabel and _Loaders
        TS:Create(_PlaceLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 0, Position = _PlaceLabel.Position + UDim2.new(0, 0, -0.5, 0)}):Play()
        TS:Create(_PlaceIcon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {ImageTransparency = 0, Position = _PlaceIcon.Position + UDim2.new(0, 0, -0.5, 0)}):Play()
        TS:Create(_Loaders, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = _Loaders.Position + UDim2.new(0, 0, -0.5, 0)}):Play()
        for _, Loader in pairs(_Loaders:GetChildren()) do TS:Create(Loader, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {BackgroundTransparency = 0}):Play() end
        repeat wait() until game:IsLoaded()
        wait(1.5)
        TS:Create(_PlaceLabel, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1, Position = _PlaceLabel.Position + UDim2.new(0, 0, 0.5, 0)}):Play()
        TS:Create(_PlaceIcon, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = _PlaceIcon.Position + UDim2.new(0, 0, 0.5, 0)}):Play()
        TS:Create(_Loaders, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = _Loaders.Position + UDim2.new(0, 0, 0.5, 0)}):Play()
        for _, Loader in pairs(_Loaders:GetChildren()) do TS:Create(Loader, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play() end
        TS:Create(LoadingAudio, TweenInfo.new(1), {Volume = 0}):Play()
        wait(0.5)
        OverlayGui.Active = false
        OverlayGui.Selectable = false
        TS:Create(OverlayGui, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        wait(0.5)
        OverlayGui.Parent:Destroy()
        LoadingAudio:Destroy()
    end)()
end)

local UpdateAssist
if isfile("modern_cg/update_as.sist") then
    UpdateAssist = loadstring(readfile("modern_cg/update_as.sist"))()
else
    UpdateAssist = loadstring(game:HttpGet("https://cdn.jsdelivr.net/gh/raymonable/ModernCG@latest/update.lua"))()
end
if UpdateAssist.CheckForUpdates() then
    -- Update.
    return UpdateAssist.Update(isfile("modern_cg/ver.sion"))
end
local Modules = loadstring(readfile("modern_cg/mod.ules"))()
local Demojify_Cache = {}
Demojify = function(String)
    if Demojify_Cache[String] then
    else
        Demojify_Cache[String] = Modules.Demojify(String)
    end
    return Demojify_Cache[String]
end
local RBXM = Modules.Rbxm()

coroutine.wrap(function()
    local ModernModule = RBXM.require(RBXM.launch('modern_cg/mcg.rbxm'))
    ModernModule.inject()
end)()
