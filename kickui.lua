return function(args)
    args = args or {}
    title = args[1] or "nil"
    description = args[2] or "nil"
    button = args[3] or "nil"
    callback = args[4] or function() end
    local ui=game:GetObjects('rbxassetid://129413015001851')[1]
    ui['CallDialog']['AlertContents']['Footer']['Buttons']['1']['ButtonContent']['ButtonMiddleContent']['Text'].Text = button
    ui['CallDialog']['AlertContents']['TitleContainer']['TitleArea']['Title'].Text = title
    ui['CallDialog']['AlertContents']['MiddleContent']['Content']['BodyText'].Text = description
    ui.Parent = (game:GetService('CoreGui'):FindFirstChild('RobloxGui') or game:GetService('CoreGui'))
    ui['CallDialog']['AlertContents']['Footer']['Buttons']['1'].MouseButton1Click:Connect(function()
        ui.Parent = nil
        callback()
    end)
end
