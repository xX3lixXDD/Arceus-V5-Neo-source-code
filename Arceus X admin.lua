--[[
		ARCEUS X ADMIN
		- spdmteam.com
		
		Inspired & Code rewrite of Infinite Yield.
		Specialized in mobile devices.
		- Riky47#3355

		Source: https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source
]]

local UI_FOLDER = "ArceusAdminConfigs"
local EXPLOIT_IDENTITY = "ArceusAdmin"
local EXPLOIT_BASE_IDENTITY = "Arceus"
local DOWNLOAD_URL = "https://spdmteam.com/"
local FILES_KEY = "AX_225bc4aed1a60602d4e56948cfafbae25be3e95ee1f41a277213056475a5771e"

local framework = loadstring(game:HttpGet("https://gist.githubusercontent.com/Riky47/84652f6b9c6b7e0749fec3886f5ceb34/raw/36e61cda2d667fc6bfd6f6003f41f25c2a7dd4cc/Framework", true))()
--local framework = require(script.Parent.Parent:WaitForChild("Wave"):WaitForChild("WaveFramework"))
framework.storage:CreateDirectory("configs", UI_FOLDER)

local ContextActionService: ContextActionService = framework.protected:GetService("ContextActionService")
local MarketplaceService: MarketplaceService = framework.protected:GetService("MarketplaceService")
local PathfindingService: PathfindingService = framework.protected:GetService("PathfindingService")
local UserInputService: UserInputService = framework.protected:GetService("UserInputService")
local TeleportService: TeleportService = framework.protected:GetService("TeleportService")
local TweenService: TweenService = framework.protected:GetService("TweenService")
local TextService: TextService = framework.protected:GetService("TextService")
local GuiService: GuiService = framework.protected:GetService("GuiService")
local RunService: RunService = framework.protected:GetService("RunService")
local StarterGui: StarterGui = framework.protected:GetService("StarterGui")
local Lighting: Lighting = framework.protected:GetService("Lighting")
local Players: Players = framework.protected:GetService("Players")
local CoreGui = framework.protected:GetService("CoreGui")

local IsOnMobile = (not framework.protected:IsStudio()) and framework.utils.tables.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) or false

do
	local exploit = {}
	local gethwid = framework.env.isios() and framework.protected:GCProtect(function() 
		return framework.protected:GetService("AnalyticsService"):GetClientId()
	end) or framework.env.gethwid

	function exploit:GetHwid()
		return gethwid()
	end

	function exploit:IsIos()
		return framework.env.isios()
	end

	function exploit:InitUI()
		local ui = framework.interface.new("main")
		ui.instance.ScreenInsets = Enum.ScreenInsets.None

		ui:AddInstance("TextButton", {
			Id = "menu_close",
			
			TextYAlignment = Enum.TextYAlignment.Bottom,
			TextColor3 = Color3.new(255, 0, 0),
			Text = "Hold outside to close",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 0,
			
			-- Opening
			Visible = false
		})
		
		ui:AddInstance("ImageButton", {
			Id = "floating_icon",
			
			Position = UDim2.fromScale(.75, .75),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.19, .19),
			Image = "rbxassetid://83091435402189",
			ScaleType = Enum.ScaleType.Fit,
			BackgroundTransparency = .3,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)
			
		}), ui:AddInstance("UIAspectRatioConstraint")):SetDraggable(true)

		-- Commands prompt
		local cbox = ui:AddInstance("TextLabel", {
			Id = "command_usage",
			
			FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = .3,
			TextColor3 = Color3.fromRGB(150, 150, 150),
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.X,
			--Position = UDim2.fromScale(.5, .2),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.5, .1),
			TextSize = 24,
			Text = "",
			
			-- Opening
			Position = UDim2.fromScale(.5, -.1),
			Visible = false
			
		}, ui:AddInstance("TextBox", {
			Id = "command_box",
			
			AutomaticSize = Enum.AutomaticSize.X,
			FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular),
			TextColor3 = Color3.fromRGB(225, 225, 225),
			TextXAlignment = Enum.TextXAlignment.Left,
			PlaceholderText = "Command...",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			TextSize = 24,
			Text = ""
			
		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)
			
		}), ui:AddInstance("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(255, 0, 0),
			Thickness = 5
				
		}), ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(.2, 0),
			PaddingRight = UDim.new(.03, 0),
			PaddingLeft = UDim.new(.03, 0),
			PaddingTop = UDim.new(.2, 0)
			
		})).instance
		
		-- Suggestions list
		local paddings = cbox.AbsoluteSize.Y /10
		ui:AddInstance("Frame", {
			Id = "list_frame",
			
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.fromScale(.5, .265),
			AnchorPoint = Vector2.new(.5, 0),
			--Size = UDim2.fromScale(.45, .5)
			
			-- Opening
			Size = UDim2.fromScale(.45, 0),
			Visible = false
			
		}, ui:AddInstance("ScrollingFrame", {
			Id = "commands_list",
			
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ScrollBarThickness = 0,
			BorderSizePixel = 0
			
		}, ui:AddInstance("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, paddings)
			
		})), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0, 15)
			
		}), ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(.025, 0),
			PaddingTop = UDim.new(.025, 0)
			
		}), ui:AddInstance("UIGradient", {
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, .3),
				NumberSequenceKeypoint.new(1, .75)
			})			
		}), ui:AddInstance("ImageButton",{
			Id = "execute_button",

			Image = "rbxassetid://134604718340940",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.fromScale(1.01, 0),
			Size = UDim2.fromScale(.175, .175),
			BackgroundTransparency = 1,
			ImageTransparency = .3,

		}, ui:AddInstance("UICorner",{
			CornerRadius = UDim.new(0, 15)

		}), ui:AddInstance("UIAspectRatioConstraint")), ui:AddInstance("ImageButton",{
			Id = "history_prev",

			Image = "rbxassetid://109788049942159",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.fromScale(1, .6),
			Size = UDim2.fromScale(.2, .2),
			BackgroundTransparency = 1,
			ImageTransparency = .3,
			Rotation = 90

		}, ui:AddInstance("UICorner",{
			CornerRadius = UDim.new(0, 15)

		}), ui:AddInstance("UIAspectRatioConstraint")), ui:AddInstance("ImageButton",{
			Id = "history_next",

			Image = "rbxassetid://109788049942159",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.fromScale(1, .8),
			Size = UDim2.fromScale(.2, .2),
			BackgroundTransparency = 1,
			ImageTransparency = .3,
			Rotation = -90

		}, ui:AddInstance("UICorner",{
			CornerRadius = UDim.new(0, 15)
			
		}), ui:AddInstance("UIAspectRatioConstraint")))
		
		-- Suggestion component		
		local suggestion = ui:CreateComponent("suggestion")
		suggestion.OnCreating:Connect(framework.protected:GCProtect(function(command: {any})
			return ui:AddInstance("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = .35,
				Size = UDim2.new(0.95, 0, 0, paddings),
				AutomaticSize = Enum.AutomaticSize.Y
				
			}, ui:AddInstance("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, paddings)
				
			}), ui:AddInstance("UICorner", {
				CornerRadius = UDim.new(0, 15)
				
			}), ui:AddInstance("UIPadding", {
				PaddingBottom = UDim.new(0, paddings),
				PaddingRight = UDim.new(0, paddings),
				PaddingLeft = UDim.new(0, paddings),
				PaddingTop = UDim.new(0, paddings)
				
			}), ui:AddInstance("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Heavy),
				Size = UDim2.new(1, 0, 0, cbox.AbsoluteSize.Y /3.5),
				TextColor3 = Color3.fromRGB(226, 0, 0),
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				TextScaled = true,
				Text = command.usage,
				LayoutOrder = 0
				
			}), function(parent)
				
				local components = {}
				for i, syn in ipairs(command.synonyms) do
					framework.utils.tables.insert(components, ui:AddInstance("TextLabel", {
						FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular),
						Size = UDim2.new(1, 0, 0, cbox.AbsoluteSize.Y /6),
						TextColor3 = Color3.fromRGB(150, 150, 150),
						TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundTransparency = 1,
						TextScaled = true,
						LayoutOrder = i,
						Text = syn
					}))
				end

				return components
				
			end, ui:AddInstance("Frame", {
				Size = UDim2.new(.95, 0, 0, cbox.AbsoluteSize.Y /6),
				LayoutOrder = #command.synonyms +1,
				BackgroundTransparency = 1
				
			}), ui:AddInstance("TextLabel", {
				Text = command.description .. (command.aliasOf and framework.utils.strings.format(" (Alias of %s)", command.aliasOf) or ""),
				FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold),
				Size = UDim2.new(1, 0, 0, cbox.AbsoluteSize.Y /5),
				TextColor3 = Color3.fromRGB(225, 225, 225),
				TextXAlignment = Enum.TextXAlignment.Left,
				LayoutOrder = #command.synonyms +2,
				BackgroundTransparency = 1,
				TextScaled = true
			}))
		end))
		
		local toast, toastIndex, toasts, nextToast, lastToast = ui:CreateComponent("toast"), 999999, {}, framework.signals.newEvent(), nil
		local allowNext = toastIndex
		
		toast.OnCreating:Connect(framework.protected:GCProtect(function(props: {any})
			local idx = toastIndex
			toastIndex -= 1
			
			local bar = ui:AddInstance("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				Size = UDim2.fromScale(0, 1),
				ZIndex = idx

			}, ui:AddInstance("UICorner", {
				CornerRadius = UDim.new(1, 0)

			}), ui:AddInstance("UIGradient", {
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(157, 21, 6)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
				})	
			}))
			
			local barConat = ui:AddInstance("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 0, 0),
				Size = UDim2.fromScale(1, 0.084),
				BackgroundTransparency = 0.75,
				ZIndex = idx,
				LayoutOrder = 3

			}, ui:AddInstance("UICorner", {
				CornerRadius = UDim.new(1, 0)

			}), bar)
			
			local toast = ui:AddInstance("TextButton", {
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				--Position = UDim2.fromScale(0.7, 0.725),
				Size = UDim2.fromScale(.2, .147),
				BackgroundTransparency = .1,
				ZIndex = idx,
				Visible = false,
				Text = "",
				
				-- Opening
				Position = UDim2.new(1.3, .725)

			}, ui:AddInstance("UICorner",{
				CornerRadius = UDim.new(.15, 0)
				
			}), ui:AddInstance("UIAspectRatioConstraint", {
				AspectRatio = 3.411,
				
			}), ui:AddInstance("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(.015, 0)
				
			}), ui:AddInstance("UIPadding", {
				PaddingRight = UDim.new(.033, 0),
				PaddingBottom = UDim.new(.1, 0),
				PaddingLeft = UDim.new(.033, 0),
				PaddingTop = UDim.new(.1, 0)
				
			}), barConat, ui:AddInstance("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.ExtraBold),
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.fromScale(1, .357),
				BackgroundTransparency = 1,
				ZIndex = idx,
				TextWrapped = true,
				TextScaled = true,
				LayoutOrder = 0,
				Text = props.Title
				
			}), ui:AddInstance("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular),
				TextColor3 = Color3.fromRGB(150, 150, 150),
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.fromScale(1, .525),
				AnchorPoint = Vector2.new(1, 1),
				BackgroundTransparency = 1,
				Text = props.Description,
				ZIndex = idx,
				TextWrapped = true,
				TextScaled = true,
				LayoutOrder = 1
			}))
			
			local id = framework.utils.strings.format("Toast_%s", idx)
			local lenght = barConat.instance.Size.X.Scale /props.Duration
			
			local pos = UDim2.fromScale(0.785 + toast.instance.Size.X.Scale * 1.25, .725)
			toast.instance.Position = pos
			toast.instance.Visible = true
			
			if allowNext ~= idx then
				local function recursive()
					if idx ~= nextToast:Wait() then
						recursive()
					end
				end
				
				recursive()
			end
			
			for tst, _ in pairs(toasts) do
				if tst.instance.Position.X.Scale >= .785 then	
					tst:Tween(TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
						Position = UDim2.fromScale(0.785, tst.instance.Position.Y.Scale) - UDim2.fromScale(0, tst.instance.Size.Y.Scale)
					})
				end
			end
			
			if lastToast then
				task.wait(.5)
			end
			
			toasts[toast] = toastIndex
			lastToast = toast.instance
			
			toast:Tween(TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0.1), {
				Position = UDim2.fromScale(0.785, 0.725)
			})
			
			task.wait(.6)
			toast:SetDraggable(true)
			
			allowNext = idx -1
			nextToast:Fire(allowNext)
			local render
			
			render = framework.renderer:BindToRenderer(id, framework.renderer.FrameworkPriority, function(delta: number, ...)
				bar.instance.Size = bar.instance.Size + UDim2.fromScale(lenght *delta, 0)

				if bar.instance.Size.X.Scale >= 1 then
					toasts[toast] = nil
					if lastToast == toast.instance then
						lastToast = nil
					end
					
					render:Unbind()
					toast:Tween(TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
						Position = UDim2.new(pos.X.Scale, 0, toast.instance.Position.Y.Scale, toast.instance.Position.Y.Offset)
					})

					task.wait(.5)
					toast:Remove()
				end
			end):Render()
			
			toast.instance.MouseButton1Down:Connect(function()
				render:Pause()
			end)
			
			toast.instance.MouseButton1Up:Connect(function()
				render:Resume()
			end)
			
			return toast
		end))
		
		return ui
	end

	function exploit:LoadUrl(url: string, retries: number)
		retries = retries or 3
		local res, c = nil, 0

		repeat
			if res ~= nil then
				c += 1
				if retries > 0 and c > retries then
					break
				end

				task.wait(2)
			end

			res = framework.utils.http:Request(url)
		until res

		return res and res.Body or false
	end
	
	function exploit:GetVersion()
		local url = exploit:IsIos() and "https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main/version-admin" or "https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main/version-admin"
		return exploit:LoadUrl(url, 0):gsub("[%s+]", "")
	end
	
	function exploit:GetDownloadWeek()
		local url = ""
		return exploit:LoadUrl(url, 0)
	end

	framework.dependencies:Add("exploit", framework.protected:ProtectTable(exploit))
