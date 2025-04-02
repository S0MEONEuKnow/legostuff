local troll = [[                                                                                                    
                                                             ..                                     
                                            ......          .....                                   
                                      .     ...:=++++++++++===-:.                                   
                                    .....:+%#*=:....::::---:...-#=..                                
                                     ..=*-.:--:-:....:::::::::...=*.....                            
                                     .:%...:....:....:.:---::::....+....                            
                                 ....=*-...+%%#*+:..:++-*@@@@=::..:=#-.....                         
                                 ...++-=--..:::-#*...=+--=#=::=**+**-+*:...                         
                                  ..+*=.::-#*..**....::.....:::*@+.:*:=-...                         
                                  ..=%=:-@=.:+@*...+#+%=...=%@-.=*==*-+=...                         
                                  ...+=.*@@#-..:*%:::-+%#+:.***%#:..=*=....                         
                                  ...:*.#%#-%-.=#==#:..+%#%%%*=+:..:*-...                           
                                     .*.+@@@@@@@@@@@@##+%-..=#-...:+:...                            
                            ....     :*.:###***=#--=+...-#*+-...:+-.....                            
                           .........:=*...-+##%#%#*##*+=-:-:--=*=...                                
                           .%@@@@@@@@@*.:.-+-.:::::..::----*#-......                                
                           ..=%@%+...=#..:=====-:......=%#:....                                     
                          ......=@@@@-:%+:....::-+*#@@@-......                                      
                             .....=%*:...:----::....*@@@..                                          
                             .................-=-...=@@@*.                                          
                              ...      .. ...+@@@+..:#%@@-                                          
                              ...      .. ...:*@#:...+%+@*...                                       
                                            ...-%@+..-%=#%-..                                       
                                              ...=@@==%+:@+..                                       
                                               ....+@@@-.*#:.                                       
                                                ....:#@@+=%-.                                       
                                     ..           ..:%*+%@@=.                                       
                              :*%*-......         ..=@-..:-:.                                       
                              :#@#@@%*-..   .     .:##:......                                       
                              .*@-..=#@@@#=........=@+.                                             
                          .....-@*......:*@@@@+:...%%-.                                             
                          .....=@@.... .....=%@@@#+@*..                                             
                           ..=%@@@....   ......-*%@%-..                                             
                           .......            ....:%*..                                             
                           .......            .....*%-.                                             
                                                 ..-@+.                                             
                                                 ..:%#:...                                          
                                                  ..+@-...                                          
                                                  ..=@+...                                          
                                                  ..=@*...                                          
                                                  ..*@+...                                          
                                                  .:%@=...                                          
                                                  .=@%:.                                            
                                                ...*@*..                                            
                                              ....:@@-.                                             
                                              ....*@#:....                                          
                                              ....@@%*++-.                                          
                                               ...-*#%%%%-                                          
                                                  .........                                         
                                                  ........                                                                                                                                          ]]
local logo = [[
                                             ..........                                             
                                         ..................                                         
                                      .....              .....                                      
                                    ...... ...........    ......                                    
                                   ....    ...........       ....                                   
                                 .....  ....       ...        .....                                 
                                 ..  .....   .........           ...                                
                                ........   ..... .....           ...                                
                               ........   ......                 ....                               
                               ........  ...                     ....                               
                               ........  ....                    ....                               
                               .... .........                    ....                               
                               ..... .......                     ....                               
                               .....                             ....                               
                                ....                             ...                                
                                 ......                      ......                                 
                                  .....                      .....                                  
                                   ....                      ....                                   
                                    ......                ......                                    
                                      ....                ....                                      
                                       .....            .....                                       
                                        ....           .....                                        
                                        ....................                                        
                                                                                                    
                                                                                                    
                                         ..................                                         
                                         ....           ...                                         
                                         ....          ....                                         
                                          ...           ..                                          
                                           ..............                                           
                                            ............                                            ]]
--print(" \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n")
print(logo)
game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.F9,false,game)

task.wait(0.3)

local ui = game:GetObjects('rbxassetid://109841097905359')[1]:Clone()
local safestorage = (game:GetService("CoreGui"):FindFirstChild('DevConsoleMaster') or game:GetService("CoreGui"):FindFirstChild("RobloxGui") or game:GetService("CoreGui"))

local UserInput = game:GetService("UserInputService")

if ui:FindFirstChild('phosphor') then
	ui = ui['phosphor']
else
	local phosphor = Instance.new("Folder",ui)
	phosphor.Name = 'phosphor'
	for i,v in pairs(ui:GetChildren()) do
		if v~=phosphor then
			v.Parent = phosphor
		end
	end
	ui = phosphor
end

local assets = ui['Assets']
local base = ui['Base']
local pages = base['Body']['Pages']
local scriptscanner = pages['ScriptScanner']
local content = scriptscanner['List']['Results']['Clip']['Content']


local drag = base.Drag
local collapse = drag.Collapse

local dragging
local dragStart
local startPos

ui.Parent = safestorage

drag.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		local dragEnded 

		dragging = true
		dragStart = input.Position
		startPos = base.Position

		dragEnded = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				dragEnded:Disconnect()
			end
		end)
	end
end)

local dragfunc = UserInput.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
		local delta = input.Position - dragStart
		base.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local function scan(query)
    local scripts = {}
    query = query or ""
    
    for _i, modulee in pairs(getloadedmodules()) do
        if modulee.Name:lower():find(query) then
            scripts[modulee] = modulee
        end
    end

    for _i, v in pairs(getgc()) do
        if type(v) == "function" and not isexecutorclosure(v) then
            local script = rawget(getfenv(v), "script")

            if typeof(script) == "Instance" and 
                not scripts[script] and 
                script:IsA("LocalScript") and 
                script.Name:lower():find(query) and
                getscriptclosure(script) and
                pcall(function() getsenv(script) end)
            then
                scripts[script] = script
            end
        end
    end

    return scripts
end

--base['Border'].ZIndex = -1

local icons = {
	ModuleScript = "rbxassetid://15415788089",
	LocalScript = "rbxassetid://12324727180"
}

local basicscroll = 0

function UpdateCanvasSize(Canvas, Constraint)
	Canvas.CanvasSize = UDim2.new(0, Constraint.AbsoluteContentSize.X, 0, Constraint.AbsoluteContentSize.Y+33)
end
local UIGridLayout = Instance.new('UIGridLayout',content)


function onremove(new)
	local scr = new['Original'].Value
	scr.Parent.DescendantRemoving:Connect(function(ins)
		if ins == scr then
		--	basicscroll = basicscroll - 33
		--	content.CanvasSize = UDim2.new(0,0,0,basicscroll)
		--	new:Destroy()
		end
	end)
end

local scripts = {}

function lognew(scr)
	table.insert(scripts,scr)
	if scr:IsA("ModuleScript") or scr:IsA("LocalScript") then
		local new = assets['ScriptLog']:Clone()
		new.Parent = content
		new:FindFirstChildOfClass('TextLabel').Text = scr.Name
		new['Icon'].Image = icons[scr.ClassName]
		new['Original'].Value = scr
	--	UpdateCanvasSize(content, UIGridLayout)
		onremove(new)
	--	basicscroll = basicscroll+33
	content.CanvasSize = UDim2.new(0,0,0,#content:GetChildren()*37)
	end
end

function refresh()
    local found = scan()
    for _,modulee in pairs(found) do
        lognew(modulee)
    end
    content.CanvasSize = UDim2.new(0,0,0,#content:GetChildren()*37)
end
refresh()
--print(" \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n")
print(troll)
