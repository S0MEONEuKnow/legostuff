local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

-- Configuration
local TARGET_USER_ID = 123
local PLACE_ID = game.PlaceId 
local isHopping = false 
local cursor = "" 
local stopHoppingFlag = false 

local loadstring = loadstring or function(str) error("loadstring not available") end

local function checkForTargetPlayer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.UserId == getgenv().TARGET_USER_ID then
            print("Found target player (UserId: " .. TARGET_USER_ID .. ") in server!")
            isHopping = false -- Stop hopping
            return true
        end
    end
    return false
end


local function stopHopping()
    stopHoppingFlag = true
    isHopping = false
end


function onserverhop(str)
    if isHopping then
        return
    end

    isHopping = true
    stopHoppingFlag = false

    cursor = ""


    while isHopping and not stopHoppingFlag do
        if checkForTargetPlayer() then
            break
        end

        -- Fetch server list
        local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s", PLACE_ID, cursor)
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)

        if not success then
            warn("Failed to fetch server list: " .. tostring(response))
            task.wait()
            continue
        end

        local serverData = HttpService:JSONDecode(response)
        local servers = serverData.data or {}
        cursor = serverData.nextPageCursor or ""

        for _, server in ipairs(servers) do
            if server.playing < server.maxPlayers and not table.find(getgenv().visitedServerIds, server.id) then
                table.insert(getgenv().visitedServerIds, server.id)

                print("Attempting to join server: " .. server.id)
                local success, errorMessage = pcall(function()
                    TeleportService:TeleportToPlaceInstance(PLACE_ID, server.id, Players.LocalPlayer)
                end)
                if not success then
                    warn("Teleport failed: " .. errorMessage)
                end
                task.wait()
            end
        end

        if not cursor then
            print("No more servers to hop to.")
            isHopping = false
            break
        end

        task.wait()
    end
end
onserverhop()
queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/S0MEONEuKnow/legostuff/refs/heads/main/sigmaskbidi.luau"))()]])