end

-- Init

local ui = framework.dependencies.exploit:InitUI()
ui:SetEnabled(true)

do -- Authentication
	local name, ver = framework.env.identifyexecutor()
	local isStudio = framework.protected:IsStudio()

	-- Check for exploit identity
	if not isStudio then
		if not name or not ver then
			return
		end

		local found = (name == EXPLOIT_IDENTITY or name:lower():find(EXPLOIT_BASE_IDENTITY:lower()))
		if not found then
			ui:Remove()
			return
		end
		
		-- Check for exploit versioning
		local newer = framework.dependencies.exploit:GetVersion()
		framework.utils.versioning:SetVersion(ver)

		if name == EXPLOIT_IDENTITY and framework.utils.versioning:Compare(newer) == framework.enums.versioning.newer then
			framework.utils.clipboard:Set(DOWNLOAD_URL)
			ui:AddComponent("toast", {
				Description = "Please update Arceus X, link copied to clipboard.",
				Title = "Outdated version",
				Duration = 10
			})
			
			task.wait(10)
			ui:Remove()
			return
		end
		
		--if math.floor(os.time()/(60*60*24*7)) ~= framework.dependencies.exploit:GetDownloadWeek() then
		--	framework.utils.clipboard:Set(DOWNLOAD_URL)
		--	ui:AddComponent("toast", {
		--		Description = "Please redownload Arceus X, link copied to clipboard.",
		--		Title = "Version expired",
		--		Duration = 10
		--	})

		--	task.wait(10)
		--	ui:Remove()
		--	return
		--end
	end
end

-- Admin menu backend

local commands, history, aliases, waypoints = framework.protected:GCProtect({}), framework.protected:GCProtect({}), framework.protected:GCProtect({}), framework.protected:GCProtect({})
local historyIndex = 0

local addCommand = framework.protected:GCProtect(function(names: {string}, params: {string}, desc: string, callback: (any) -> boolean, noHistory: boolean, aliasOf: string)
	framework.protected:GCProtect(callback)
	
	for i, name in ipairs(names) do
		name = name:lower()
		assert(not (commands[name] or aliases[name]), framework.utils.strings.format("Command already present: %s", name))
		
		local usage = params
		if typeof(params) == "table" then
			usage = name
			
			for _, param in ipairs(params) do
				usage ..= framework.utils.strings.format(" [%s]", param)
			end
		end
		
		local synons = framework.utils.tables.deepCopy(names)
		framework.utils.tables.remove(synons, i);
		
		(aliasOf and aliases or commands)[name] = {
			allowHistory = (not noHistory) and true or false,
			callback = callback,
			description = desc,
			synonyms = synons,
			aliasOf = aliasOf,
			usage = usage,
			name = name
		}
	end
end)

local getSearchScore = framework.protected:GCProtect(function(name1: string, name2: string)
	local cstart, cend = name2:find(name1)
	local score

	if cstart then
		score = #name2 -(cend -cstart +1)
	end
	
	return score
end)

local searchPlayers = framework.protected:GCProtect(function(name: string)
	name = name:lower()
	local results = {}
	
	for _, player in pairs(Players:GetPlayers()) do
		local pname = player.Name:lower()
		local score = getSearchScore(name, pname)
		local score2 = getSearchScore(pname, name)
		
		if not score or (score2 and score < score2) then
			score = score2
		end

		if score then
			framework.utils.tables.insert(results, {
				player = player,
				score = score
			})
		end
	end
	
	framework.utils.tables.sort(results, function(a: {any}, b: {any})
		return a.score < b.score
	end)

	return results
end)

local searchCommands = framework.protected:GCProtect(function(target: string, cmds: {any})
	target = target:lower()
	local results = {}

	for name, values in pairs(cmds or framework.utils.tables.concatenate({}, commands, aliases)) do
		local score = getSearchScore(target, name)
		local score2 = getSearchScore(name, target)
		
		if not score or (score2 and score < score2) then
			score = score2
		end

		if score then
			framework.utils.tables.insert(results, framework.utils.tables.concatenate({
				score = score
			}, values))
		end
	end

	framework.utils.tables.sort(results, function(a: {any}, b: {any})
		return a.score < b.score
	end)
	
	return results
end)

local searchPlayer = framework.protected:GCProtect(function(name: string)
	local results = searchPlayers(name)
	local plr
	for _, player in ipairs(results) do
		if not plr then
			plr = player
			continue
		end

		if player.score == plr.score then
			return nil -- Matching players
		end
	end
	
	if plr then
		return plr.player
	end
end)

local searchCommand = framework.protected:GCProtect(function(target: string, cmds: {any})
	local results = searchCommands(target, cmds)
	
	local cmd
	for _, command in ipairs(results) do
		if not cmd then
			cmd = command
			continue
		end
		
		if command.score == cmd.score then
			return nil -- Matching commands
		end
	end
	
	return cmd
end)

local processCommand = framework.protected:GCProtect(function(prompt: string, ...: any)
	local splitted = prompt:split(" ")
	local command = splitted[1]
	local result = {
		error = "Invalid command",
		command = nil,
		arguments = {},
		success = false
	}
	
	if #command > 0 then
		local values = commands[command] or searchCommand(command)
		
		if values then
			framework.utils.tables.remove(splitted, 1)
			
			local args = framework.utils.tables.concatenate(splitted, {...})
			result.command = values
			result.arguments = args
			
			result.success, result.error = pcall(values.callback, framework.utils.tables.unpack(args))
			
			if result.error and typeof(result.error) == "string" then
				local splitted = result.error:split(": ")
				result.error = splitted[#splitted]
			end
		end
	end
	
	return result
end)

local sendCommand = framework.protected:GCProtect(function(prompt: string, ...: any)
	local result = processCommand(prompt, ...)
	if result.command then
		if not result.command.allowHistory then
			return
		end
		
		local last = history[#history]
		if last and last.command == result.command.name then
			local argsMatch = false
			if #last.arguments == #result.arguments then
				for i, value in ipairs(last.arguments) do
					if result.arguments[i] == value then
						argsMatch = true
					end
				end
			end
			
			if argsMatch then
				historyIndex = #history +1
				return
			end
		end
		
		framework.utils.tables.insert(history, {
			command = result.command.name,
			arguments = result.arguments
		})

		while #history > 100 do
			framework.utils.tables.remove(history, 1)
		end
		
		historyIndex = #history +1
		ui:Get("history_prev").instance.ImageTransparency = .3
	end
	
	if not result.success then
		processCommand("notify", "Command error", result.error)
	end
end)

local sendCommandAsync = framework.protected:GCProtect(function(prompt: string, ...: any)
	task.spawn(sendCommand, prompt, ...)
end)

do -- Command box
	local ficon = ui:Get("floating_icon")
	local clist = ui:Get("commands_list")
	local usage = ui:Get("command_usage")
	local close = ui:Get("menu_close")
	local listf = ui:Get("list_frame")
	
	local exec: ImageButton = ui:Get("execute_button").instance
	local hprev: ImageButton = ui:Get("history_prev").instance
	local hnext: ImageButton = ui:Get("history_next").instance
	local cbox: TextBox = ui:Get("command_box").instance
	local ulab: TextLabel = usage.instance
	
	local currentCmd, clearSpaces, lastSuggs = "", false, framework.protected:GCProtect({})
	
	do -- Fixed scaled TextSize
		local parentWidth = cbox.AbsoluteSize.X
		local parentHeight = cbox.AbsoluteSize.Y

		local baseText = framework.utils.maths.min(parentWidth, parentHeight) * .65
		close.instance.TextSize = framework.utils.maths.min(parentWidth, parentHeight) * .2
			
		cbox.TextSize = baseText
		ulab.TextSize = baseText
	end
	
	local loadHistory = framework.protected:GCProtect(function()
		local cmd = history[historyIndex]
		if not cmd then
			--processCommand("notify", "Commands history", "End of commands history")
			return false
		end

		local command = cmd.command
		for _, arg in ipairs(cmd.arguments) do
			command ..= " " .. framework.utils.strings.tostring(arg)
		end
		
		cbox.Text = command
		cbox.ClearTextOnFocus = false
		return true
	end)
	
	local historyPrev = framework.protected:GCProtect(function()
		historyIndex -= 1
		if not loadHistory() then
			hprev.ImageTransparency = .7
			hnext.ImageTransparency = .3
			historyIndex += 1
		end
	end)
	
	local historyNext = framework.protected:GCProtect(function()
		historyIndex += 1
		if not loadHistory() then
			hprev.ImageTransparency = .3
			hnext.ImageTransparency = .7
			historyIndex -= 1
		end
	end)
	
	local autocomplete = framework.protected:GCProtect(function()
		if currentCmd ~= "" and not cbox.Text:lower():find(currentCmd) then
			cbox.Text = currentCmd
			clearSpaces = true
		end
	end)
	
	local addSugg = framework.protected:GCProtect(function(cmd: {any}, order: number)
		for _, syn in ipairs(cmd.synonyms) do
			if lastSuggs[syn] then
				return lastSuggs[syn]
			end
		end
		
		local newSugg = ui:AddComponent("suggestion", cmd):SetParent(clist)
		lastSuggs[cmd.name] = newSugg
		
		local holdable = framework.utils.inputs.buttons.holdable(newSugg)
		holdable.OnShortPress:Connect(function() -- Anti click while sliding the list
			cbox.Text = cmd.name .. " "
			cbox.ClearTextOnFocus = false
		end)
		
		newSugg.instance.LayoutOrder = order or 0
		return newSugg.instance
	end)
	
	local clearSugg = framework.protected:GCProtect(function()
		for name, inst in pairs(lastSuggs) do
			inst:Remove()
		end
		framework.utils.tables.clear(lastSuggs)
	end)
	
	local runCommand = framework.protected:GCProtect(function()
		if currentCmd ~= "" then
			sendCommandAsync(cbox.Text)
			cbox.Text = ""

			clearSugg()
			for _, cmd in pairs(framework.utils.tables.concatenate({}, commands, aliases)) do
				addSugg(cmd)
			end
		end
	end)
	
	cbox.Focused:Connect(function()
		cbox.ClearTextOnFocus = true
		
		if IsOnMobile then
			ulab.TextSize = cbox.TextSize -1
			ulab.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.ExtraLight)
		end
	end)

	cbox.FocusLost:Connect(function()
		ulab.TextSize = cbox.TextSize
		ulab.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular)
		
		if cbox.Text:gsub("[%s+]", "") == "" then
			clearSugg()
			for _, cmd in pairs(framework.utils.tables.concatenate({}, commands, aliases)) do
				addSugg(cmd)
			end
		end
	end)

	local lastCall = tick()
	cbox:GetPropertyChangedSignal("Text"):Connect(function()
		lastCall = tick()
		
		if clearSpaces then
			clearSpaces = false
			cbox.Text = cbox.Text:gsub("[%s+]", "")
			cbox.CursorPosition = #cbox.Text +1
		end

		local input = cbox.Text:gsub("%s+", " ")
		cbox.Text = input

		if input == "" then
			currentCmd = ""
			ulab.Text = ""

		else
			local cmds = searchCommands(input)
			local found = false
			
			if #cmds < 1 then
				cmds = framework.utils.tables.concatenate({}, commands, aliases)
			end
			
			clearSugg()
			if tick() -lastCall <= 0 then
				return
			end
			
			local sinput = input:split(" ")
			for i, cmd in ipairs(cmds) do
				if tick() -lastCall <= 0 then
					return
				end
				
				local sugg = addSugg(cmd, i)
				if not found and cmd.usage:match(framework.utils.strings.format("^%s", sinput[1])) then
					local susage = cmd.usage:split(" ")
					currentCmd = susage[1]
					ulab.Text = ""

					local idx = 1
					for i, sp in ipairs(susage) do
						idx += 1
						
						if i > 1 and #sinput > i -1 and sinput[i]:gsub("[%s+]", "") ~= "" then
							ulab.Text ..= sinput[i] .. " "
							continue
						end

						ulab.Text ..= sp .. " "
					end
					
					if #sinput > idx then
						for i=idx, #sinput, 1 do
							ulab.Text ..= sinput[i] .. " "
						end
					end

					found = true
					sugg.LayoutOrder = 0
				end
			end

			if not found then
				currentCmd = ""
				ulab.Text = cbox.Text
			end
		end
	end)
	
	exec.MouseButton1Click:Connect(runCommand)
	hprev.MouseButton1Click:Connect(historyPrev)
	hnext.MouseButton1Click:Connect(historyNext)
	
	do
		local holdable = framework.utils.inputs.buttons.holdable(ficon)
		holdable.OnShortPress:Connect(function()
			close.instance.Active = false
			close.instance.Visible = true
			usage.instance.Visible = true
			listf.instance.Visible = true
			
			ficon:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
				Size = UDim2.fromScale(0, 0),
				Visible = false
			})
			
			usage:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
				Position = UDim2.fromScale(.5, .2)
			})
			
			listf:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, .25), {
				Size = UDim2.fromScale(.45, .5)
			})
			
			task.wait(.6)
			if cbox.Text:gsub("[%s+]", "") == "" then
				clearSugg()
				for _, cmd in pairs(framework.utils.tables.concatenate({}, commands, aliases)) do
					addSugg(cmd)
				end
			end
			
			close.instance.Active = true
		end)
	end
	
	do
		local holdable = framework.utils.inputs.buttons.holdable(close)
		local last = tick() -3
		
		holdable.OnShortPress:Connect(function()
			if tick() -last >= 3 then
				last = tick()
				
				processCommand("notify", "Close menu", "Hold outside to close the menu")
			end
		end)
		
		holdable.OnLongPress:Connect(function()
			close.instance.Visible = false
			ficon.instance.Visible = true
			ficon.instance.Active = false
			
			listf:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
				Size = UDim2.fromScale(.45, 0),
				Visible = false
			})
			
			usage:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, .25), {
				Position = UDim2.fromScale(.5, -.1),
				Visible = false
			})
			
			ficon:Tween(TweenInfo.new(.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, .25), {
				Size = UDim2.fromScale(.19, .19)
			})
			
			task.wait(.6)
			ficon.instance.Active = true
		end)
	end

	UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessed: boolean)
		if input.KeyCode == Enum.KeyCode.Tab then
			autocomplete()
			
		elseif input.KeyCode == Enum.KeyCode.Return then
			runCommand()
		
		elseif input.KeyCode == Enum.KeyCode.Up then
			historyPrev()

		elseif input.KeyCode == Enum.KeyCode.Down then
			historyNext()
		end
	end)
	
	-- Load data

	aliases = framework.protected:ProtectTable(framework.storage.readJsonFile("configs", "aliases", FILES_KEY) or {})
	waypoints = framework.protected:ProtectTable(framework.storage.readJsonFile("configs", "waypoints", FILES_KEY) or {})
end

-- Global functions

local getRoot = framework.protected:GCProtect(function(player: Player)
	local char = player.Character
	if not char then
		return false
	end
	
	return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso') or char:GetPrimaryPart()
end)

local getHum = framework.protected:GCProtect(function(player: Player)
	local char = player.Character
	if not char then
		return false
	end
	
	return char:FindFirstChildWhichIsA("Humanoid")
end)

-- Load commands

local cmdsFlags = {
	noclipping = false
}

addCommand({"addalias"}, {"cmd", "alias"}, "Adds an alias to a command", function(cmd: string, alias: string)
	local values = commands[cmd] or searchCommand(cmd, commands)
	if not values then
		error("Invalid cmd parameter")
	end
	
	addCommand({alias}, values.usage:gsub(values.name, alias), values.description, values.callback, values.allowHistory, values.name)
	framework.storage.writeJsonFile("configs", "aliases", aliases, FILES_KEY)
	processCommand("notify", "Aliases", framework.utils.strings.format("Created alias of command %s", values.name))
end)

addCommand({"removealias", "rmalias"}, {"alias"}, "Removes a custom alias", function(alias: string)
	local alias = aliases[alias] or searchCommand(alias, aliases)
	if not alias or not alias.aliasOf then
		error("Invalid alias parameter")
	end
	
	aliases[alias.name] = nil
	framework.storage.writeJsonFile("configs", "aliases", aliases, FILES_KEY)
	processCommand("notify", "Aliases", framework.utils.strings.format("Removed alias %s", alias.name))
end)

addCommand({"clearalias", "clralias"}, {}, "Remove all custom aliases", function()
	aliases = {}
	framework.storage.writeJsonFile("configs", "aliases", aliases, FILES_KEY)
	processCommand("notify", "Aliases", "Cleared all aliases")
end)

addCommand({"joinscript", "JobId"}, {}, "Gives a javascript to join the current server", function(syscall: boolean)
	local scr = framework.utils.strings.format("javascript:Roblox.GameLauncher.joinGameInstance(%s, %s)", game.PlaceId, game.JobId)
	if not syscall then
		framework.utils.clipboard:Set(scr)
		processCommand("notify", "Copied to clipboard", scr)
	end
	
	return scr
end)

addCommand({"gametp", "gameteleport"}, {"placeId"}, "Join a game by Id", function(placeId: number)
	placeId = tonumber(placeId)
	
	if placeId then
		return error("Invalid PlaceId")
	end
	
	TeleportService:Teleport(placeId)
end)

addCommand({"rejoin", "rj"}, {}, "Rejoin the game", function()
	if #Players:GetPlayers() <= 1 then
		Players.LocalPlayer:Kick("\nRejoining...")
		task.wait()
		TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
		return
	end
	
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
end)

do
	local conn
	addCommand({"autorejoin", "autorj"}, {}, "Automatically rejoins the server if you get kicked or disconnected", function()
		if conn then
			conn:Disconnect()
		else
			conn = GuiService.ErrorMessageChanged:Connect(function()
				processCommand("rejoin")
			end)
		end
		
		processCommand("notify", framework.utils.strings.format("Auto rejoin %s", conn and "enabled" or "disabled", "Run again to toggle."))
	end)
end

addCommand({"serverhop", "srhop"}, {"maxPlayers?"}, "Teleports you to a different server", function(maxPlayers: number)
	maxPlayers = tonumber(maxPlayers)
	if maxPlayers then
		maxPlayers = maxPlayers <= 0 and 1 or maxPlayers
	end
	
	local servers = {}
	processCommand("notify", "Serverhop", "Searching for servers, hold on a second.")
	local body = framework.utils.http.json.decode(framework.utils.http:Request(framework.utils.strings.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)))

	if body and body.data then
		for i, v in next, body.data do
			if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < (maxPlayers or v.maxPlayers) and v.id ~= game.JobId then
				framework.utils.tables.insert(servers, 1, v.id)
			end
		end
	end

	if #servers > 0 then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[framework.utils.maths.random(1, #servers)], Players.LocalPlayer)
	else
		error("Couldn't find a server")
	end
end)

-- Patched, also fetches only 100 servers
addCommand({"joinplayer", "joinp", "streamsnipe"}, {"username|userId", "placeId?"}, "Joins a specific player's server", function(username: string, placeId: number)
	if true then -- Deprecated
		error("This command no longer works")
	end
	
	placeId = tonumber(placeId)
	if not placeId then
		placeId = game.PlaceId
	end
	
	local FoundUser, UserId = pcall(function()
		if tonumber(username) then
			return tonumber(username)
		end

		return Players:GetUserIdFromNameAsync(username)
	end)
	
	if not FoundUser then
		error("Username or UserId does not exist")
	end
	
	local retries = 0
	local function toServer(UserId: number, placeId: number)
		if not pcall(function()		
				processCommand("notify", "Join error", "Searching for servers, hold on a second.")
				local body = framework.utils.http.json.decode(framework.utils.http:Request(framework.utils.strings.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)))
				local jobId

				for _, data in ipairs(body.data) do
					for _, k in ipairs(data.playerIds) do
						if k == UserId then
							jobId = k.id
						end
					end
				end

				if jobId ~= nil then
					processCommand("notify", "Join error", "Joining user.")
					TeleportService:TeleportToPlaceInstance(placeId, jobId, Players.LocalPlayer)
				else
					processCommand("notify", "Join error", "Unable to join the user.")
				end
			end)
		then
			if retries < 3 then
				retries = retries + 1
				processCommand("notify", "Join error", framework.utils.strings.format("Error while trying to join. Retrying %s/3.", retries))
				toServer(UserId, placeId)
			else
				processCommand("notify", "Join error", "Error while trying to join.")
			end
		end
	end
	
	toServer(UserId, placeId)
end)

addCommand({"bestpinghop", "pinghop", "laghop"}, {}, "Joins the server with the best ping", function()
	local retries = 0
	local function toServer()
		if not pcall(function()		
				processCommand("notify", "Join error", "Searching for servers, hold on a second.")
				local body = framework.utils.http.json.decode(framework.utils.http:Request(framework.utils.strings.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)))
				local jobId

				local ping = framework.utils.maths.huge
				for i, data in ipairs(body.data) do
					if data.ping < ping then
						ping = data.ping
						jobId = data.id
					end
				end

				if jobId then
					processCommand("notify", "Join error", framework.utils.strings.format("Joining the best server (%sms).", ping))
					task.wait(1)
					TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, Players.LocalPlayer)
				else
					processCommand("notify", "Join error", "Unable to join the server.")
				end
			end)
		then
			if retries < 3 then
				retries = retries + 1
				processCommand("notify", "Join error", framework.utils.strings.format("Error while trying to join. Retrying %s/3.", retries))
				toServer()
			else
				processCommand("notify", "Join error", "Error while trying to join.")
			end
		end
	end

	toServer()
end)

addCommand({"exit", "ex"}, {}, "Exit the game", function()
	game:Shutdown()
end)

do
	local clipping
	addCommand({"noclip", "togglenoclip"}, {}, "Toggles the ability to go through objects", function()
		if clipping then
			clipping:Disconnect()
			clipping = nil
		else
			-- OG was .Stepped
			clipping = RunService.Stepped:Connect(function()
				local char = Players.LocalPlayer.Character
				if char and cmdsFlags.noclipping then
					for _, child in pairs(char:GetDescendants()) do
						if child:IsA("BasePart") then --and child.Name ~= floatName then
							child.CanCollide = false
						end
					end
				end
			end)
		end
		
		processCommand("notify", framework.utils.strings.format("Noclip %s", clipping and "enabled" or "disabled"), "Run again to toggle")
	end)
	
	addCommand({"clip", "unnoclip"}, {}, "Turns off the ability to go through objects", function()
		if clipping then
			clipping:Disconnect()
		end
		
		processCommand("notify", "Noclip disabled", "Run again to toggle")
	end)
end

do
	local speeds = 5
	local cframeMult = 150 -- Multiplies CFrame mode

	local nowe = false
	local enabled = false
	local tpwalking = false
	local cframeMode = false

	local cfLoop = nil
	local speaker = Players.LocalPlayer
	local heartbeat = RunService.Heartbeat

	local updatespeed = framework.protected:GCProtect(function(char, hum)
		if nowe then
			tpwalking = false
			heartbeat:Wait()
			task.wait(.1)
			heartbeat:Wait() -- Make sure old threads are terminated

			for i = 1, speeds do
				task.spawn(function()
					tpwalking = true

					while tpwalking and heartbeat:Wait() and char and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							char:TranslateBy(hum.MoveDirection)
						end
					end
				end)
			end
		end
	end)
	
	local toggleFly = framework.protected:GCProtect(function(state)
		speaker.Character:FindFirstChildOfClass('Humanoid').PlatformStand = cframeMode and state or false
		local Head = speaker.Character:WaitForChild("Head")
		Head.Anchored = cframeMode and state or false
		if cfLoop then cfLoop:Disconnect() end

		if state and cframeMode and not nowe then
			cfLoop = heartbeat:Connect(function(deltaTime)
				local moveDirection = speaker.Character:FindFirstChildOfClass('Humanoid').MoveDirection * ((speeds *  cframeMult) * deltaTime)
				local headCFrame = Head.CFrame
				local cameraCFrame = workspace.CurrentCamera.CFrame
				local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
				cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
				local cameraPosition = cameraCFrame.Position
				local headPosition = headCFrame.Position

				local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
				Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
			end)
		else
			local char = speaker.Character
			if not char or not char.Humanoid then
				return
			end

			local hum = char.Humanoid
			if not state then
				nowe = false

				hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Running,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
				hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)	
			else
				nowe = true
				updatespeed(char, hum)

				char.Animate.Disabled = true
				for i,v in next, hum:GetPlayingAnimationTracks() do
					v:AdjustSpeed(0)
				end

				hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Running,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
				hum:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
				hum:ChangeState(Enum.HumanoidStateType.Swimming)
			end

			local UpperTorso = speaker.Character.LowerTorso or speaker.Character.Torso
			local flying = true
			local deb = true
			local ctrl = {f = 0, b = 0, l = 0, r = 0}
			local lastctrl = {f = 0, b = 0, l = 0, r = 0}
			local maxspeed = 50
			local speed = 0

			local bg = Instance.new("BodyGyro", UpperTorso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = UpperTorso.CFrame

			local bv = Instance.new("BodyVelocity", UpperTorso)
			bv.velocity = Vector3.new(0,0.1,0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

			if nowe then
				hum.PlatformStand = true
			end

			while nowe or hum.Health == 0 do
				task.wait()

				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed = speed+.5+(speed/maxspeed)
					if speed > maxspeed then
						speed = maxspeed
					end
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed-1
					if speed < 0 then
						speed = 0
					end
				end
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				else
					bv.velocity = Vector3.new(0,0,0)
				end

				bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-framework.utils.maths.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
			end

			ctrl = {f = 0, b = 0, l = 0, r = 0}
			lastctrl = {f = 0, b = 0, l = 0, r = 0}
			speed = 0
			bg:Destroy()
			bv:Destroy()

			hum.PlatformStand = false
			char.Animate.Disabled = false
			tpwalking = false
		end
	end)
	
	speaker.CharacterAdded:Connect(function(char)
		local char = speaker.Character
		if char then
			task.wait(0.7)
			char.Humanoid.PlatformStand = false
			char.Animate.Disabled = false
		end
	end)
	
	-- These are mobile only
	addCommand({"fly", "togglefly"}, {}, "Toggles the ability to fly", function()
		enabled = not enabled
		cframeMode = false

		toggleFly(false)
		if enabled then
			task.spawn(toggleFly, enabled)
		end
		
		processCommand("notify", framework.utils.strings.format("Fly %s", enabled and "enabled" or "disabled"), "Run again to toggle")
	end)
	
	addCommand({"cffly", "cframefly"}, {}, "Toggles the ability to fly with cframe mode", function()
		enabled = not enabled
		cframeMode = true

		toggleFly(false)
		if enabled then
			task.spawn(toggleFly, enabled)
		end

		processCommand("notify", framework.utils.strings.format("Cframe fly %s", enabled and "enabled" or "disabled"), "Run again to toggle")
	end)
	
	addCommand({"unfly", "nofly"}, {}, "Turns off the ability to fly", function()
		enabled = false
		toggleFly(enabled)
		
		processCommand("notify", "Fly", "Fly mode disabled")
	end)
	
	addCommand({"flyspeed", "flysp"}, {"speed"}, "Set the speed of the fly", function(speed: number)
		speed = tonumber(speed)
		if not speed then
			error("Invalid speed")
		end
		
		speed = speed < 1 and 1 or framework.utils.maths.floor(speed)

		if not cframeMode then
			local char = speaker.Character
			if char and char.Humanoid then
				local hum = char.Humanoid

				updatespeed(char, hum)
			end
		end
		
		processCommand("notify", "Fly", framework.utils.strings.format("Fly speed set to %s", speed))
	end)
	
	local input
	addCommand({"qefly", "flyqe", "flyhotkeys"}, {}, "Toggles fly on/off hotkeys (q/e)", function()
		if input then
			input:Disconnect()
			input = nil
		else
			input = UserInputService.InputEnded:Connect(function(inputObject, processedEvent)
				if processedEvent then
					return
				end
				
				if inputObject.KeyCode.Name:lower() == Enum.KeyCode.Q then
					enabled = true
					toggleFly(false)
					task.spawn(toggleFly, enabled)
				elseif inputObject.KeyCode.Name:lower() == Enum.KeyCode.E then
					enabled = false
					toggleFly(enabled)
				end
			end)
		end
		
		processCommand("notify", "Fly hotkeys", "Run again to toggle")
	end)
end

do
	local floating = false
	local IYMouse = Players.LocalPlayer:GetMouse()
	local floatName = framework.utils.strings.random()
	local FloatingFunc, qUp, eUp, qDown, eDown, floatDied
	
	local remove = framework.protected:GCProtect(function()
		local pchar = Players.LocalPlayer.Character
		if pchar:FindFirstChild(floatName) then
			pchar:FindFirstChild(floatName):Destroy()
		end
		
		if floatDied then
			FloatingFunc:Disconnect()
			qUp:Disconnect()
			eUp:Disconnect()
			qDown:Disconnect()
			eDown:Disconnect()
			floatDied:Disconnect()
			floatDied = nil
		end
	end)
	
	addCommand({"float", "platform"}, {}, "Toggles a platform beneath you causing you to float", function()
		floating = not floating
		if floating then
			local pchar = Players.LocalPlayer.Character
			if pchar and not pchar:FindFirstChild(floatName) then
				task.spawn(function()
					local Float = Instance.new('Part')
					Float.Name = floatName
					Float.Parent = pchar
					Float.Transparency = 1
					Float.Size = Vector3.new(2,0.2,1.5)
					Float.Anchored = true
					
					local FloatValue = -3.1
					Float.CFrame = getRoot(Players.LocalPlayer).CFrame * CFrame.new(0, FloatValue, 0)
					processCommand("notify", "Float enabled", "Q to go down, E to go up")
					
					qUp = IYMouse.KeyUp:Connect(function(KEY)
						if KEY == 'q' then
							FloatValue = FloatValue + 0.5
						end
					end)
					eUp = IYMouse.KeyUp:Connect(function(KEY)
						if KEY == 'e' then
							FloatValue = FloatValue - 0.5
						end
					end)
					qDown = IYMouse.KeyDown:Connect(function(KEY)
						if KEY == 'q' then
							FloatValue = FloatValue - 0.5
						end
					end)
					eDown = IYMouse.KeyDown:Connect(function(KEY)
						if KEY == 'e' then
							FloatValue = FloatValue + 0.5
						end
					end)

					floatDied = Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
						FloatingFunc:Disconnect()
						Float:Destroy()
						qUp:Disconnect()
						eUp:Disconnect()
						qDown:Disconnect()
						eDown:Disconnect()
						floatDied:Disconnect()
					end)
					
					local function FloatPadLoop()
						if pchar:FindFirstChild(floatName) and getRoot(Players.LocalPlayer) then
							Float.CFrame = getRoot(Players.LocalPlayer).CFrame * CFrame.new(0,FloatValue,0)
						else
							FloatingFunc:Disconnect()
							Float:Destroy()
							qUp:Disconnect()
							eUp:Disconnect()
							qDown:Disconnect()
							eDown:Disconnect()
							floatDied:Disconnect()
						end
					end			
					FloatingFunc = RunService.Heartbeat:Connect(FloatPadLoop)
				end)
			end
		else
			remove()
		end
		
		processCommand("notify", framework.utils.strings.format("Float %s", floating and "enabled" or "disabled"), "Run again to toggle")
	end)

	addCommand({"unfloat", "nofloat", "unplatform", "noplatform"}, {}, "Removes the float platform", function()
		remove()
		processCommand("notify", "Float", "Floating disabled")
	end)
end

do
	swimming = false
	local speaker = Players.LocalPlayer
	local oldgrav = workspace.Gravity
	local swimbeat, gravReset
	
	local remove = framework.protected:GCProtect(function()
		local char = speaker.Character
		if not char then
			return
		end
		
		if char then
			workspace.Gravity = oldgrav
			swimming = false
			if gravReset then
				gravReset:Disconnect()
			end
			if swimbeat ~= nil then
				swimbeat:Disconnect()
				swimbeat = nil
			end
			
			local Humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
			local enums = Enum.HumanoidStateType:GetEnumItems()
			framework.utils.tables.remove(enums, framework.utils.tables.find(enums, Enum.HumanoidStateType.None))
			for i, v in pairs(enums) do
				Humanoid:SetStateEnabled(v, true)
			end
		end
	end)
	
	addCommand({"swim"}, {}, "Allows you to swim in the air", function()	
		if swimming then
			remove()
		else
			local char = speaker.Character
			if not char then
				return
			end
			
			oldgrav = workspace.Gravity
			workspace.Gravity = 0
			local swimDied = function()
				workspace.Gravity = oldgrav
				swimming = false
			end
			local Humanoid = char:FindFirstChildWhichIsA("Humanoid")
			gravReset = Humanoid.Died:Connect(swimDied)
			
			local enums = Enum.HumanoidStateType:GetEnumItems()
			framework.utils.tables.remove(enums, framework.utils.tables.find(enums, Enum.HumanoidStateType.None))
			for i, v in pairs(enums) do
				Humanoid:SetStateEnabled(v, false)
			end
			
			Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
			swimbeat = RunService.Heartbeat:Connect(function()
				pcall(function()
					speaker.Character.HumanoidRootPart.Velocity = ((Humanoid.MoveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and speaker.Character.HumanoidRootPart.Velocity or Vector3.new())
				end)
			end)
			
			swimming = true
		end
		
		processCommand("notify", framework.utils.strings.format("Swim %s", swimming and "enabled" or "disabled"), "Run again to toggle")
	end)
	
	addCommand({"unswim", "noswim"}, {}, "Disables the swimming mode", function()
		remove()
		processCommand("notify", "Swim", "Swim mode disabled")
	end)
end

do
	local coreGuiTypeNames = {
		["inventory"] = Enum.CoreGuiType.Backpack,
		["leaderboard"] = Enum.CoreGuiType.PlayerList,
		["emotes"] = Enum.CoreGuiType.EmotesMenu,
	}
	
	local coreGuiStrings = {
		["chat"] = "ChatActive",
		["points"] = "PointsNotificationsActive",
		["badges"] = "BadgesNotificationsActive",
		["reset"] = "ResetButtonCallback",
		["topbar"] = "TopbarEnabled",
		["console"] = "DevConsoleVisible",
		["avatar"] = "AvatarContextMenuEnabled",
	}

	for _, enumItem in ipairs(Enum.CoreGuiType:GetEnumItems()) do
		coreGuiTypeNames[enumItem.Name:lower()] = enumItem
	end
	
	local setState = framework.protected:GCProtect(function(feature: string, status: boolean)
		if not feature then
			error("Invalid feature name")
		end

		feature = feature:lower()
		local typ = coreGuiTypeNames[feature]
		if typ then
			StarterGui:SetCoreGuiEnabled(typ, status)
		else
			local succ, err = pcall(StarterGui.SetCore, StarterGui, coreGuiStrings[feature] or feature, status)
			if not succ then
				error("Invalid feature name")
			end
		end
		
		processCommand("notify", "CoreGui", framework.utils.strings.format("CoreGui feature %s", status and "enabled" or "disabled"))
	end)
	
	addCommand({"enable", "enablecoregui", "setcoregui", "setcore"}, {"feature"}, "Enables coreGui features", function(feature: string)
		return setState(feature, true)
	end)
	
	addCommand({"disable", "disablecoregui"}, {"feature"}, "Disables coreGui features", function(feature: string)
		return setState(feature, false)
	end)
end

do
	local hidden, this = framework.protected:GCProtect({}), ui.instance
	addCommand({"hideguis", "hguis"}, {}, "Hide all guis of the game", function()
		for _, v in pairs(Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do
			if v:IsA("ScreenGui") and v ~= this and v.Enabled then
				hidden[v] = true
				v.Enabled = false
			end
		end
	end)
	
	addCommand({"unhideguis", "nohideguis", "unhguis", "showguis"}, {}, "Shows back all the guis previusly hidden", function()
		for gui, _ in pairs(hidden) do
			gui.Enabled = true
		end
		
		framework.utils.tables.clear(hidden)
	end)
end

do
	local delete, this = nil, ui.instance
	function deleteGuisAtPos()
		pcall(function()
			local IYMouse = Players.LocalPlayer:GetMouse()
			local guisAtPosition = Players.LocalPlayer:WaitForChild("PlayerGui"):GetGuiObjectsAtPosition(IYMouse.X, IYMouse.Y)
			for _, gui: GuiBase in pairs(guisAtPosition) do
				if gui.Visible and not gui:IsDescendantOf(this) then
					gui:Destroy()
				end
			end
		end)
	end
	
	addCommand({"deletegui", "guidelete", "delgui"}, {}, "Makes you able to delete gui objects", function()
		delete = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
			if not gameProcessedEvent then
				if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
					deleteGuisAtPos()
				end
			end
		end)
		
		processCommand("notify", "Gui delete", "Hover a gui and press (backspace/del) to delete it")
	end)
	
	addCommand({"unguidelete", "noguidelete", "stopguidelete"}, {}, "Turns off the ability to delete guis", function()
		if delete then
			delete:Disconnect()
			delete = nil
		end
	end)
end

addCommand({"record", "rec"}, {}, "Toggles the roblox recorder", function()
	CoreGui:ToggleRecording()
end)

addCommand({"screenshot", "ss"}, {"keepMenu?"}, "Takes a screenshot", function(keepMenu: boolean)
	ui.Enabled = keepMenu and true or false
	CoreGui:TakeScreenshot()
	
	task.wait()
	ui.Enabled = true
end)

addCommand({"togglefullscreen", "togglefs"}, {}, "Toggles the fullscreen mode", function()
	CoreGui:ToggleFullscreen()
end)

addCommand({"inspect", "examine"}, {"playerName"}, "Opens the inspect menu for the given player", function(playerName: string)
	local plr = searchPlayer(playerName)
	if not plr then
		error("Invalid player name")
	end
	
	GuiService:CloseInspectMenu()
	GuiService:InspectPlayerFromUserId(plr.UserId)
end)

addCommand({"savegame", "saveplace", "saveinstance"}, {}, "Saves a copy of the game", function()
	processCommand("notify", "Save instance", "Trying to save the game")
	local res = framework.env.saveinstance()
	if res == 404 then
		error("This exploit does not support saveinstance")
	end
	
	processCommand("notify", "Save instance", "Game saved in the workspace folder")
end)

addCommand({"clearerrors", "clearerror", "clrerr", "clearkick"}, {}, "Clears the box and blur when a game kicks you", function()
	GuiService:ClearError()
end)

addCommand({"antikick", "clientantikick"}, {}, "Prevents from being kicked by localscripts", function()
	if not framework.env.hookmetamethod then 
		error("This exploit does not support hookmetamethod")
	end
	
	local oldhmmi
	oldhmmi = framework.env.hookmetamethod(game, "__index", function(self, method)
		if self == Players.LocalPlayer and method:lower() == "kick" then
			return error("Expected ':' not '.' calling member function Kick", 2)
		end
		
		return oldhmmi(self, method)
	end)
	
	local oldhmmnc
	oldhmmnc = framework.env.hookmetamethod(game, "__namecall", function(self, ...)
		if self == Players.LocalPlayer and framework.env.getnamecallmethod():lower() == "kick" then
			return
		end
		
		return oldhmmnc(self, ...)
	end)

	processCommand("notify", "Client Antikick", "Client anti kick is now active")
end)

addCommand({"antiteleport", "clientantiteleport", "antitp"}, {}, "Prevents from being teleported bu localscripts", function()
	if not framework.env.hookmetamethod then 
		error("This exploit does not support hookmetamethod")
	end
	
	local oldhmmi
	oldhmmi = framework.env.hookmetamethod(game, "__index", function(self, method)
		if self == TeleportService then
			if method:lower() == "teleport" then
				return error("Expected ':' not '.' calling member function Kick", 2)
				
			elseif method == "TeleportToPlaceInstance" then
				return error("Expected ':' not '.' calling member function TeleportToPlaceInstance", 2)
			end
		end
		
		return oldhmmi(self, method)
	end)
	
	local oldhmmnc
	oldhmmnc = framework.env.hookmetamethod(game, "__namecall", function(self, ...)
		if self == TeleportService and framework.env.getnamecallmethod():lower() == "teleport" or framework.env.getnamecallmethod() == "TeleportToPlaceInstance" then
			return
		end
		
		return oldhmmnc(self, ...)
	end)

	processCommand("notify", "Client AntiTP", "Client anti teleport is now active")
end)

addCommand({"cancelteleport", "canceltp", "dismissteleport", "distp", "abortteleport", "aborttp"}, {}, "Cancels in progress teleports", function()
	TeleportService:TeleportCancel()
	processCommand("notify", "Teleport", "Teleports aborted")
end)

addCommand({"volume", "vol"}, {"volume"}, "Sets the game volume", function(volume: number)
	volume = tonumber(volume)
	if not volume then
		error("Invalid volume value")
	end
	
	volume = volume < 0 and 0 or volume
	volume = volume > 10 and 10 or volume
	
	framework.protected:GetReference(UserSettings():GetService("UserGameSettings")).MasterVolume = volume
	processCommand("notify", "Volume", framework.utils.strings.format("Volume set to %i/10", volume))
end)

addCommand({"antilag", "boostfps", "fpsboost", "lowgraphics"}, {}, "Removes textures and effects for a performance boost", function()
	local Terrain = workspace:FindFirstChildOfClass('Terrain')
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
			
		elseif v:IsA("Decal") then
			v.Transparency = 1
			
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
			
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
	
	workspace.DescendantAdded:Connect(function(child)
		task.spawn(function()
			if child:IsA('ForceField') then
				RunService.Heartbeat:Wait()
				child:Destroy()
				
			elseif child:IsA('Sparkles') then
				RunService.Heartbeat:Wait()
				child:Destroy()
				
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			end
		end)
	end)
	
	processCommand("notify", "AntiLag", "AntiLag is now enabled")
end)

addCommand({"fpscap", "capfps", "setfpscap", "maxfps"}, {"cap?"}, "Sets the max fps cap", function(cap: number)
	cap = tonumber(cap) or 0
	local res = framework.env.setfpscap(cap)
	if res == 404 then
		error("This exploit does not support setfpscap")
	end
	
	processCommand("notify", "FPS Cap", framework.utils.strings.format("FPS are now capped at %s", cap and tostring(cap) or "unlimited"))
end)

addCommand({"lastcommand", "lastcmd"}, {}, "Runs the last used command", function()
	local command = history[#history]
	if not command then
		error("No command used yet")
	end
	
	return processCommand(command.command, framework.utils.tables.unpack(command.arguments))
end, true)

do
	local esps, partsesps = framework.protected:GCProtect({}), framework.protected:GCProtect({})
	local espsFolder = framework.protected:GetInstance("Folder")
	local enabled, textEnabled, transparency = false, true, .3
	
	local clearPlayerEsp = framework.protected:GCProtect(function(esp: {BoxHandleAdornment})
		for _, conn in ipairs(esp.conns) do
			conn:Disconnect()
		end

		for _, instance in ipairs(esp.instances) do
			instance:Destroy()
		end
	end)
	
	local clearPartEsp = framework.protected:GCProtect(function(eps: {BoxHandleAdornment})
		for _, esp in ipairs(eps) do
			esp:Destroy()
		end
	end)
	
	local createEsp = framework.protected:GCProtect(function(part: BasePart, color: Color3, cache: {any})
		if (part:IsA("BasePart")) then
			local esp = framework.protected:GetInstance("BoxHandleAdornment", {
				Transparency = transparency,
				Parent = espsFolder,
				AlwaysOnTop = true,
				Size = part.Size,
				Adornee = part,
				Color = color,
				ZIndex = 10
			})
			
			framework.utils.tables.insert(cache, esp)
		end
	end)
	
	local createPlayerEsp
	createPlayerEsp = framework.protected:GCProtect(function(plr: Player, locating: boolean)
		local char, root, hum = true, nil
		repeat
			if not char then
				task.wait(1)
			end
			
			char, root, hum = plr.Character, getRoot(plr), getHum(plr)
		until char and root and hum
		
		if not enabled and not locating then
			return
		end
		
		local cache = esps[plr.UserId] or {
			instances = {},
			conns = {}
		}
		
		clearPlayerEsp(cache)
		esps[plr.UserId] = cache
		
		for _, part in ipairs(char:GetChildren()) do
			createEsp(part, plr.TeamColor, cache.instances)	
		end
		
		if textEnabled then
			local bill = framework.protected:GetInstance("BillboardGui", {
				Size = UDim2.new(0, 100, 0, 150),
				StudsOffset = Vector3.new(0, 1, 0),
				Adornee = char.Head or root,
				Parent = espsFolder,
				AlwaysOnTop = true
			})

			local lbl = framework.protected:GetInstance("TextLabel", {
				TextYAlignment = Enum.TextYAlignment.Bottom,
				Font = Enum.Font.SourceSansSemibold,
				Position = UDim2.new(0, 0, 0, -50),
				TextColor3 = Color3.new(1, 1, 1),
				Size = UDim2.new(0, 100, 0, 100),
				TextStrokeTransparency = 0,
				BackgroundTransparency = 1,
				Text = 'Name: '..plr.Name,
				TextSize = 20,
				Parent = bill,
				ZIndex = 10
			})
			
			framework.utils.tables.insert(cache.instances, bill)
			framework.utils.tables.insert(cache.conns, RunService.RenderStepped:Connect(function()
				if char and root and hum then
					local pos = framework.utils.maths.floor((getRoot(Players.LocalPlayer).Position - root.Position).magnitude)
					lbl.Text = string.format("Name: %s | Health: %i | Studs %i", plr.Name, framework.utils.maths.round(hum.Health), pos)
				end
			end))
		end
		
		local function redraw()
			if enabled then
				createPlayerEsp(plr)
			end
		end
		
		framework.utils.tables.insert(cache.conns, plr.CharacterAdded:Connect(redraw))
		framework.utils.tables.insert(cache.conns, plr:GetPropertyChangedSignal("TeamColor"):Connect(redraw))
	end)
	
	local updateEsp = framework.protected:GCProtect(function()
		for userId, esp in pairs(esps) do
			clearPlayerEsp(esp)
		end
		
		framework.utils.tables.clear(esps)
		if not enabled then
			return
		end
		
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr.UserId ~= Players.LocalPlayer.UserId then
				task.spawn(createPlayerEsp, plr)
			end
		end
	end)
	
	local partAdded = framework.protected:GCProtect(function(part: BasePart)
		if not part:IsA("BasePart") then
			return
		end
		
		for name, esp in ipairs(partsesps) do
			if part.Name:lower() == name then
				createEsp(part)
			end
		end
	end)
	
	local stringColor = framework.protected:GCProtect(function(name: string)
		local hash = 0
		for i = 1, #name do
			hash = hash + string.byte(name, i)
		end

		-- Define the range (1001 to 1032)
		local minNumber = 1001
		local range = 1032 - minNumber + 1
		local numberInRange = (hash % range) + minNumber
		
		return BrickColor.new(numberInRange)
	end)
	
	addCommand({"esp", "wallhack"}, {}, "Toggles the view on all players and their status", function()
		enabled = not enabled
		updateEsp()
		
		processCommand("notify", framework.utils.strings.format("ESP %s", enabled and "Enabled" or "Disabled"), "Run again to toggle")
	end)
	
	addCommand({"unesp", "noesp", "unwallhack", "nowallhack"}, {}, "Disables esp", function()
		enabled = false
		updateEsp()
		
		processCommand("notify", "ESP", "ESP Disabled")
	end)
	
	addCommand({"chams", "noespspects"}, {}, "Toggles esp without players specs", function()
		if enabled and textEnabled then
			textEnabled = false
			updateEsp()
			return
		end
		
		textEnabled = false
		processCommand("esp")
	end)
	
	addCommand({"unchams", "nochams", "espspecs"}, {}, "Turns back the specs to the esp", function()
		if enabled and not textEnabled then
			textEnabled = true
			updateEsp()
			return
		end
		
		textEnabled = true
		processCommand("esp")
	end)
	
	addCommand({"partesp", "objectesp", "objesp"}, {"objName"}, "Toggles the highlight on objects with the provided name", function(name: string)
		if not name or typeof(name) ~= "string" or #name < 1 then
			error("Invalid part name")
		end
		
		local found, show = false, true
		name = name:lower()
		
		local cache = partsesps[name]
		show = not cache
		cache = cache or {}
		
		if show then
			partsesps[name] = cache
			local color = stringColor(name)
			
			for _, part in ipairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") and part.Name:lower() == name then
					found = true
					createEsp(part, color, cache)
				end
			end
		else
			clearPartEsp(cache)
			partsesps[name] = nil
		end
		
		processCommand("notify", found and "Object(s) highlighted" or "No object(s) found", "Run again to toggle")
	end)
	
	addCommand({"unpartesp", "nopartesp", "unobjectesp", "noobjectesp", "unobjesp", "noobjesp"}, {"objName"}, "Removes the highlight from objects with the provided name", function(name: string)
		if not name or typeof(name) ~= "string" or #name < 1 then
			error("Invalid object name")
		end
		
		name = name:lower()
		local cache, found = partsesps[name], false
		
		if cache then
			clearPartEsp(cache)
			partsesps[name] = nil
			found = true
		end
		
		processCommand("notify", "Object EPS", found and "Highlight(s) removed" or "No object(s) found")
	end)
	
	addCommand({"locate", "loc"}, {"playerName"}, "Enables the ESP on a specific player", function(name: string)
		local plr = searchPlayer(name)
		if not plr or plr.UserId == Players.LocalPlayer.UserId then
			error("Player not found")
		end
		
		textEnabled = true
		createPlayerEsp(plr, true)
		processCommand("notify", "Player ESP", framework.utils.strings.format("ESP enabled on %s", plr.Name))
	end)
	
	addCommand({"unlocate", "nolocate", "uoloc", "noloc"}, {"playerName"}, "Removes the ESP from a specific player", function(name: string)
		local plr = searchPlayer(name)
		if not plr or plr.UserId == Players.LocalPlayer.UserId then
			error("Player not found")
		end

		local cache = esps[plr.UserId] or {}
		clearPlayerEsp(cache)
		esps[plr.UserId] = nil
		
		processCommand("notify", "Player ESP", framework.utils.strings.format("ESP disabled on %s", plr.Name))
	end)
	
	addCommand({"unlocateall", "nolocateall", "unlocall", "nolocall"}, {}, "Removes the ESP from all the highlighted players", function()
		processCommand("unesp")
	end)
	
	workspace.DescendantAdded:Connect(partAdded)
	Players.PlayerAdded:Connect(createPlayerEsp)
end

do
	local keyboardName = framework.utils.strings.random()
	local mouseName = framework.utils.strings.random()
	local camName = framework.utils.strings.random()
	local fcRunning = false
	
	local Camera = workspace.CurrentCamera
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		local newCamera = workspace.CurrentCamera
		if newCamera then
			Camera = newCamera
		end
	end)

	local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value

	Spring = {} do
		Spring.__index = Spring

		function Spring.new(freq, pos)
			local self = setmetatable({}, Spring)
			self.f = freq
			self.p = pos
			self.v = pos*0
			return self
		end

		function Spring:Update(dt, goal)
			local f = self.f*2*math.pi
			local p0 = self.p
			local v0 = self.v

			local offset = goal - p0
			local decay = math.exp(-f*dt)

			local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
			local v1 = (f*dt*(offset*f - v0) + v0)*decay

			self.p = p1
			self.v = v1

			return p1
		end

		function Spring:Reset(pos)
			self.p = pos
			self.v = pos*0
		end
	end
	
	local cameraPos = Vector3.new()
	local cameraRot = Vector2.new()

	local velSpring = Spring.new(5, Vector3.new())
	local panSpring = Spring.new(5, Vector2.new())

	Input = {} do
		keyboard = {
			W = 0,
			A = 0,
			S = 0,
			D = 0,
			E = 0,
			Q = 0,
			Up = 0,
			Down = 0,
			LeftShift = 0,
		}

		mouse = {
			Delta = Vector2.new(),
		}

		NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
		PAN_MOUSE_SPEED = Vector2.new(1, 1)*(math.pi/64)
		NAV_ADJ_SPEED = 0.75
		NAV_SHIFT_MUL = 0.25

		navSpeed = 1

		function Input.Vel(dt)
			navSpeed = math.clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)

			local kKeyboard = Vector3.new(
				keyboard.D - keyboard.A,
				keyboard.E - keyboard.Q,
				keyboard.S - keyboard.W
			)*NAV_KEYBOARD_SPEED

			local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)

			return (kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
		end

		function Input.Pan(dt)
			local kMouse = mouse.Delta*PAN_MOUSE_SPEED
			mouse.Delta = Vector2.new()
			return kMouse
		end

		do
			function Keypress(action, state, input)
				keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
				return Enum.ContextActionResult.Sink
			end

			function MousePan(action, state, input)
				local delta = input.Delta
				mouse.Delta = Vector2.new(-delta.y, -delta.x)
				return Enum.ContextActionResult.Sink
			end

			function Zero(t)
				for k, v in pairs(t) do
					t[k] = v*0
				end
			end

			function Input.StartCapture()
				ContextActionService:BindActionAtPriority(keyboardName, Keypress, false, INPUT_PRIORITY,
					Enum.KeyCode.W,
					Enum.KeyCode.A,
					Enum.KeyCode.S,
					Enum.KeyCode.D,
					Enum.KeyCode.E,
					Enum.KeyCode.Q,
					Enum.KeyCode.Up,
					Enum.KeyCode.Down
				)
				ContextActionService:BindActionAtPriority(mouseName, MousePan, false, INPUT_PRIORITY,Enum.UserInputType.MouseMovement)
			end

			function Input.StopCapture()
				navSpeed = 1
				Zero(keyboard)
				Zero(mouse)
				ContextActionService:UnbindAction(keyboardName)
				ContextActionService:UnbindAction(mouseName)
			end
		end
	end

	local GetFocusDistance = framework.protected:GCProtect(function(cameraFrame)
		local znear = 0.1
		local viewport = Camera.ViewportSize
		local projy = 2*math.tan(cameraFov/2)
		local projx = viewport.x/viewport.y*projy
		local fx = cameraFrame.rightVector
		local fy = cameraFrame.upVector
		local fz = cameraFrame.lookVector

		local minVect = Vector3.new()
		local minDist = 512

		for x = 0, 1, 0.5 do
			for y = 0, 1, 0.5 do
				local cx = (x - 0.5)*projx
				local cy = (y - 0.5)*projy
				local offset = fx*cx - fy*cy + fz
				local origin = cameraFrame.p + offset*znear
				local _, hit = workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
				local dist = (hit - origin).magnitude
				if minDist > dist then
					minDist = dist
					minVect = offset.unit
				end
			end
		end

		return fz:Dot(minVect)*minDist
	end)

	local StepFreecam = framework.protected:GCProtect(function(dt)
		local vel = velSpring:Update(dt, Input.Vel(dt))
		local pan = panSpring:Update(dt, Input.Pan(dt))

		local zoomFactor = math.sqrt(math.tan(math.rad(70/2))/math.tan(math.rad(cameraFov/2)))

		cameraRot = cameraRot + pan*Vector2.new(0.75, 1)*8*(dt/zoomFactor)
		cameraRot = Vector2.new(math.clamp(cameraRot.x, -math.rad(90), math.rad(90)), cameraRot.y%(2*math.pi))

		local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*Vector3.new(1, 1, 1)*64*dt)
		cameraPos = cameraCFrame.p

		Camera.CFrame = cameraCFrame
		Camera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
		Camera.FieldOfView = cameraFov
	end)
	
	local PlayerState = {} do
		mouseBehavior = ""
		mouseIconEnabled = ""
		cameraType = ""
		cameraFocus = ""
		cameraCFrame = ""
		cameraFieldOfView = ""

		function PlayerState.Push()
			cameraFieldOfView = Camera.FieldOfView
			Camera.FieldOfView = 70

			cameraType = Camera.CameraType
			Camera.CameraType = Enum.CameraType.Custom

			cameraCFrame = Camera.CFrame
			cameraFocus = Camera.Focus

			mouseIconEnabled = UserInputService.MouseIconEnabled
			UserInputService.MouseIconEnabled = true

			mouseBehavior = UserInputService.MouseBehavior
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		end

		function PlayerState.Pop()
			Camera.FieldOfView = 70

			Camera.CameraType = cameraType
			cameraType = nil

			Camera.CFrame = cameraCFrame
			cameraCFrame = nil

			Camera.Focus = cameraFocus
			cameraFocus = nil

			UserInputService.MouseIconEnabled = mouseIconEnabled
			mouseIconEnabled = nil

			UserInputService.MouseBehavior = mouseBehavior
			mouseBehavior = nil
		end
	end
	
	local stopFreeCam
	local startFreeCam = framework.protected:GCProtect(function(pos)
		if fcRunning then
			stopFreeCam()
		end
		
		local cameraCFrame = Camera.CFrame
		if pos then
			cameraCFrame = pos
		end
		
		cameraRot = Vector2.new()
		cameraPos = cameraCFrame.p
		cameraFov = Camera.FieldOfView

		velSpring:Reset(Vector3.new())
		panSpring:Reset(Vector2.new())

		PlayerState.Push()
		RunService:BindToRenderStep(camName, Enum.RenderPriority.Camera.Value, StepFreecam)
		Input.StartCapture()
		fcRunning = true
	end)
	
	stopFreeCam = framework.protected:GCProtect(function()
		if not fcRunning then return end
		Input.StopCapture()
		RunService:UnbindFromRenderStep(camName)
		PlayerState.Pop()
		workspace.Camera.FieldOfView = 70
		fcRunning = false
	end)
	
	local conns = {}
	addCommand({"view", "spectate", "spec"}, {"playerName"}, "Spectate a specific player", function(name: string)
		local plr: Player = searchPlayer(name)
		if not plr then
			error("Player not found")
		end
		
		if plr.UserId == Players.LocalPlayer.UserId then
			processCommand("unview")
			return
		end
		
		for _, v in ipairs(conns) do
			v:Disconnect()
		end
		framework.utils.tables.clear(conns)
		
		stopFreeCam()
		local function spectate()
			repeat
				task.wait()
			until plr.Character and getRoot(plr)
			workspace.CurrentCamera.CameraSubject = plr.Character
		end
		
		framework.utils.tables.insert(conns, plr.CharacterAdded:Connect(spectate))
		framework.utils.tables.insert(conns, workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
			workspace.CurrentCamera.CameraSubject = plr.Character
		end))
		
		processCommand("notify", "Spectating", framework.utils.strings.format("You are now spectating %s", plr.Name))
		spectate()
	end)
	
	addCommand({"unview", "unspectate", "unspec"}, {}, "Stops spectating players or objects", function()
		local char = Players.LocalPlayer.Character
		if not char then
			error("Player's character not found")
		end
		
		for _, v in ipairs(conns) do
			v:Disconnect()
		end
		framework.utils.tables.clear(conns)
		
		workspace.CurrentCamera.CameraSubject = char
		processCommand("notify", "Spectating", "Spectating ended")
	end)
end

-- Commands with UIs

addCommand({"notify", "notification"}, {"title", "message", "duration"}, "Prompts a notification", function(title: string, message: string, duration: number)
	duration = tonumber(duration) or 3
	ui:AddComponent("toast", {
		Description = message,
		Duration = duration,
		Title = title
	})
end)

do
	local wpparts, showing = framework.protected:GCProtect({}), false
	local gamewp = waypoints[framework.utils.strings.tostring(game.PlaceId)] or framework.protected:GCProtect({})
	waypoints[framework.utils.strings.tostring(game.PlaceId)] = gamewp
	
	local newName = framework.protected:GCProtect(function()
		local name, found, num = "", false, 1
		
		repeat
			name = framework.utils.strings.format("Waypoint %i", num)
			found = true
			
			for i, waypoint in ipairs(gamewp) do
				if waypoint.name == name then
					found = false
					break
				end
			end
			
			task.wait()
		until found
		return name
	end)
	
	local updateWaypoints = framework.protected:GCProtect(function()
		for _, wp in ipairs(wpparts) do
			wp:Destroy()
		end
		
		if not showing then
			return
		end
		
		for _, wp in ipairs(gamewp) do
			local part = framework.protected:GetInstance("Part", {
				Position = Vector3.new(framework.utils.tables.unpack(wp.coords)),
				Material = Enum.Material.Neon,
				Size = Vector3.new(2, 2, 2),
				Shape = Enum.PartType.Ball,
				CanCollide = false,
				Anchored = true
			})

			framework.protected:GetInstance("Highlight", {
				FillTransparency = 0,
				Parent = part
			})

			local bill = framework.protected:GetInstance("BillboardGui", {
				StudsOffset = Vector3.new(0, part.Size.Y *5, 0),
				Size = UDim2.fromOffset(200, 50),
				ResetOnSpawn = false,
				AlwaysOnTop = true,
				Adornee = part,
				Parent = part
			})

			local lbl = framework.protected:GetInstance("TextLabel", {
				TextColor3 = Color3.fromRGB(255, 0, 0),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				TextScaled = true,
				Text = wp.name,
				Parent = bill
			})
			
			framework.protected:GetInstance("UIStroke", {
				Color = Color3.fromRGB(255, 255, 255),
				Thickness = 3,
				Parent = lbl
			})

			local at1 = framework.protected:GetInstance("Attachment", {
				Parent = part
			})

			local at2 = framework.protected:GetInstance("Attachment", {
				Position = Vector3.new(0, 999, 0),
				Parent = part
			})

			framework.protected:GetInstance("Beam", {
				Width0 = part.Size.X,
				Width1 = part.Size.X,
				Attachment0 = at1,
				Attachment1 = at2,
				FaceCamera = true,
				Parent = part
			})

			framework.utils.tables.insert(wpparts, part)
			part.Parent = workspace
		end
	end)
	
	local getWaypoint = framework.protected:GCProtect(function(name: string)
		if not name then
			error("Invalid name")
		end
		
		name = name:lower()
		for i, waypoint in ipairs(gamewp) do
			if waypoint.name == name then
				return waypoint, i
			end
		end

		return false
	end)
	
	local addWaypoint = framework.protected:GCProtect(function(name: string, x: number, y: number, z: number)
		if getWaypoint(name) then
			error("This name is already in use")
		end
		
		framework.utils.tables.insert(gamewp, framework.protected:ProtectTable({
			name = name:lower(),
			coords = {x, y, z}
		}))
		
		processCommand("notify", "Waypoints", framework.utils.strings.format("Created waypoint %s", name))
		framework.storage.writeJsonFile("configs", "waypoints", waypoints, FILES_KEY)
		updateWaypoints()
	end)
	
	addCommand({"setwaypoint", "setwp", "swp", "saveposition", "savepos", "spos", "addwaypoint", "addwp"}, {"name?"}, "Sets a waypoint at your position", function(name: string)
		local root = getRoot(Players.LocalPlayer)
		if not root then
			error("Unable to find the player position")
		end
		
		name = name or newName()
		return addWaypoint(name,
			framework.utils.maths.round(root.Position.X),
			framework.utils.maths.round(root.Position.Y),
			framework.utils.maths.round(root.Position.Z)
		)
	end)

	addCommand({"waypointposition", "waypointpos", "wpp", "setwaypointpos"}, {"name?", "X", "Y", "Z"}, "Sets a waypoint with specified coordinates", function(name: string, x: number, y: number, z: number)
		x, y, z = tonumber(x), tonumber(y), tonumber(z)
		if not x or not y or not z then
			error("Invalid coordinates")
		end
		
		name = name or newName()
		return addWaypoint(name, x, y, z)
	end)

	addCommand({"waypoints", "positions"}, {}, "Shows a list of the waypoints", function()
		if true then -- Coming soon
			error("This command is under developement")
		end
		
		-- Add UI
	end)
	
	addCommand({"showwaypoints", "togglewaypoints", "showwps", "showwp", "togglewps", "togglewp"}, {}, "Toggles the visibility of the waypoints", function()
		showing = not showing
		updateWaypoints()
	end)
	
	addCommand({"hidewaypoints", "hidewps", "hidewp"}, {}, "Hides the waypoints", function()
		showing = false
		updateWaypoints()
	end)
	
	addCommand({"towaypoint", "towp", "toposition", "topos"}, {"name"}, "Teleports you to a waypoint", function(name: string)
		local wp = getWaypoint(name)
		if not wp then
			error("Invalid waypoint name")
		end
		
		local char = Players.LocalPlayer.Character
		if not char then
			error("Unable to find the player body")
		end
		
		char:PivotTo(CFrame.new(Vector3.new(framework.utils.tables.unpack(wp.coords))))
		processCommand("notify", "Waypoints", framework.utils.strings.format("Moved to waypoint %s", wp.name))
	end)
	
	addCommand({"tweenwaypoint", "tweenwp", "tweenposition", "tweenpos"}, {"name", "time?"}, "Tweens your position to the waypoint in N seconds", function(name: string, sec: number)
		local wp = getWaypoint(name)
		if not wp then
			error("Invalid waypoint name")
		end

		local root = getRoot(Players.LocalPlayer)
		if not root then
			error("Unable to find the player body")
		end
		
		sec = tonumber(sec) or 1
		sec = sec < 0 and 0 or sec
		
		TweenService:Create(root, TweenInfo.new(sec, Enum.EasingStyle.Linear), {
			CFrame = CFrame.new(framework.utils.tables.unpack(wp.coords))
		}):Play()
	end)
	
	local walking = false
	addCommand({"walktowaypoint", "wtwp"}, {"name", "disablePathFinding?"}, "Makes you walk to the waypoint", function(name: string, disablePathFinding: boolean)
		local wp = getWaypoint(name)
		if not wp then
			error("Invalid waypoint name")
		end

		local hum = getHum(Players.LocalPlayer)
		if not hum then
			error("Unable to find the player body")
		end
		
		if hum.SeatPart then
			hum.Sit = false
			task.wait(.1)
		end
		
		local coords = Vector3.new(framework.utils.tables.unpack(wp.coords))
		processCommand("notify", "Waypoints", framework.utils.strings.format("Walking to waypoint %s", wp.name))
		
		walking = true
		if disablePathFinding then
			hum.WalkToPoint = coords
		else
			local path = PathfindingService:CreatePath()
			local success, response = pcall(function()
				path:ComputeAsync(getRoot(Players.LocalPlayer).Position, coords)
				local wps = path:GetWaypoints()
					
				local distance 
				for i, point in ipairs(wps) do
					local pointPos = point.Position
					hum:MoveTo(pointPos)
						
					repeat 
						distance = (pointPos - getRoot(Players.LocalPlayer).Position).magnitude
						task.wait()
						
						if not walking then
							return
						end
					until distance <= 5
				end
			end)
				
			if not success then
				hum:MoveTo(coords)
			end
		end	
			
		walking = false
	end)
	
	addCommand({"deletewaypoint", "delwp", "deleteposition", "delpos", "removewaypoint", "remwp"}, {"name"}, "Removes a waypoint", function(name: string)
		local wp, i = getWaypoint(name)
		if not wp then
			error("Invalid waypoint name")
		end
		
		processCommand("notify", "Waypoints", framework.utils.strings.format("Deleted waypoint %s", wp.name))
		framework.utils.tables.remove(gamewp, i)
		
		framework.storage.writeJsonFile("configs", "waypoints", waypoints, FILES_KEY)
		updateWaypoints()
	end)
	
	addCommand({"wipewaypoints", "clearallwaypoints", "wipepositions", "wipewp", "wipepos"}, {}, "Removes every waypoint ever saved", function()
		framework.utils.tables.clear(waypoints)
		framework.storage.writeJsonFile("configs", "waypoints", waypoints, FILES_KEY)
		processCommand("notify", "Waypoints", "Removed all waypoints")
		updateWaypoints()
	end)
	
	addCommand({"cleargamewaypoints", "cgamewps", "cgamewp"}, {}, "Removes all waypoints related to the current game", function()
		framework.utils.tables.clear(gamewp)
		framework.storage.writeJsonFile("configs", "waypoints", waypoints, FILES_KEY)
		processCommand("notify", "Waypoints", "Removed all the waypoints in the game")
		updateWaypoints()
	end)
	
	addCommand({"unwalk", "stopwalk", "stopwalking"}, {}, "Stops the walk to a checkpoint", function()
		walking = false
	end)
end

do
	local succ, placeInfo
	addCommand({"serverinfo", "gameinfo", "info"}, {}, "Gives infos about the server", function()
		if true then -- Coming soon
			error("This command is under developement")
		end
		
		if not succ then
			succ, placeInfo = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
		end

		placeInfo = succ and placeInfo or {
			Name = "Unknown"
		}

		placeInfo.PlaceId = game.PlaceId
		return {
			place = placeInfo,
			localPlayer = function()
				local lp = Players.LocalPlayer

				return {
					PlayerID = lp.UserId,
					Appearance = lp.CharacterAppearanceId
				}
			end,

			players = function()
				return {
					CurrentPlayers = #Players:GetPlayers(),
					MaxPlayers = Players.MaxPlayers
				} 
			end,

			playtime = function()
				local seconds = framework.utils.maths.floor(workspace.DistributedGameTime)
				local minutes = framework.utils.maths.floor(workspace.DistributedGameTime / 60)
				local hours = framework.utils.maths.floor(workspace.DistributedGameTime / 60 / 60)
				local seconds = seconds - (minutes * 60)
				local minutes = minutes - (hours * 60)

				if hours < 1 then
					if minutes < 1 then
						return framework.utils.strings.format("%s Second(s)", seconds)
					else
						return framework.utils.strings.format("%s Minute(s), %s Second(s)", minutes, seconds)
					end
				else
					return framework.utils.strings.format("%s Hour(s), %s Minute(s), %s Second(s)", hours, minutes, seconds)
				end
			end,

			server = {
				JobId = game.JobId,
				joinScript = processCommand("joinscript", true)
			}
		}
	end)
end

--[[

breakloops
showguis
unshowguis
allowrejoin

]]