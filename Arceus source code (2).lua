(function() return [[

	  /$$$$$$  /$$$$$$$   /$$$$$$  /$$$$$$$$ /$$   /$$  /$$$$$$        /$$   /$$       /$$    /$$ /$$$$$$$ 
	 /$$__  $$| $$__  $$ /$$__  $$| $$_____/| $$  | $$ /$$__  $$      | $$  / $$      | $$   | $$| $$____/ 
	| $$  \ $$| $$  \ $$| $$  \__/| $$      | $$  | $$| $$  \__/      |  $$/ $$/      | $$   | $$| $$      
	| $$$$$$$$| $$$$$$$/| $$      | $$$$$   | $$  | $$|  $$$$$$        \  $$$$/       |  $$ / $$/| $$$$$$$ 
	| $$__  $$| $$__  $$| $$      | $$__/   | $$  | $$ \____  $$        >$$  $$        \  $$ $$/ |_____  $$
	| $$  | $$| $$  \ $$| $$    $$| $$      | $$  | $$ /$$  \ $$       /$$/\  $$        \  $$$/   /$$  \ $$
	| $$  | $$| $$  | $$|  $$$$$$/| $$$$$$$$|  $$$$$$/|  $$$$$$/      | $$  \ $$         \  $/   |  $$$$$$/
	|__/  |__/|__/  |__/ \______/ |________/ \______/  \______/       |__/  |__/          \_/     \______/ 
                                                                                                                                                                                
	- UI Designed & Built by blackmomo
	- Framework & Codebase by riky47
	- Backend by tiahh
	
	Welcome, take a look at this non-skidded source.
	
]] end)()

if not LPH_OBFUSCATED then -- Luraph integration
	local dummy = function(...) return ... end
	LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or dummy
	LPH_NO_UPVALUES = LPH_NO_UPVALUES or dummy
	LPH_OBFUSCATED = LPH_OBFUSCATED or false
	LPH_JIT_MAX = LPH_JIT_MAX or dummy
	LPH_ENCFUNC = LPH_ENCFUNC or dummy
	LPH_ENCSTR = LPH_ENCSTR or dummy
	LPH_ENCNUM = LPH_ENCNUM or dummy
	LPH_CRASH = LPH_CRASH or dummy
	LPH_JIT = LPH_JIT or dummy
end

local framework, endpoints do
	endpoints = {
		arceus_neo = LPH_ENCSTR("https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main"),
		xploit = LPH_ENCSTR("https://raw.githubusercontent.com/Riky47/Xploit-Framework/refs/heads/main"),
		scriptblox = LPH_ENCSTR("https://scriptblox.com"),
		api = LPH_ENCSTR("https://spdmteam.com/api"),

		rbxcdn = {
			tr = LPH_ENCSTR("https://tr.rbxcdn.com"),
			t1 = LPH_ENCSTR("https://t1.rbxcdn.com")
		}
	}

	endpoints.arceus_v = `{endpoints.arceus_neo}/axv5`
	pcall(function() loadstring(game:HttpGet(`{endpoints.arceus_neo}/init.lua`))() end)

	-- Include Arceus X adapter
	local axinclude, axerr = pcall(function()
		loadstring(game:HttpGet(`{endpoints.arceus_neo}/adapter.lua`))()
	end)

	-- Include framework
	local cloneref = cloneref or function(...) return ... end
	local run: RunService = cloneref(game:GetService("RunService"))

	if run:IsStudio() then 
		if _G.Once then return end _G.Once = true
		framework = require(game:GetService("StarterGui"):WaitForChild("Wave"):WaitForChild("WaveFramework"))
	else
		framework = loadstring(arceus.WHWKIIIIWIIOSU(game:HttpGet(`https://raw.githubusercontent.com/SPDM-Team/Arceus-X-NEO-public/refs/heads/main/axv5/Xploit-Framework/index.lua`)))()
	end
	
	if not axinclude and not framework.protected:IsStudio() then
		return framework.console.error("Unable to load Arceus X Adapter: " .. axerr)
	end

	-- Adapter to SPDM file system
	local spdminclude, spdmerr = pcall(function()
		loadstring(framework.utils.http:Get(`{endpoints.xploit}/mods/spdm-fs.lua`))(framework)
	end)

	if not spdminclude and not framework.protected:IsStudio() then
		return framework.console.error("Unable to load SPDM file system adapter: " .. spdmerr)
	end
end

-- Configs
local EXPLOIT_CONFIGS, OS_CONFIGS do
	OS_CONFIGS = {
		IS_IOS = (framework.env.arceus and framework.env.arceus.is_ios or function()
			return (not framework.protected:IsStudio()) and framework.protected:GetService("UserInputService"):GetPlatform() == Enum.Platform.IOS or false
		end)(),
		
		IS_VNG = (framework.env.arceus and framework.env.arceus.is_vng or function()
			return false
		end)(),
		
		DEVICE_INFO = framework.env.arceus and framework.env.arceus.WOWPALAKSZMNXBRU or function()
			return false
		end,
		
		HWID = (framework.env.gethwid)()
	}
	OS_CONFIGS.HIDE_PREFIX = OS_CONFIGS.IS_IOS and "" or "."
	
	EXPLOIT_CONFIGS = {
		EXPLOIT_FULLNAME = LPH_ENCSTR("Arceus X v5"),
		EXPLOIT_IDENTITY = LPH_ENCSTR("Arceus"),
		UI_VERSION = LPH_ENCSTR("1.0.0"),

		API_CRYPT = LPH_ENCSTR("SPDMTeam_1LPPWJfrnW8BSlsj24D54ghgkXakSd2bztZGJouYfITeRNNZhVFcShtIUlbLZSPJ"),
		FILES_KEY = LPH_ENCSTR("ARCEUS_W6dKPSt6TTzAdS4pYVG3IKu9iigp8Kb66bbu9E08Osw9wGUztD5ENIezDxp30Yz7"),
		CLOUD_SCRIPTS = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("cloudscripts.ax"),
		SETTINGS_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("settings.ax"),
		LICENSE_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("license.ax"),
		VERSION_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("version.ax"),
		PLUGINS_FILE = OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("plugins.ax"),
		TABS_FILE = LPH_ENCSTR("Tabs.json"),

		AUTH_FETCH_DELAY = 5,
		SETTINGS = {
			Popups_Confirmation = true,
			Popups_Toast = true,

			Colors_Primary = Color3.fromRGB(219, 0, 0):ToHex(),
			Colors_Secondary = Color3.fromRGB(0, 0, 0):ToHex(),

			Colors_Text_Primary = Color3.fromRGB(255, 255, 255):ToHex(),
			Colors_Text_Secondary = Color3.fromRGB(100, 100, 100):ToHex(),

			FontSizes_Editor = 16,
			TextboxWrapper = false,
			Anim_Quality = "High",
			Country_Code = "EN",
			UI_WindowState = 1,
			
			User_AI_OpenAI = "",
			User_Intro = true,
			User_EMail = "",
			
			Setting_Fps = 60,
			Settings_Afk = false,

			Fonts_HeadingItalic = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium, Enum.FontStyle.Italic),
			Fonts_Description = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), -- Descrizioni secondarie o testi leggeri
			Fonts_Editor = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Fonts_Black = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), -- Titoli principali
			Fonts_Heading = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), -- Sottotitoli o intestazioni
			Fonts_Body = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), -- Testo principale
			Fonts_Caption = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Thin, Enum.FontStyle.Italic), -- Annotazioni, piccole etichette
			Fonts_Title = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal) -- Titoli principali
		}
	}
	
	framework.protected:ProtectTable(OS_CONFIGS)
	framework.protected:ProtectTable(EXPLOIT_CONFIGS)
end

local ARCEUS_FOLDERS do
	ARCEUS_FOLDERS = framework.protected:GCProtect({
		AUTOEXECUTE = framework.storage:CreateDirectory(LPH_ENCSTR("autoexecute"), LPH_ENCSTR("Autoexec")),
		SCRIPT_HUB = framework.storage:CreateDirectory(LPH_ENCSTR("scripthub"), LPH_ENCSTR("Script Hub")),
		WORKSPACE = framework.storage:CreateDirectory(LPH_ENCSTR("workspace"), LPH_ENCSTR("Workspace")),--OS_CONFIGS.IS_IOS and "" or LPH_ENCSTR("Workspace")),
		CONFIGS = framework.storage:CreateDirectory(LPH_ENCSTR("configs"), LPH_ENCSTR("Configs"))
	})

	-- Sub directories
	ARCEUS_FOLDERS.CACHE = ARCEUS_FOLDERS.WORKSPACE:AddSubDirectory(LPH_ENCSTR("cache"), OS_CONFIGS.HIDE_PREFIX.. LPH_ENCSTR("AxCache")) -- Hidden folders should not show pictures in gallery
	ARCEUS_FOLDERS.TABS = ARCEUS_FOLDERS.SCRIPT_HUB:AddSubDirectory(LPH_ENCSTR("tabs"), LPH_ENCSTR("Tabs"))
	ARCEUS_FOLDERS.RAW = ARCEUS_FOLDERS.CONFIGS:AddSubDirectory(LPH_ENCSTR("raw"), LPH_ENCSTR("Raw"))

	-- block folders in workspace
	local blocked = framework.protected:GCProtect({ "axcache" })
	local lower, match, err = framework.protected:GetFunction(framework.utils.strings.lower),
		framework.protected:GetFunction(framework.utils.strings.match), framework.protected:GetFunction(error)

	local writefile = framework.env.getgenv().writefile or function() end
	framework.protected:GCProtect(writefile) -- protects the original
	writefile = framework.protected:GetFunction(writefile)

	local wf = function(path: string, ...)
		local low = lower(path)
		for _, folder in blocked do
			if match(low, "^" ..folder)
				or match(low, "^/" ..folder)
				or match(low, "^\\" ..folder)

			then return err(LPH_ENCSTR("Attempt to write in a restricted folder")) end
		end
		writefile(path, ...)
	end
	framework.env.getgenv().writefile = wf

	-- clear cache
	for _, file in ipairs(ARCEUS_FOLDERS.CACHE:ListFiles()) do
		framework.storage.deleteFile(nil, file)
	end
	
	framework.protected:ProtectTable(ARCEUS_FOLDERS)
end

-- Configure
framework.enums:AddEnum("TabUpdate", "Name", "Source", "Removed", "Selected", "Unselected")
framework.enums:AddEnum("WindowState", "Base", "Large", "Full")
framework.enums:AddEnum("AnimQuality", "Low", "Medium", "High")
framework.enums:AddEnum("CountryCode", "EN","IT","VI","PT","ID","RU","DE","ES","FR","ZH","JA","AR","HI","TH")

framework.enums:AddEnum("ScriptBloxSort", "None", "CreatedAt", "UpdatedAt", "Views", "LikeCount", "DislikeCount")
framework.enums:AddEnum("ScriptBloxVerify", "None", "Verified", "Unverified")
framework.enums:AddEnum("ScriptBloxType", "None", "Universal", "Specific")
framework.enums:AddEnum("ScriptBloxPatch", "None", "Patched", "Unpatched")
framework.enums:AddEnum("ScriptBloxSearch", "None", "Default", "Strict")
framework.enums:AddEnum("ScriptBloxAuth", "None", "Key", "Keyless")
framework.enums:AddEnum("ScriptBloxOrder", "None", "Asc", "Desc")
framework.enums:AddEnum("ScriptBloxMode", "None", "Free", "Paid")

framework.console:SetTitle(EXPLOIT_CONFIGS.EXPLOIT_FULLNAME)
framework.protected:UseUndetectedContent(not framework.protected:IsStudio())

framework.settings:SetDirectory(ARCEUS_FOLDERS.CONFIGS)
framework.settings:SetFileName(EXPLOIT_CONFIGS.SETTINGS_FILE)
framework.settings:SetFileKey(EXPLOIT_CONFIGS.FILES_KEY)
framework.settings:SetDefault(EXPLOIT_CONFIGS.SETTINGS)

task.spawn(LPH_NO_VIRTUALIZE(function() -- SaveInstances
	if true or framework.protected:IsStudio() then return end -- disabled
	
	local httpService = framework.protected:GetService("HttpService")
	local jsonDecode = framework.env.clonefunction(httpService.JSONDecode);
	local getScriptBytecode = framework.env.getscriptbytecode;
	local isA = framework.env.clonefunction(workspace.IsA);

	local data = {
		compatiblity = {
			binaryStrings = select(1, pcall(framework.env.gethiddenproperty or function() return game.CauseMeAnError; end, workspace.Terrain, "MaterialColors")) == true,
			sharedStrings = select(1, pcall(framework.env.gethiddenproperty or function() return game.CauseMeAnError; end, Instance.new("Model"), "ModelMeshData")) == true
		},
		xml = {
			cframeComponents = { "X", "Y", "Z", "R00", "R01", "R02", "R10", "R11", "R12", "R20", "R21", "R22" },
			customPhysicsComponents = { "Density", "Friction", "Elasticity", "FrictionWeight", "ElasticityWeight" };
			overwrites = {
				EnumItem = "token",
				Rect = "Rect2D"
			},
			pattern = "[&<>\"'\0]",
			escapes = {
				["<"] = "&lt;",
				[">"] = "&gt;",
				["\""] = "&quot;",
				["'"] = "&apos;",
				["&"] = "&amp;",
				["\0"] = ""
			}
		},
		classes = {
			overwrites = {
				Enum = "EnumItem",
				Class = "Ref"
			},
			folders = {
				[""] = true,
				["Player"] = true,
				["PlayerGui"] = true,
				["PlayerScripts"] = true
			}
		}
	};

	--[[ Base Functions ]]--

	local function shallowMerge(priority: {string: any}, backup: {string: any}): {string: any}
		if type(backup) == "table" then
			for i, v in priority do
				local backupValue = backup[i];
				if type(v) == type(backupValue) then
					priority[i] = backupValue;
				end
			end
		end
		return priority;
	end

	local function newHandler(modifier: (number) -> (string)): {string: any}
		return setmetatable({
			count = 0,
			cache = {}
		}, {
			__index = function(t, k)
				if t.cache[k] == nil then
					t.count += 1;
					t.cache[k] = modifier(t.count);
				end
				return t.cache[k];
			end
		});
	end

	--[[ Instance Checks ]]--

	local function isService(className: string): boolean
		return data.api[className] and data.api[className].isService;
	end

	local function isViableDecompileScript(scriptInstance: BaseScript): boolean
		if scriptInstance:IsA("ModuleScript") then
			return true;
		elseif scriptInstance:IsA("LocalScript") and (scriptInstance.RunContext == Enum.RunContext.Client or scriptInstance.RunContext == Enum.RunContext.Legacy) then
			return true;
		elseif scriptInstance:IsA("Script") and scriptInstance.RunContext == Enum.RunContext.Client then
			return true;
		end
		return false;
	end

	local function getProperty(object: Instance, name: string, value: {string: any}): (boolean, any)
		local success, grabbedValue;
		if value.isHidden then
			if value.valueType == "BinaryString" and data.compatiblity.binaryStrings == false then
				return false;
			elseif value.valueType == "SharedString" and data.compatiblity.sharedStrings == false then
				return false;
			end
			success, grabbedValue = pcall(framework.env.gethiddenproperty, object, name);
		else
			success, grabbedValue = pcall(function()
				return object[name];
			end);
		end
		return success, grabbedValue;
	end

	--[[ Conversion ]]--

	local function convertToBitValue(...: {any}): number
		local value = 0;
		for i, v in {...} do
			if v then
				value += 2 ^ (i - 1);
			end
		end
		return value;
	end

	local function sanitiseStringValue(value: string): string
		return string.gsub(value, data.xml.pattern, data.xml.escapes);
	end

	local function sanitiseNumberValue(value: number, denominations: number): string
		if value == 0 or value % 1 == 0 then
			return value;
		elseif value == math.huge then
			return "INF";
		elseif value == -math.huge then
			return "-INF";
		elseif value ~= value then
			return "NAN";
		elseif denominations == nil then
			return value;
		end
		return string.format("%." .. denominations .. "g", value);
	end

	--[[ Api ]]--

	local function getClassFromApi(api: {string: any}, class: string): {string: any}
		for _, v in api.Classes do
			if v.Name == class then
				return v;
			end
		end
	end

	local function pullApi(): {string: any}
		local latestVersion = nil;
		local versionArray = string.split(game:HttpGet("https://setup.rbxcdn.com/DeployHistory.txt", true), "\n");
		for i = #versionArray, 1, -1 do
			local versionData = string.split(versionArray[i], " ");
			if versionData[2] == "Studio64" then
				latestVersion = versionData[3];
				break;
			end
		end
		return httpService:JSONDecode(game:HttpGet("http://setup.roblox.com/" .. latestVersion .. "-Full-API-Dump.json", true));
	end

	local function generatePropertyData(api: {string: any}, class: {string: any}): {string: any}
		local currentClass = class;
		local changes = 0;
		local properties = {};
		while currentClass and currentClass.Name ~= "<<<ROOT>>>" do
			for _, v in currentClass.Members do
				if v.MemberType == "Property" and v.Name ~= "Parent" and v.Serialization.CanLoad and v.Serialization.CanSave then
					properties[v.Name] = {
						valueType = data.classes.overwrites[v.ValueType.Category] or v.ValueType.Name,
						isHidden = v.Tags and table.find(v.Tags, "NotScriptable")
					};
				end
			end
			currentClass = getClassFromApi(api, currentClass.Superclass);
			changes += 1;
		end
		return properties;
	end

	local function generateClassData(api: {string: any}): {string: any}
		local generatedClassData = {};
		for _, v in api.Classes do
			local classData = {
				properties = generatePropertyData(api, v),
				defaults = {},
				isService = v.Tags and table.find(v.Tags, "Service")
			};
			local success, instance = pcall(Instance.new, v.Name);
			if success then
				for i2, v2 in classData.properties do
					local success2, value = getProperty(instance, i2, v2);
					if success2 then
						classData.defaults[i2] = value;
					end
				end
			end
			generatedClassData[v.Name] = classData;
		end
		return generatedClassData;
	end

	--[[ Saveinstance Module ]]--

	local saveinstanceModule = {};
	saveinstanceModule.__index = saveinstanceModule;

	function saveinstanceModule.new(options: {string: any}): {string: any}
		local metatable = setmetatable({
			database = { "<roblox xmlns:xmime=\"http://www.w3.org/2005/05/xmlmime\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"http://www.roblox.com/roblox.xsd\" version=\"4\">" },
			options = options,
			instances = 0,
			exclusions = {
				game:GetService("CoreGui"),
				game:GetService("CorePackages"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("PlayerModule"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("PlayerScriptsLoader"),
				game:GetService("StarterPlayer").StarterPlayerScripts:FindFirstChild("RbxCharacterSounds")
			},
			decompiled = {},
			refHandler = newHandler(function(count)
				return "RBX" .. count;
			end),
			sharedStringHandler = newHandler(function(count)
				return framework.utils.crypt.base64.encode(tostring(count + 1e15));
			end)
		}, saveinstanceModule);

		for i, v in metatable.exclusions do
			if isViableDecompileScript(v) then
				metatable.exclusions[i] = framework.env.getscripthash(v);
			end
		end

		return metatable;
	end

	function saveinstanceModule:IsExcludedItem(object: Instance): boolean
		local isScript = isViableDecompileScript(object);
		for _, v in self.exclusions do
			if v == object then
				return true;
			elseif isScript and type(v) == "string" then
				local s, r = pcall(framework.env.getscripthash, object);
				if s and r == v then
					return true;
				end
			end
		end
		if object:IsA("Player") then
			return true;
		end
		return false;
	end

	function saveinstanceModule:CreateBaseDirectory(name: string): Folder
		local folder = Instance.new("Folder");
		folder.Name = name;
		task.defer(function()
			folder:Destroy();
		end);
		return folder;
	end

	function saveinstanceModule:GetProperty(object: Instance, name: string, value: {string: any}): (boolean, any)
		if name == "Source" and self.decompiled[object] then
			return true, self.decompiled[object];
		end
		return getProperty(object, name, value);
	end

	function saveinstanceModule:ParseProperty(value: any, valueType: string, bypassSanitising: boolean): string
		if valueType == "Axes" then
			return string.format("<axes>%d</axes>", convertToBitValue(value.X, value.Y, value.Z));
		elseif valueType == "BinaryString" then
			return value == "" and "" or self:ParseProperty(framework.utils.crypt.base64.encode(value), "ProtectedString");
		elseif valueType == "bool" then
			return value and "true" or "false";
		elseif valueType == "BrickColor" then
			return value.Number;
		elseif valueType == "CFrame" or valueType == "CoordinateFrame" then
			local ret = "";
			for _, v in data.xml.cframeComponents do
				ret ..= string.format("<%s>%%g</%s>", v, v);
			end
			return string.format(ret, value:GetComponents());
		elseif valueType == "Color3" then
			return string.format("<R>%g</R><G>%g</G><B>%g</B>", value.R, value.G, value.B);
		elseif valueType == "Color3uint8" then
			return 0xFF000000 + (math.floor(value.R * 255) * 0x10000) + (math.floor(value.G * 255) * 0x100) + math.floor(value.B * 255)
		elseif valueType == "ColorSequence" then
			local ret = {};
			for _, v in value.Keypoints do
				ret[#ret + 1] = string.format("%g %g %g %g 0", v.Time, v.Value.R, v.Value.G, v.Value.B);
			end
			return table.concat(ret, " ");
		elseif valueType == "Content" or valueType == "ContentId" then
			if value == "" then
				return "<null></null>";
			end
			return string.format("<url>%s</url>", sanitiseStringValue(value));
		elseif valueType == "DateTime" then
			return value.UnixTimestampMillis;
		elseif valueType == "double" then
			return sanitiseNumberValue(value, 16);
		elseif valueType == "EnumItem" then
			return value.Value;
		elseif valueType == "Faces" then
			return string.format("<faces>%d</faces>", convertToBitValue(value.Right, value.Top, value.Back, value.Left, value.Bottom, value.Front));
		elseif valueType == "float" then
			return sanitiseNumberValue(value, 8);
		elseif valueType == "Font" then
			return string.format("<Family>%s</Family><Weight>%s</Weight><Style>%s</Style>", self:ParseProperty(value.Family, "Content"), value.Weight.Value, value.Style.Name);
		elseif valueType == "int" or valueType == "int64" then
			return sanitiseNumberValue(value);
		elseif valueType == "NumberRange" then
			return string.format("%g %g", value.Min, value.Max);
		elseif valueType == "NumberSequence" then
			local ret = {};
			for _, v in value.Keypoints do
				ret[#ret + 1] = string.format("%g %g %g", v.Time, v.Value, v.Envelope);
			end
			return table.concat(ret, " ");
		elseif valueType == "PhysicalProperties" then
			local ret = string.format("<CustomPhysics>%s</CustomPhysics>", value and "true" or "false");
			if value then
				for _, v in data.xml.customPhysicsComponents do
					ret ..= string.format("<%s>%g</%s>", v, value[v], v);
				end
			end
			return ret;
		elseif valueType == "ProtectedString" then
			return string.format("<![CDATA[%s]]>", bypassSanitising and value or sanitiseStringValue(value));
		elseif valueType == "Ray" then
			return string.format("<origin>%s</origin><direction>%s</direction>", self:ParseProperty(value.Origin, "Vector3"), self:ParseProperty(value.Direction, "Vector3"));
		elseif valueType == "Rect" then
			return string.format("<min>%s</min><max>%s</max>", self:ParseProperty(value.Min, "Vector2"), self:ParseProperty(value.Max, "Vector2"));
		elseif valueType == "Ref" then
			return value and self.refHandler[value] or "null";
		elseif valueType == "SharedString" then
			return self.sharedStringHandler[framework.utils.crypt.base64.encode(value)];
		elseif valueType == "string" then
			return sanitiseStringValue(value);
		elseif valueType == "UDim" then
			return string.format("<S>%g</S><O>%d</O>", value.Scale, value.Offset);
		elseif valueType == "UDim2" then
			return string.format("<XS>%g</XS><XO>%d</XO><YS>%g</YS><YO>%d</YO>", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset);
		elseif valueType == "UniqueId" then
			return false;
		elseif valueType == "Vector2" or valueType == "Vector2int16" then
			return string.format("<X>%g</X><Y>%g</Y>", value.X, value.Y);
		elseif valueType == "Vector3" or valueType == "Vector3int16" then
			return string.format("<X>%g</X><Y>%g</Y><Z>%g</Z>", value.X, value.Y, value.Z);
		end
		-- print("Unaccounted for type found:", valueType);
		return "";
	end

	function saveinstanceModule:GetPropertyXml(propertyName: string, value: any, valueType: string): string
		local xmlValue = self:ParseProperty(value, valueType, propertyName == "Source");
		local newTag = data.xml.overwrites[valueType] or valueType;
		local xmlString = string.format("<%s name=\"%s\">%s</%s>", newTag, propertyName, xmlValue or "", newTag);
		if xmlValue then
			return xmlString;
		end
		return "<!-- " .. xmlString .. " -->";
	end

	function saveinstanceModule:ParseObject(object: Instance, altChildren: {number: Instance} | nil): nil
		if self:IsExcludedItem(object) then
			return;
		end

		local className = data.classes.folders[object.ClassName] and "Folder" or object.ClassName;
		table.insert(self.database, string.format("<Item class=\"%s\" referent=\"%s\">", className, self.refHandler[object]));

		local objectData = data.api[className];
		if objectData then
			table.insert(self.database, "<Properties>");
			for i, v in objectData.properties do
				local success, grabbedValue = self:GetProperty(object, i, v);
				if success and (self.options.excludeDefaults == false or grabbedValue ~= objectData.defaults[i]) then
					if typeof(grabbedValue) ~= "Content" then
						table.insert(self.database, self:GetPropertyXml(i, grabbedValue, v.valueType));
					end
				end
			end
			table.insert(self.database, "</Properties>");
			self.instances += 1;
		else
			-- print("Unaccounted for className found:", object:GetFullName());
		end

		for _, v in altChildren or object:GetChildren() do
			self:ParseObject(v);
		end

		table.insert(self.database, "</Item>");
	end

	function saveinstanceModule:AppendSharedStrings()
		if self.sharedStringHandler.count > 0 then
			table.insert(self.database, "<SharedStrings>");
			for i, v in self.sharedStringHandler.cache do
				table.insert(self.database, string.format("<SharedString md5=\"%s\">%s</SharedString>", v, i));
			end
			table.insert(self.database, "</SharedStrings>");
		end
	end

	function saveinstanceModule:CollectScripts(inst: Instance | {number: Instance}, cache: {number: Instance} | nil): {number: Instance}
		local store = cache or {};
		for i, v in typeof(inst) == "table" and inst or inst:GetChildren() do
			if not self:IsExcludedItem(v) then
				if isViableDecompileScript(v) then
					store[#store + 1] = v;
				end
				self:CollectScripts(v, store);
			end
		end
		return store;
	end

	function saveinstanceModule:Decompile()
		local scripts = self:CollectScripts(game);
		if self.options.includeNil then
			self:CollectScripts(framework.env.getnilinstances(), scripts);
		end
		framework.console.info("Collected Scripts! Decompiling..");
		for i, v in framework.env.decompile(scripts, "debug") do
			self.decompiled[scripts[i]] = v;
		end
	end

	function saveinstanceModule:Save(): nil
		local tick1 = tick();
		if data.api == nil then
			framework.console.info("Grabbing API..");
			data.api = generateClassData(pullApi());
		end

		if self.options.excludeScripts then
			framework.console.info("Grabbed API! Parsing map..");
		else
			framework.console.info("Grabbed API! Collecting scripts..");
			self:Decompile();
			framework.console.info("Decompiled! Parsing map..");
		end

		local tick2 = tick();
		local gameChildren = {};

		for _, v in game:GetChildren() do
			if isService(v.ClassName) then
				self:ParseObject(v);
			else
				table.insert(gameChildren, v);
			end
		end

		if self.options.includeNil then
			local nilInstances = framework.env.getnilinstances(); -- This happens first so it doesn't put itself in the folder
			self:ParseObject(self:CreateBaseDirectory("Nil Instances"), nilInstances);
		end

		if #gameChildren > 0 then
			self:ParseObject(self:CreateBaseDirectory("Game Instances"), gameChildren);
		end

		self:AppendSharedStrings();

		table.insert(self.database, "</roblox>");
		local tick3 = tick();
		
		ARCEUS_FOLDERS.WORKSPACE:WriteFile(self.options.fileName .. ".rbxlx", table.concat(self.database, ""));
		local endTick = tick();
		
		framework.console.print([[Saveinstance finished!
Time taken (api grab): ]] .. tostring(math.floor((tick2 - tick1) * 1000)) .. [[ms
Time taken (computing): ]] .. tostring(math.floor((tick3 - tick2) * 1000)) .. [[ms
Time taken (average per instance): ]] .. tostring(math.floor(((tick3 - tick2) / self.instances) * 1000)) .. [[ms
Time taken (write): ]] .. tostring(math.floor((endTick - tick3) * 1000)) .. [[ms
Time taken (total): ]] .. tostring(math.floor((endTick - tick1) * 1000)) .. [[ms]]);
	end

	--[[ Environment ]]--
	framework.env.getgenv().saveinstance = function(options: {string: any} | nil)
		framework.console.info("'Saveinstance' is now initiated..")
		saveinstanceModule.new(shallowMerge({
			fileName = tostring(game.PlaceId),
			includeNil = true,
			excludeScripts = false,
			excludeDefaults = true
		}, options)):Save();
	end;
end))

-- Create dependencies
do -- gui
	local this, utils = {}, {}
this.utils = utils

if not LPH_OBFUSCATED then -- Luraph integration
	local dummy = function(...) return ... end
	LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or dummy
	LPH_NO_UPVALUES = LPH_NO_UPVALUES or dummy
	LPH_OBFUSCATED = LPH_OBFUSCATED or false
	LPH_JIT_MAX = LPH_JIT_MAX or dummy
	LPH_ENCFUNC = LPH_ENCFUNC or dummy
	LPH_ENCSTR = LPH_ENCSTR or dummy
	LPH_ENCNUM = LPH_ENCNUM or dummy
	LPH_CRASH = LPH_CRASH or dummy
	LPH_JIT = LPH_JIT or dummy
end

function utils:CreateDummy(parent: Instance?)
	return self.ui:AddInstance("Frame", {
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		Parent = parent
	})
end

function utils:GetStartCoords(): Vector2
	local obj = self:CreateDummy()
	local coords = obj.instance.AbsolutePosition
	obj:Remove()

	return coords
end

function utils:GetScreenRatio(parent: Instance?): number
	local obj = self:CreateDummy(parent)
	local viewportSize = obj.instance.AbsoluteSize
	obj:Remove()

	local width, height = viewportSize.X, viewportSize.Y
	return self.player_gui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
		and height / width or width / height
end

function utils:GetSafeScreenRatio(): number
	local ui = self.framework.interface.new()
	ui.instance.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	ui.instance.IgnoreGuiInset = true

	local ratio = self:GetScreenRatio(ui)
	ui:Remove()
	return ratio
end

function utils:GetPadding(): number
	return (utils.player_gui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait and
		self.ui.instance.AbsoluteSize.X or self.ui.instance.AbsoluteSize.Y) *12 /1080
end

function utils:GetAnimationResolution(quality: string)
	quality = quality or utils.framework.settings:GetDefaultSetting("Anim_Quality")
	quality = utils.framework.enums.AnimQuality[quality]

	return ({Vector2.new(32, 32), Vector2.new(64, 64), Vector2.new(128, 128)})[quality]
end

function utils:GetAnimationDensity(quality: string, duration: string)
	quality = quality or utils.framework.settings:GetDefaultSetting("Anim_Quality")
	quality = utils.framework.enums.AnimQuality[quality]
	duration = duration or 1

	return ({24 *duration, 32 *duration, 64 *duration})[quality]
end

function utils:AddAnimation(id: string, options: {any}, frameGen: (idx: number, frames: number) -> buffer, priority: number, ...: any)
	local quality = utils.framework.settings:GetDefaultSetting("Anim_Quality")
	local res = options.Resolution

	options.Resolution = res or self:GetAnimationResolution(quality)
	options.Density = options.Density or self:GetAnimationDensity(quality, options.Duration)

	local raws = utils.framework.storage:GetDirectory("raw")
	local content = options.raw

	if not content and not raws:IsFile(id) and not utils.framework.protected:IsStudio() then
		local res = utils.framework.dependencies.exploit:DownloadFile(`/raw/{id}`)
		if res then raws:WriteFile(id, res)
			content = res
		end
	end

	local anim = utils.framework.animator.fromRaw(id, options, content or raws:ReadFile(id), frameGen)
	anim.RenderOnLoad = options.RenderOnLoad
	anim.Duration = options.Duration
	anim.FixedResolution = res

	for _, tag in ipairs(options.Tags or {}) do
		utils.animsTags[tag] = utils.animsTags[tag] or {}
		utils.framework.utils.tables.insert(utils.animsTags[tag], anim)
	end

	function anim:Save()
		if not anim.Loaded then return end
		raws:WriteFile(id, anim:GetRaw())
	end

	if utils.framework.protected:IsStudio() then
		local fps = anim:GetMaxFPS();
		(fps < 24 and utils.framework.console.warn or utils.framework.console.print
		)(`Animation '{id}' running at max: {fps} FPS`)
	end

	utils.framework.utils.tables.insert(utils.anims, anim)
	return anim
end

function utils:GetAnimation(id: string)
	return utils.framework.renderer:GetBinding(id)
end

function utils:GetAnimationByTag(tag: string)
	return utils.animsTags[tag] or {}
end

function utils:Translate(texts: {string})
	local value = utils.framework.enums.CountryCode[utils.framework.settings:GetSetting("Country_Code")]
		or utils.framework.enums.CountryCode[utils.framework.settings:GetDefaultSetting("Country_Code")]

	return texts[value]
end

function utils:Setup(framework, ui)
	utils.framework = framework
	utils.ui = ui

	--utils.color_properties = framework.protected:GCProtect({"BackgroundColor3", "TextColor3", "BorderColor3", "ImageColor3", "GroupColor3", "TextStrokeColor3", "ScrollBarImageColor3", "PlaceholderColor3", "VideoColor3", "SurfaceColor3", "HoverBackgroundColor3", "SelectedTabTextColor3"})
	utils.anims = framework.protected:GCProtect({})
	utils.animsTags = framework.protected:GCProtect({})
	utils.player_gui = framework.protected:GetService("Players")
		.LocalPlayer:WaitForChild("PlayerGui")

	-- load settings
	local arceus_layout, cache = {}, framework.protected:GCProtect({})
	framework.env.getgenv().arceus_layout = arceus_layout

	framework.settings.OnSettingChanged:Connect(framework.protected:GCProtect(LPH_JIT_MAX(function(setting: string, value: any, default: any)
		if utils.framework.utils.strings.sub(setting, 1, 5) == "User_" then
			return -- Prevents data from being set in arceus_layout

		elseif utils.framework.utils.strings.sub(setting, 1, 7) == "Colors_" then
			local succ, err = pcall(Color3.fromHex, value)
			value = succ and err or Color3.fromHex(default)

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local props = inst[setting]
				if not props then continue end

				if typeof(props) == "function" then
					props(value)
					continue
				end

				for _, prop in ipairs(props) do
					inst.instance[prop] = value
				end
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 10) == "FontSizes_" then
			value = tonumber(value) or default
			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				inst.instance.TextSize = value
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 6) == "Fonts_" then
			local font = default
			if typeof(value) == "string" then
				font = framework.utils.strings.fromFormatted(value)
			end

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				inst.instance.FontFace = font
			end

		elseif utils.framework.utils.strings.sub(setting, 1, 14) == "UI_WindowState" then
			value = framework.utils.maths.clamp(value, framework.enums.WindowState.Base, framework.enums.WindowState.Full)
			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local props = inst[setting]
				if not props then continue end

				for prop, values in pairs(props) do
					cache[inst] = cache[inst] or {}
					cache[inst][prop] = cache[inst][prop] or inst.instance[prop]
					inst.instance[prop] = values[value] or cache[inst][prop]
				end
			end

		elseif setting == "Country_Code" then
			value = utils.framework.enums.CountryCode[value]
				or utils.framework.enums.CountryCode[default]

			for _, inst in ipairs(utils.ui:GetByTag(setting)) do
				local onCC = inst[`On_{setting}`]
				if onCC then onCC(value) end
				
				local translations = inst[setting]
				if translations and (translations[value] or translations[1]) then
					inst.instance.Text = translations[value] or translations[1]
				end

				translations = inst[`{setting}_Placeholder`]
				if not translations or not (translations[value] or translations[1]) then continue end
				inst.instance.PlaceholderText = translations[value] or translations[1]
			end	
		end

		arceus_layout[setting] = value
	end)))

	function utils:EndSetup()
		ui.OnInstanceAdded:Connect(framework.protected:GCProtect(LPH_JIT_MAX(function(inst)
			for _, tag in ipairs(inst:GetTags()) do
				local default = framework.settings:GetDefaultSetting(tag)
				local value = framework.settings:GetSetting(tag)
				if not value and not default then continue end

				if utils.framework.utils.strings.sub(tag, 1, 7) == "Colors_" then
					local props = inst[tag]
					if not props then continue end

					local succ, err = pcall(Color3.fromHex, value)
					value = succ and err or Color3.fromHex(default)
					
					if typeof(props) == "function" then
						props(value)
						continue
					end

					for _, prop in ipairs(props) do
						inst.instance[prop] = value
					end

				elseif utils.framework.utils.strings.sub(tag, 1, 10) == "FontSizes_" then
					value = tonumber(value) or default
					inst.instance.TextSize = value

				elseif utils.framework.utils.strings.sub(tag, 1, 6) == "Fonts_" then
					local font = default
					if typeof(value) == "string" then
						font = framework.utils.strings.fromFormatted(value)
					end
					inst.instance.FontFace = font

				elseif utils.framework.utils.strings.sub(tag, 1, 14) == "UI_WindowState" then
					local props = inst[tag]
					if not props then continue end

					value = framework.utils.maths.clamp(value, framework.enums.WindowState.Base, framework.enums.WindowState.Full)
					for prop, values in pairs(props) do
						cache[inst] = cache[inst] or {}
						cache[inst][prop] = cache[inst][prop] or inst.instance[prop]
						inst.instance[prop] = values[value] or cache[inst][prop]
					end

				elseif tag == "Country_Code" then
					local translations = inst[tag]
					value = utils.framework.enums.CountryCode[value]
						or utils.framework.enums.CountryCode[default]

					if translations and (translations[value] or translations[1]) then
						inst.instance.Text = translations[value] or translations[1]
					end

					translations = inst[`{tag}_Placeholder`]
					if not translations or not (translations[value] or translations[1]) then continue end
					inst.instance.PlaceholderText = translations[value] or translations[1]
				end
			end
		end)))
		
		local playerGui = framework.protected:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		local debounce = false
		
		playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(framework.protected:GCProtect(function()
			ui:Get("MainFrame").instance.Position = UDim2.fromScale(.5, .5)
			ui.nextSize(framework.enums.WindowState.Base)
			--[[ if debounce then return end
			debounce = true
			
			local rotation = playerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait and 0 or -90
			for _, child in ipairs(ui.instance:GetChildren()) do
				if child:IsA("GuiObject") then child.Rotation = rotation end
			end
			
			debounce = false ]]
		end))
	end

	framework.settings:GetSettingChangedSignal(LPH_ENCSTR("User_EMail")):Connect(framework.protected:GCProtect(function(value: string)
		local emailBox = ui:Get(LPH_ENCSTR("EmailBox"))
		if not emailBox then return end
		emailBox.instance.Text = tostring(value)
	end))

	framework.settings:GetSettingChangedSignal("Anim_Quality"):Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(value: string)
		if not utils.animsInitialized then return end
		for _, anim in ipairs(utils.anims) do
			local value = anim.FixedResolution or value

			anim:Generate(utils:GetAnimationResolution(value), utils:GetAnimationDensity(value, anim.Duration))
			anim:Save()

			if anim.RenderOnLoad then anim:Render() end
		end
	end)))

	ui.OnInstanceAdded:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(inst)
		if inst.instance:IsA("GuiButton") then
			inst.instance.MouseButton1Down:Connect(function()
				utils:Vibrate(Enum.HapticEffectType.UIClick)
			end)
		end
	end)))

	local uis = framework.protected:GetService("UserInputService")
	local run = framework.protected:GetService("RunService")
	local fakeFocus = false

	uis.TextBoxFocused:Connect(LPH_NO_VIRTUALIZE(function(tb: TextBox)
		local custom = ui:Get(tb)
		if custom and custom:HasTags("No_Focus") then return end
		
		local overall = framework.settings:GetSetting("TextboxWrapper")
		if tb:IsDescendantOf(overall and ui.instance.Parent or ui.instance) and not tb.MultiLine then -- "blacklist"
			if fakeFocus then 
				fakeFocus = false
				return
			end
			
			local editable = tb.TextEditable
			run.Heartbeat:Wait()
			
			local toast = utils:ShowToast("InputToast", {
				PlaceholderText = {"Text here...","Testo qui...","Văn bản ở đây...","Texto aqui...","Teks di sini...","Текст здесь...","Text hier...","Texto aquí...","Texte ici...","文本在此...","ここにテキスト...","النص هنا...","यहाँ पाठ...","ข้อความที่นี่..."},
				Style = utils.currentPage.id == "Page_ArceusIntelligence" and "ai" or "info",
				Callback = function(txt: string)
					if editable then
						fakeFocus = true
						run.Heartbeat:Wait()
						tb:CaptureFocus()

						tb.Text = framework.utils.strings.sub(txt, 1, 199999)
						run.Heartbeat:Wait()
						tb:ReleaseFocus()
					end
				end
			})

			toast.instance.ZIndex = 999
			local customTb = toast.tb.instance
			local txt = tb.Text

			customTb.TextEditable = editable
			customTb.Text = txt

			customTb.CursorPosition = framework.utils.strings.len(txt) +1
		end
	end))

	local haptic: HapticEffect = ui:AddInstance("HapticEffect", {}).instance
	function utils:Vibrate(type: Enum.HapticEffectType, duration: number?)
		duration = tonumber(duration)

		haptic.Type = type or Enum.HapticEffectType.UINotification
		haptic.Looped = duration and true or false

		pcall(haptic.Play, haptic)
		if duration then
			task.wait(duration)
			pcall(haptic.Stop, haptic)
		end
	end
end

function utils:EditorMode(enabled: boolean, offset: number)
	local TweenService = game:GetService("TweenService")
	local main = utils.ui:Get("MainFrame").instance
	local newState, targetPos

	if enabled then
		utils.prevSate = utils.ui.windowState
		utils.prevPos = main.Position
		newState = utils.framework.enums.WindowState.Base
		-- targetPos = UDim2.fromScale(.5, offset) -- disabled after roblox keyboard updates
	else
		newState = utils.prevSate or utils.ui.windowState
		targetPos = utils.prevPos or main.Position
	end

	utils.ui.nextSize(newState)
	local tweenInfo = TweenInfo.new(.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tw = TweenService:Create(main, tweenInfo, { Position = targetPos })
	tw:Play()

	utils:AnimateCascade(utils.ui:Get("Page_Executor").instance, {
		TweenInfo    = TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		DelayBetween = .01,
		SkipTransparency = true,
		Direction = "BottomToTop" and enabled or "TopToBottom"
	})
end

function utils:GetTweenInfos(delay: number, duration: number, style: Enum.EasingStyle, direction: Enum.EasingDirection, rep: number, inv: boolean)
	return TweenInfo.new(duration or .25, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out, rep or 0, inv or false, delay or 0)
end

function utils:ClosePopup()
	local pop = utils.lastPopup
	if pop then pop:Remove()
		utils.lastPopup = nil
		return true
	end
end

function utils:ShowPopup(class: string, ...: any)
	self:ClosePopup()
	utils.lastPopup = utils.ui:AddComponent(class, ...)
	utils:Vibrate(Enum.HapticEffectType.UINotification)
end

function utils:ShowToast(class: string, props: {any}, ...)
	local main = utils.ui:Get("MainFrame")
	main:Tween(utils:GetTweenInfos(), { GroupTransparency = .9 })

	local toast, once
	props.Close = function(...: any)
		if once then return end
		once = true
		
		toast:Remove()
		main:Tween(utils:GetTweenInfos(), { GroupTransparency = 0 })
		if props.Callback then props.Callback(...) end
	end

	toast = utils.ui:AddComponent(class, props, ...)

	if utils.ui:Get(`{class}_{props.Id}`) then
		utils.AnimateCascade(utils.ui:Get(`{class}_{props.Id}`).instance,{
			DelayBetween = .5,
			TweenInfo = TweenInfo.new(5,  Enum.EasingStyle.Back,   Enum.EasingDirection.Out),
		})
	end

	utils:Vibrate(Enum.HapticEffectType.UINotification)
	return toast
end

utils.AnimateCascade = LPH_NO_VIRTUALIZE(function(self, frameParam, opts)
	if not utils.ui.Loaded then return end

	local TweenService = utils.framework.protected:GetService("TweenService")
	opts = opts or {}

	local rawOffset = opts.StartOffset or opts.AnimateSelf and UDim2.new(0, 0, .015, 0) or UDim2.new(0, 0, .15, 0)
	local tweenInfo = opts.TweenInfo or TweenInfo.new(.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local delayBetween = opts.DelayBetween or .0075
	local globalLimit = opts.Limit
	local excludeNames = {}

	if opts.ExcludeNames then
		for _, name in ipairs(opts.ExcludeNames) do
			excludeNames[name] = true
		end
	end

	local scaleDirection = opts.ScaleDirection or "In"
	local scaleCascade = (opts.ScaleCascade == true)
	local startScaleOffset

	if type(opts.StartScaleOffset) == "number" then
		startScaleOffset = utils.framework.utils.maths.clamp(opts.StartScaleOffset, 0, utils.framework.utils.maths.huge)
	else
		startScaleOffset = (scaleDirection == "In") and .9 or 1.05
	end

	local skipTransparency = (opts.SkipTransparency == true)
	local animateSelf = (opts.AnimateSelf == true)
	local limitMap = opts.LimitMap or {}
	local startOffset

	if animateSelf then
		local vp = workspace.CurrentCamera.ViewportSize
		local offsetX = rawOffset.X.Scale * vp.X + rawOffset.X.Offset
		local offsetY = rawOffset.Y.Scale * vp.Y + rawOffset.Y.Offset
		startOffset = UDim2.new(0, utils.framework.utils.maths.floor(offsetX + .5), 0, utils.framework.utils.maths.floor(offsetY + .5))
	else
		startOffset = rawOffset
	end

	local root = utils.framework.utils.instances.getRobloxInstance(frameParam)
	if not root then return end
	local activeTweens = {}

	utils._cascadeOriginals = utils._cascadeOriginals or {}
	local objs = {}

	local collect; collect = function(parent)
		for _, child in ipairs(parent:GetChildren()) do	
			if child:IsA("GuiObject") and child.Visible then
				local inst = utils.ui:Get(child)
				if not inst or excludeNames[inst.id] then continue end

				utils.framework.utils.tables.insert(objs, child)
				collect(child)
			end
		end
	end

	collect(root)
	if animateSelf then
		utils.framework.utils.tables.insert(objs, 1, root)
	end

	for _, child in ipairs(objs) do
		if not utils._cascadeOriginals[child] then
			local hasText, textVal   = pcall(function() return child.TextTransparency end)
			local hasImage, imageVal = pcall(function() return child.ImageTransparency end)
			utils._cascadeOriginals[child] = {
				BackgroundTransparency = child.BackgroundTransparency,
				ImageTransparency = hasImage and imageVal or nil,
				TextTransparency = hasText  and textVal  or nil,
				Position = child.Position,
				Size = child.Size
			}
		end
	end

	for _, child in ipairs(objs) do
		local orig = utils._cascadeOriginals[child]
		if not skipTransparency then
			local t0 = (type(opts.StartTransparency) == "number")
				and utils.framework.utils.maths.clamp(opts.StartTransparency, 0, 1) or 1

			child.BackgroundTransparency = t0
			if orig.TextTransparency then
				child.TextTransparency = t0
			end

			if orig.ImageTransparency then
				child.ImageTransparency = t0
			end
		end

		if scaleCascade then
			local osz    = orig.Size
			local sStart = UDim2.new(
				osz.X.Scale * startScaleOffset,
				osz.X.Offset * startScaleOffset,
				osz.Y.Scale * startScaleOffset,
				osz.Y.Offset * startScaleOffset
			)

			local tweenerIn = TweenService:Create(child,
				TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Size = sStart })

			tweenerIn:Play()
			table.insert(activeTweens, tweenerIn)
		else
			local startPos = orig.Position + startOffset
			local tweenerIn = TweenService:Create(child,
				TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), { Position = startPos })

			tweenerIn:Play()
			table.insert(activeTweens, tweenerIn)
		end
	end

	task.spawn(function()
		task.wait(.15)
		local parentCounts = {}

		for i, child in ipairs(objs) do
			local orig   = utils._cascadeOriginals[child]
			local parent = child.Parent

			if not parent then continue end
			parentCounts[parent] = (parentCounts[parent] or 0) + 1

			local perLim = limitMap[parent]
			local count  = parentCounts[parent]
			local useIt
			if perLim then
				useIt = (count <= perLim)
			else
				useIt = (not globalLimit) or (i <= globalLimit)
			end

			if useIt then
				task.spawn(function()
					task.wait((i - 1) * delayBetween)

					local goal = {}
					if scaleCascade then
						goal.Size = orig.Size
					else
						goal.Position = orig.Position
					end
					if not skipTransparency then
						goal.BackgroundTransparency = orig.BackgroundTransparency
						if orig.TextTransparency then
							goal.TextTransparency = orig.TextTransparency
						end
						if orig.ImageTransparency then
							goal.ImageTransparency = orig.ImageTransparency
						end
					end

					local tweenerOut = TweenService:Create(child, tweenInfo, goal)
					tweenerOut:Play()
					utils.framework.utils.tables.insert(activeTweens, tweenerOut)
				end)
			else
				if scaleCascade then
					child.Size = orig.Size
				else
					child.Position = orig.Position
				end
				if not skipTransparency then
					child.BackgroundTransparency = orig.BackgroundTransparency
					if orig.TextTransparency then
						child.TextTransparency = orig.TextTransparency
					end
					if orig.ImageTransparency then
						child.ImageTransparency = orig.ImageTransparency
					end
				end
			end
		end

		task.wait((#objs * delayBetween) + tweenInfo.Time)
		for _, t in ipairs(activeTweens) do
			pcall(function() t:Cancel() end)
		end
	end)
end)

utils.AddSlimeEffect = LPH_NO_VIRTUALIZE(function(self, frameWrapper: {any}, targetWrappers: {any}, options: {any})
	local UserInputService: UserInputService = utils.framework.protected:GetService("UserInputService")
	local TweenService: TweenService = utils.framework.protected:GetService("TweenService")
	local RunService: RunService = utils.framework.protected:GetService("RunService")

	local opts = {
		returnTweenInfo = TweenInfo.new(.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		referenceSize = Vector2.new(1920, 1080),
		movementFactor = .15,
		cascadeDelay = .0075,
		antialias = true
	}

	if options then
		for k, v in pairs(options) do opts[k] = v end
	end

	local frame = utils.framework.utils.instances.getRobloxInstance(frameWrapper)
	frame.Active = true

	local originalFrameAbsPos = frame.AbsolutePosition
	local all = targetWrappers.All or {}
	local originalPositions = {}
	local targets = {}

	targetWrappers.All = nil
	for page, wrappers in pairs(targetWrappers) do
		targets[page.Content] = {}

		for _, w in ipairs(wrappers) do
			local gui = utils.framework.utils.instances.getRobloxInstance(w)
			if gui and gui:IsA("GuiObject") then
				utils.framework.utils.tables.insert(targets[page.Content], gui)
				originalPositions[gui] = gui.Position
			end
		end

		for _, w in ipairs(all) do
			local gui = utils.framework.utils.instances.getRobloxInstance(w)
			if gui and gui:IsA("GuiObject") then
				utils.framework.utils.tables.insert(targets[page.Content], gui)
				originalPositions[gui] = gui.Position
			end
		end
	end

	local getScaleFactors = utils.framework.protected:GCProtect(function()
		local vp = workspace.CurrentCamera.ViewportSize
		return opts.referenceSize.X / vp.X, opts.referenceSize.Y / vp.Y
	end)

	local prevFrameAbsPos = frame.AbsolutePosition
	local isDragging = false
	local activeTweens = {}

	local reset = utils.framework.protected:GCProtect(function()
		isDragging = false

		RunService.Heartbeat:Wait()
		for i, gui in ipairs(targets[utils.currentPage] or {}) do
			task.spawn(function()
				task.wait((i - 1) * opts.cascadeDelay)
				local tw = TweenService:Create(gui, opts.returnTweenInfo, {
					Position = originalPositions[gui]
				})

				utils.framework.utils.tables.insert(activeTweens, tw)
				tw:Play()
			end)
		end
	end)

	frame.InputBegan:Connect(utils.framework.protected:GCProtect(function(input)
		if not isDragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or
			input.UserInputType == Enum.UserInputType.Touch) then
			isDragging = true

			if #activeTweens > 0 then
				for _, tw in ipairs(activeTweens) do
					pcall(function() tw:Cancel() end)
				end
				activeTweens = {}
			end

			originalFrameAbsPos = frame.AbsolutePosition
			prevFrameAbsPos = originalFrameAbsPos

			input.Changed:Once(function()
				if input.UserInputState == Enum.UserInputState.End then
					reset()
				end
			end)
		end
	end))

	frame.InputEnded:Connect(reset)
	UserInputService.InputEnded:Connect(utils.framework.protected:GCProtect(function(input)
		if isDragging then reset() end
	end))

	RunService.RenderStepped:Connect(utils.framework.protected:GCProtect(function()
		if not isDragging then return end

		local currAbsPos = frame.AbsolutePosition
		local vp = workspace.CurrentCamera.ViewportSize
		local scaleX, scaleY = opts.referenceSize.X /vp.X, opts.referenceSize.Y /vp.Y

		local invX = -(currAbsPos.X -originalFrameAbsPos.X) *opts.movementFactor *scaleX
		local invY = -(currAbsPos.Y -originalFrameAbsPos.Y) *opts.movementFactor *scaleY

		for _, gui in ipairs(targets[utils.currentPage]) do
			local orig = originalPositions[gui]
			if opts.antialias then
				gui.Position = UDim2.new(
					orig.X.Scale, orig.X.Offset + invX,
					orig.Y.Scale, orig.Y.Offset + invY
				)
			else
				gui.Position = orig + UDim2.new(0, invX, 0, invY)
			end
		end
	end))
end)

------------------------------------------------------------

function this:LoadAnimations()
	for _, anim in ipairs(utils.anims) do
		if not anim.Loaded then
			anim:Generate()
			anim:Save()
			task.wait()
		end

		if anim.RenderOnLoad then
			anim:Render()
		end
	end
	utils.animsInitialized = true
end

function this:Draw(framework) -- Enables roblox studio suggestions
	if false then framework = require("../../Wave/WaveFramework") end

	local ui, tweens, padding do
		ui = framework.interface.new()
		ui.instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ui.instance.ScreenInsets = Enum.ScreenInsets.None

		utils:Setup(framework, ui)
		padding = utils:GetPadding()

		tweens = {
			glow = utils:GetTweenInfos(0, 4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, -1, true),
			delaied_fast_windows = utils:GetTweenInfos(.25, .25, Enum.EasingStyle.Quart),
			fast_windows = utils:GetTweenInfos(0, .15, Enum.EasingStyle.Quart),
			windows = utils:GetTweenInfos(0, .5, Enum.EasingStyle.Quart),
			slow_default = utils:GetTweenInfos(0, .5),
			default = utils:GetTweenInfos()
		}

		framework.protected:ProtectTable(tweens)
		ui.windowState = framework.enums.WindowState.Base

		local playerGui = framework.protected:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		local sizes = framework.protected:GCProtect({ UDim2.fromScale(.5, .5), UDim2.fromScale(.75, .75), UDim2.fromScale(1, 1) })
		ui.currentSize = framework.protected:GCProtect(function()
			return sizes[ui.windowState]
		end)

		local prevPos
		ui.nextSize = framework.protected:GCProtect(LPH_JIT_MAX(function(size: number?)
			utils:AnimateCascade(ui:Get("MaximizeButton").instance, {
				AnimateSelf = true,
				ScaleCascade = true,
				ScaleDirection = "In",
				SkipTransparency  = true
			})

			local prevState = ui.windowState
			ui.windowState = size or ui.windowState + 1
			if ui.windowState > framework.enums.WindowState.Full then
				ui.windowState = framework.enums.WindowState.Base
			end

			local newSize = (ui.windowState == framework.enums.WindowState.Full) and "Full" or "Other"
			local prevSize = (prevState == framework.enums.WindowState.Full) and "Full" or "Other"
			local portrait = playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait
			local isFull = ui.windowState == framework.enums.WindowState.Full and not portrait
			local main = ui:Get("MainFrame")

			if ui.Loaded then framework.settings:SetSetting("UI_WindowState", ui.windowState) end
			ui:Get("MainCorner").instance.CornerRadius = UDim.new(isFull and 0 or .075, 0)
			ui:Get("SafeRatio"):SetParent(isFull and ui:Get("InnerMain") or {})
			ui:Get("Ratio169"):SetParent(isFull and {} or main)

			main:SetDraggable(not isFull)
			main:Tween(tweens.slow_default, {
				Position = isFull and UDim2.fromScale(.5, .5) or main.Position,
				GroupTransparency = .75,
				Size = ui.currentSize()
			})

			utils:AnimateCascade(utils.currentPage, {
				ExcludeNames = { "MagicNicknameContainer", "BarFilter", "GridFilter", "ScriptsBar", "CloudBestScriptsBar", "BestScriptsBar", "AIPlayerBackgroundOverlay", "Slider_Gravity_Bar", "Slider_Jump_Bar", "Slider_Speed_Bar" },
				ScaleDirection = prevSize == "Full" and newSize ~= "Full" and "In" or "Out",
				SkipTransparency = true,
				ScaleCascade = true
			})

			main:Tween(tweens.delaied_fast_windows, {
				GroupTransparency = 0
			})
		end))

		local open = true
		local lastPos, lastSize

		ui.close = framework.protected:GCProtect(LPH_JIT_MAX(function()
			utils:AnimateCascade(ui:Get("CloseButton").instance, {
				AnimateSelf = true,
				ScaleCascade      = true,
				ScaleDirection = "In",
				SkipTransparency  = true
			})

			if not open or utils:ClosePopup() then return end
			local main, ficon = ui:Get("MainFrame"), ui:Get("FloatingIcon")

			lastPos = main.instance.Position
			main:Tween(tweens.windows, {
				Size = UDim2.fromScale(0, 0),
			})

			main:Tween(tweens.slow_default, {
				Position = UDim2.fromScale(.5, 1),
				GroupTransparency = 1,
				Visible = false
			})

			for _, anim in ipairs(utils:GetAnimationByTag("MainFrame")) do anim:Pause() end
			ficon.instance.Visible = true
			ficon:Tween(tweens.windows, {
				ImageTransparency = 0,
				Size = lastSize

			}).Completed:Wait()

			utils:AnimateCascade(ficon, {
				AnimateSelf = true,
				SkipTransparency  = true,
				ScaleCascade      = true,
				ScaleDirection    = "Out"
			})

			open = false
		end))

		ui.open = framework.protected:GCProtect(LPH_JIT_MAX(function()
			if open then return end
			local main, ficon = ui:Get("MainFrame"), ui:Get("FloatingIcon")

			utils:AnimateCascade(ficon.instance, {
				SkipTransparency  = true
			})

			lastSize = ficon.instance.Size
			ficon:Tween(tweens.windows, {
				Size = UDim2.fromScale(0, 0),
				ImageTransparency = 1,
				Visible = false
			})

			main.instance.Visible = true
			main:Tween(tweens.windows, {
				Size = ui.currentSize(),
			})

			utils:AnimateCascade(utils.currentPage, {
				EnterTweenInfo = TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
				TweenInfo = TweenInfo.new(.4,  Enum.EasingStyle.Back,   Enum.EasingDirection.Out),
				ExcludeNames = { "BarFilter", "GridFilter", "CloudBestScriptsBar", "BestScriptsBar", "AIPlayerBackgroundOverlay", "Slider_Gravity_Bar", "Slider_Jump_Bar", "Slider_Speed_Bar" },
				SkipTransparency = true,
				ScaleDirection = "In",
				DelayBetween = .005,
				ScaleCascade = true,
				Limit = nil
			})

			for _, anim in ipairs(utils:GetAnimationByTag("MainFrame")) do anim:Render() end
			main:Tween(tweens.slow_default, {
				GroupTransparency = 0,
				Position = lastPos,

			}).Completed:Wait()
			open = true
		end))

		local skip
		local setLog = framework.protected:GCProtect(function(text: string)
			local log = ui:Get("ShadeText")
			if log and log.instance then
				log.instance.Text = text
			end
		end)

		ui.getLoading = framework.protected:GCProtect(function()
			local back = ui:Get("Background")
			local phase = 1

			local exitBtn = framework.utils.inputs.buttons.holdable(back)	
			local loading, phases = {}, {
				function()
					if back and back.instance then
						back:Tween(TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
							BackgroundTransparency = .4
						})
					end

					local id = "BackgroundOverlay"
					local anim = utils:GetAnimation(id)
					if anim then anim:Render() end

					local obj = ui:Get(id)
					if obj and obj.instance then
						obj:Tween(TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 1.5), {
							ImageTransparency = 0
						})
					end

					local tween = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 5)
					for _, id in ipairs({"BottomShadeLeft", "BottomShadeRight"}) do
						local obj = ui:Get(id)

						if not obj or not obj.instance then continue end
						obj:Tween(tween, { BackgroundTransparency = 0 })
					end

					task.wait(6)
				end,

				function() setLog("Launching…")
					local tween = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0)
					for _, id in ipairs({"ShadeTitle", "ShadeText"}) do
						local obj = ui:Get(id)
						
						if not obj or not obj.instance then continue end
						obj:Tween(tween, { TextTransparency = 0 })
					end

					task.wait(2)
				end,

				function() setLog("Loaded")
					local tween = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0)
					local id = "BackgroundOverlay"

					if back and back.instance then
						back:Tween(tween, { BackgroundTransparency = 1, Visible = false })
					end

					local b = ui:Get(id)
					if b and b.instance then
						b:Tween(tween, { ImageTransparency = 1, Visible = false })
					end

					for _, id in ipairs({"ShadeTitle", "ShadeText"}) do
						local obj = ui:Get(id)
						
						if not obj or not obj.instance then continue end
						obj:Tween(tween, { TextTransparency = 1, Visible = false })
					end

					for _, id in ipairs({"BottomShadeLeft", "BottomShadeRight"}) do
						local obj = ui:Get(id)
						
						if not obj or not obj.instance then continue end
						obj:Tween(tween, { BackgroundTransparency = 1, Visible = false })
					end

					task.delay(1.1, function()
						if exitBtn then exitBtn:Remove() end
						local anim = utils:GetAnimation(id)
						if anim then anim:Unbind() end
					end)
				end,

				function()
					local id = "StartingScreen"
					local page = ui:Get(id)
					local screen = ui:Get(id)
					
					if page and page.instance then
						page.instance.Visible = true
					end
					
					local anim = utils:GetAnimation(id)
					if anim then anim:Render() end
					
					if back and back.instance then
						back:Tween(TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false), {
							BackgroundTransparency = .4
						})
					end

					--screen:Tween(TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false), {
					--	ImageTransparency = 0
					--})
					if screen and screen.instance then
						screen:Tween(TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false,2), {
							ImageTransparency = .15
						})
					end

					--task.wait(1)
					if page and page.instance then
						utils:AnimateCascade(page, {
							DelayBetween = .5,
							TweenInfo = TweenInfo.new(3,  Enum.EasingStyle.Back,   Enum.EasingDirection.Out),
						})
					end
				end,

				function(callback: () -> any)
					--[[local action
					task.delay(10, function()
						if action then return end
						action = true
						callback()
					end)]]

					for i=10, 1, -1 do
						--print("Check in:", i)
						task.wait(1)
					end

					local btn = ui:Get("StartButton")
					btn.instance.MouseButton1Click:Wait()
					--[[if action then return end
					action = true]]
					callback()
				end,

				function()
					local id = "StartingScreen"
					local page = ui:Get(id)
					--task.wait(8)
					--page.instance.Visible = true
					local anim = utils:GetAnimation(id)
					if anim then anim:Unbind() end
					
					if page and page.instance then
						page.instance.Visible = false
						page:Remove()
					end
					
					if back and back.instance then
						back:Remove()
					end

					task.delay(1.1, ui.close)
				end
			}

			local function doPhase(n: number, callback: () -> any)
				local action = phases[n]
				if not action then return end

				phase = n +1
				action(callback)
			end

			function loading:Skip(n: number, callback: () -> any)
				doPhase(n or #phases, callback)
				return self
			end

			function loading:Advance(n: number, callback: () -> any)
				if skip then return self end

				doPhase(phase, callback)
				if n and n > 1 then self:Advance(n -1, callback) end
				return self
			end

			exitBtn.OnLongPress:Connect(function(clickTime: number)
				setLog("Skipping…")
				exitBtn:Remove()
				exitBtn = nil
				skip = true

				loading:Skip(3)
			end)

			return loading
		end)
	end

	-- Components

	ui:CreateComponent("ButtonToast").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local glowStyle, colorStyle, gradientStyle = {
			info = "rbxassetid://128601429542160",
			error = "rbxassetid://105234289135931",
			success = "rbxassetid://89752107107901",
			confirm = "rbxassetid://128601429542160"
		}, {
			info = Color3.fromHex("#006AFF"),
			error = Color3.fromHex("#F00"),
			success = Color3.fromHex("#0F0"),
			confirm = Color3.fromHex("#006AFF")
		}, {
			info = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#449EF8")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#73A5F4")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#3894FF")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#2A87FF"))
			}),
			error = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#FA3232")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#F47373")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#FF3838")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#FF2929"))
			}),
			success = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#17FD4D")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#73F591")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#38FF67")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#1DFF52"))
			}),
			confirm = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#449EF8")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#73A5F4")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#3894FF")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#2A87FF"))
			}),
		}

		local glowButton = ui:AddInstance("ImageLabel", {
			Image = glowStyle[props.Style] or glowStyle.info, -- glowing toast button
			BackgroundTransparency = 1,
			ZIndex = 10
		})

		local additionalTitle = ui:AddInstance("TextLabel", {
			Visible = props.AdditionalTitle and true or false,
			TextXAlignment = Enum.TextXAlignment.Center,
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromScale(.5, .1),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.7, .35),
			BackgroundTransparency = 1,
			TextSize = padding * 10,
			TextWrapped = true,
			Text = "",

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"},
			Country_Code = props.AdditionalTitle

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)

		}), ui:AddInstance("UIGradient", {

			Color = gradientStyle[props.Style] or gradientStyle.info,
			Rotation = 210
		}))

		local additionalText = ui:AddInstance("TextLabel", {
			Visible = props.AdditionalText and true or false,
			TextXAlignment = Enum.TextXAlignment.Center,
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromScale(.5, .325),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.7, .2),
			BackgroundTransparency = 1,
			TextSize = padding * 6,
			TextWrapped = true,
			Text = "",

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"},
			Country_Code = props.AdditionalText

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)
		}))

		local button = ui:AddInstance("TextButton", {
			BackgroundColor3 = Color3.fromHex("#FFF"),
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(.5, .6),
			AnchorPoint = Vector2.new(.5, 0),
			BackgroundTransparency = .8,
			ZIndex = 9,
			Text = "",

			MouseButton1Click = function()
				props.Close(true)
			end

		}, ui:AddInstance("UIPadding", {
			PaddingRight = UDim.new(0, padding *3.5),
			PaddingBottom = UDim.new(0, padding *2),
			PaddingLeft = UDim.new(0, padding *3.5),
			PaddingTop = UDim.new(0, padding *2)

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0, padding *5)

		}), ui:AddInstance("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder

		}), ui:AddInstance("Frame", {
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1

		}), ui:AddInstance("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(.5,.5),
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1,
			TextSize = padding * 4,
			TextWrapped = true,
			Text = "",

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"},

			Country_Code = props.Style == "confirm" and
				{"Confirm","Conferma","Xác nhận","Confirmar","Konfirmasi","Подтвердить","Bestätigen","Confirmar","Confirmer","确认","確認","تأكيد","पुष्टि करें","ยืนยัน"}or {"Ok"}

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)
		})))

		local main = ui:AddInstance("TextButton", {
			Id = `ButtonToast_{props.Id}` or "ButtonToast_",

			BackgroundColor3 = Color3.fromHex("#000"),
			MouseButton1Click = props.Close,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = .25,
			AutoButtonColor = false,
			ZIndex = 1499,
			Text = ""

		}, ui:AddInstance("ImageLabel", {
			Id = "ToastGlow",

			ImageColor3 = colorStyle[props.Style] or colorStyle.info,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1

		}, additionalTitle, additionalText, glowButton, button))

		local function update()
			local size, pos = button.instance.AbsoluteSize, button.instance.AbsolutePosition

			glowButton.instance.Size = UDim2.fromOffset(size.X *2, size.Y *4)
			local siz = glowButton.instance.AbsoluteSize
			glowButton.instance.Position = UDim2.fromOffset(pos.X -(siz.X -size.X)/2, pos.Y -(siz.Y -size.Y) /3) --+size.Y /1.75) -- Image is not centered	
		end

		update()
		glowButton:Tween(TweenInfo.new(
			1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				ImageTransparency = .5
			})

		button.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
		button.instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(update)
		return main
	end)))

	ui:CreateComponent("InputToast").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local glowStyle, colorStyle, gradientStyle = {
			info = "rbxassetid://128601429542160",
			error = "rbxassetid://105234289135931",
			success = "rbxassetid://89752107107901",
			ai = "rbxassetid://93050869167661"
		}, {
			info = Color3.fromHex("#006AFF"),
			error = Color3.fromHex("#F00"),
			success = Color3.fromHex("#0F0"),
			ai = Color3.fromHex("#FA54A8")
		}, {
			info = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#449EF8")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#73A5F4")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#3894FF")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#2A87FF"))
			}),
			error = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#FA3232")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#F47373")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#FF3838")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#FF2929"))
			}),
			success = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#17FD4D")),
				ColorSequenceKeypoint.new(.33, Color3.fromHex("#73F591")),
				ColorSequenceKeypoint.new(.66, Color3.fromHex("#38FF67")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#1DFF52"))
			}),
			ai = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#FF0000")),
				ColorSequenceKeypoint.new(.4, Color3.fromHex("#FF3869")),
				ColorSequenceKeypoint.new(.7, Color3.fromHex("#F473EC")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#15A6FE"))
			})

		}

		local glowButton = ui:AddInstance("ImageLabel", {
			Image = glowStyle[props.Style] or glowStyle.info, -- glowing toast button
			BackgroundTransparency = 1,
			ZIndex = 10
		})

		local additionalText = ui:AddInstance("TextLabel", {
			Visible = props.AdditionalText and true or false,
			TextXAlignment = Enum.TextXAlignment.Center,
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromScale(.5, .1),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.8, .2),
			BackgroundTransparency = 1,
			TextSize = padding * 6,
			TextWrapped = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"},
			Country_Code = props.AdditionalText

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)
		}), ui:AddInstance("UIGradient", {

			Color = gradientStyle[props.Style] or gradientStyle.info,

			Rotation = 210
		}))

		local box = ui:AddInstance("TextBox", {
			PlaceholderText = "Insert text here...",
			TextTruncate = Enum.TextTruncate.AtEnd,
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			TextSize = padding * 4,
			Text = "",

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title", "No_Focus"},
			Country_Code_Placeholder = props.PlaceholderText,
			Colors_Text_Primary = {"TextColor3"}
		})

		local textbox = ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#FFF"),
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromScale(.5, .25),
			Size = UDim2.fromScale(.85, .115),
			AnchorPoint = Vector2.new(.5, 0),
			BackgroundTransparency = .8,
			ZIndex = 9

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding *2),
			PaddingRight = UDim.new(0, padding *3.5),
			PaddingLeft = UDim.new(0, padding *2),
			PaddingTop = UDim.new(0, padding *2)

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0, padding *5)

		}), box)

		local main = ui:AddInstance("Frame", {
			Id = `Toast_{props.Id}`,

			BackgroundColor3 = Color3.fromHex("#000"),
			Size = UDim2.fromScale(1, 1),
			ZIndex = 1499

		}, ui:AddInstance("UIGradient", {
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, .25),
				NumberSequenceKeypoint.new(1, 1)
			})

		}), ui:AddInstance("ImageLabel", {
			Id = "ToastGlow",

			ImageColor3 = colorStyle[props.Style] or colorStyle.info,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1

		}, additionalText, glowButton, textbox))

		local function update()
			local size, pos = textbox.instance.AbsoluteSize, textbox.instance.AbsolutePosition
			local aiMultiplier = props.Style == "ai" and 1.4 or 1
			glowButton.instance.Size = UDim2.fromOffset(size.X *1.4 * aiMultiplier, size.Y *4)

			local siz = glowButton.instance.AbsoluteSize
			glowButton.instance.Position = UDim2.fromOffset(pos.X -(siz.X -size.X)/2, pos.Y -(siz.Y -size.Y)/3) -- Image is not centered
			-- glowButton.instance.Position = UDim2.fromOffset(pos.X -(siz.X -size.X)/2, pos.Y -(siz.Y -size.Y)/2 +size.Y /1.75)
		end

		update()
		glowButton:Tween(TweenInfo.new(
			1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				ImageTransparency = .5
			})

		textbox.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
		textbox.instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(update)

		box.instance:CaptureFocus()
		box.instance.FocusLost:Once(function() props.Close(box.instance.Text) end)

		main.tb = box
		return main
	end)))

	ui:CreateComponent("Toast").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local glowStyle, iconStyle, colorStyle = {
			info = "rbxassetid://128601429542160",
			error = "rbxassetid://105234289135931",
			success = "rbxassetid://89752107107901"
		}, {
			info = "rbxassetid://102895040094534",
			error = "rbxassetid://137768773239157",
			success = "rbxassetid://99252037962470"
		}, {
			success = Color3.fromHex("#0F0"),
			info = Color3.fromHex("#006AFF"),
			error = Color3.fromHex("#F00")
		}

		local glowButton = ui:AddInstance("ImageLabel", {
			Image = glowStyle[props.Style] or glowStyle.info, -- glowing toast button
			BackgroundTransparency = 1,
			ZIndex = 10
		})

		local button = ui:AddInstance("TextButton", {
			BackgroundColor3 = Color3.fromHex("#FFF"),
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(.5, .1),
			AnchorPoint = Vector2.new(.5, 0),
			BackgroundTransparency = .8,
			ZIndex = 9,
			Text = "",

			MouseButton1Click = props.Close

		}, ui:AddInstance("UIPadding", {
			PaddingRight = UDim.new(0, padding *3.5),
			PaddingBottom = UDim.new(0, padding *2),
			PaddingLeft = UDim.new(0, padding *2),
			PaddingTop = UDim.new(0, padding *2)

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0, padding *5)

		}), ui:AddInstance("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder

		}), ui:AddInstance("Frame", {
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1

		}, ui:AddInstance("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			VerticalFlex = Enum.UIFlexAlignment.Fill,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, padding*1.5)

		}), ui:AddInstance("ImageLabel", {
			Image = iconStyle[props.Style] or iconStyle.info, -- icon
			AutomaticSize = Enum.AutomaticSize.XY,
			Position = UDim2.fromScale(0, .5),
			AnchorPoint = Vector2.new(0, .5),
			BackgroundTransparency = 1

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		})), ui:AddInstance("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.XY,
			AnchorPoint = Vector2.new(1, .5),
			BackgroundTransparency = 1,
			TextSize = padding * 4,
			TextWrapped = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"},
			Country_Code = props.Text

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)
		}))))

		local main = ui:AddInstance("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromHex("#000"),
			ZIndex = 499

		}, ui:AddInstance("UIGradient", {
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, .25),
				NumberSequenceKeypoint.new(1, 1)
			})

		}), ui:AddInstance("ImageLabel", {
			Id = "ToastGlow",

			ImageColor3 = colorStyle[props.Style] or colorStyle.info,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		}, glowButton, button))

		local function update()
			local size, pos = button.instance.AbsoluteSize, button.instance.AbsolutePosition
			glowButton.instance.Size = UDim2.fromOffset(size.X *1.6, size.Y *4)

			local siz = glowButton.instance.AbsoluteSize
			glowButton.instance.Position = UDim2.fromOffset(pos.X -(siz.X -size.X) /2, pos.Y -(siz.Y -size.Y) /3) --+size.Y /1.75) -- Image is not centered	
		end

		update()
		glowButton:Tween(TweenInfo.new(
			1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
				ImageTransparency = .5
			})

		button.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
		button.instance:GetPropertyChangedSignal("AbsolutePosition"):Connect(update)
		return main
	end)))

	ui:CreateComponent("Shade").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		return ui:AddInstance("Frame", {
			Id = props.Id or nil,

			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = props.Size or UDim2.fromScale(0, 0),
			Position = props.Position or UDim2.fromScale(0, 0)

		}, ui:AddInstance("UIGradient", {
			Id = props.Id and framework.utils.strings.format("%s_Gradient", props.Id) or nil,

			Rotation = props.Rotation or 0,
			Color = props.Color or ColorSequence.new(Color3.fromRGB(255, 0, 0)),
			Transparency = props.Transparency or NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1, 0),
				NumberSequenceKeypoint.new(.75, 1, 0),
				NumberSequenceKeypoint.new(1, .6, 0)
			})
		}))
	end)))

	ui:CreateComponent("SideBtn").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		return ui:AddInstance("ImageButton", {
			Id = props.Id,

			MouseButton1Click = props.OnClick,
			Position = props.Position or UDim2.fromScale(.5, .05),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.8, .08),
			BackgroundTransparency = 1,
			AutoButtonColor = false

		}, ui:AddInstance("ImageLabel", {
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.85, .85),
			ScaleType = Enum.ScaleType.Fit,
			BackgroundTransparency = 1,
			Image = props.Image

		}), ui:AddInstance("UIAspectRatioConstraint"))
	end)))

	ui:CreateComponent("ScriptTab").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: boolean)
		local tbx = ui:AddInstance("TextBox", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(.05, .5),
			AnchorPoint = Vector2.new(0, .5),
			Size = UDim2.fromScale(.9, .5),
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			Text = props.Title,
			TextScaled = true,
			Visible = false,

			Tags = {"Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"}
		})

		local lbl = ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(.05, .5),
			AnchorPoint = Vector2.new(0, .5),
			Size = UDim2.fromScale(.75, .5),
			BackgroundTransparency = 1,
			Text = props.Title,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"}
		})

		local btn
		btn = ui:AddInstance("ImageButton", {
			Image = "rbxassetid://103207032755758",
			Position = UDim2.fromScale(.95, .5),
			AnchorPoint = Vector2.new(1, .5),
			Size = UDim2.fromScale(.5, .5),
			BackgroundTransparency = 1,
			AutoButtonColor = false,

			MouseButton1Click = function()
				local tabs = framework.dependencies.editortabs
				local tab = tabs:GetSelection()
				if not tab then return end

				btn.instance.Visible = false
				lbl.instance.Visible = false
				tbx.instance.Visible = true
				tbx.instance.TextEditable = true
				tbx.instance:CaptureFocus()

				tbx.instance.FocusLost:Wait()
				tbx.instance.FocusLost:Wait() -- due to text handler
				tbx.instance.TextEditable = false
				tab:SetName(tbx.instance.Text)

				btn.instance.Visible = true
				lbl.instance.Visible = true
				tbx.instance.Visible = false
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1
		}))

		local selected = false
		local comp;
		comp = ui:AddInstance("ImageButton", {
			Position = UDim2.fromScale(.5, .0),
			AnchorPoint = Vector2.new(.5, 0),
			LayoutOrder = props.LayoutOrder,
			Size = UDim2.fromScale(1, .2),
			BackgroundTransparency = .5,
			AutoButtonColor = false,
			Parent = props.Parent,

			Colors_Primary = framework.protected:GCProtect(function(color)
				if not selected then return end
				comp.instance.BackgroundColor3 = color
			end),
			
			Tags = {"Colors_Primary"}

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.3, 0)

		}), tbx, lbl, btn)

		function comp:Select()
			selected = true
			local succ, err = pcall(Color3.fromHex, framework.settings:GetSetting("Colors_Primary"))
			comp:Tween(tweens.default, { BackgroundColor3 = succ and err or Color3.fromHex(framework.settings:GetDefaultSetting("Colors_Primary")) })
		end

		function comp:Unselect()
			selected = false
			local succ, err = pcall(Color3.fromHex, framework.settings:GetSetting("Colors_Secondary"))
			comp:Tween(tweens.default, { BackgroundColor3 = succ and err or Color3.fromHex(framework.settings:GetDefaultSetting("Colors_Secondary")) })
		end

		comp:Unselect()
		return comp
	end)))

	do
		local prevbtn
		ui:CreateComponent("CategoryButton").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: any)
			local bgColor = props.BackgroundColor3 or Color3.fromHex("#F00")
			local txt = ui:AddInstance("TextLabel", {
				TextYAlignment = Enum.TextYAlignment.Center,
				TextXAlignment = Enum.TextXAlignment.Right,
				Position = UDim2.fromScale(.875, .5),
				AnchorPoint = Vector2.new(1, .5),
				Size = UDim2.fromScale(.45, .55),
				BackgroundTransparency = 1,
				TextColor3 = bgColor,
				TextScaled = true,
				Visible = false,
				Text = "",

				Tags = {"Fonts_Heading", "Country_Code"},
				Country_Code = props.Title
			})

			local ratio = ui:AddInstance("UIAspectRatioConstraint", {
				AspectRatio = 1
			})

			local comp
			comp = ui:AddInstance("TextButton", {
				Id = `CategoryBtn_{props.Title[1]}`,

				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				BackgroundColor3 = bgColor,
				Text = "",

				MouseButton1Click = function() comp:Select() end,

			}, ui:AddInstance("UICorner", {
				CornerRadius = UDim.new(.4, 0)

			}), txt, ui:AddInstance("ImageLabel", {
				Image = props.Image or "rbxassetid://135906354399656",
				Position = UDim2.fromScale(.125, .5),
				AnchorPoint = Vector2.new(0, .5),
				Size = UDim2.fromScale(.55, .55),
				BackgroundTransparency = 1,
				ImageColor3 = bgColor

			}, ui:AddInstance("UIAspectRatioConstraint", {
				AspectRatio = 1

			})), ratio)

			function comp:Select()
				if prevbtn then prevbtn:Unselect() end
				prevbtn = comp

				local callback = props.Callback
				if callback then callback() end

				comp:Tween(tweens.default, { BackgroundTransparency = .7 })
				ratio:Tween(tweens.default, { AspectRatio = 2.5 })
				--txt.instance.Text = utils:Translate(props.Title)
				ui:Get("CategoryTitle").instance.Text = utils:Translate(props.LongTitle or props.Title)
				txt.instance.Visible = true
			end

			function comp:Unselect()
				comp:Tween(tweens.default, { BackgroundTransparency = 1 })
				ratio:Tween(tweens.default, { AspectRatio = 1 })
				txt.instance.Visible = false
				--txt.instance.Text = ""
			end

			if props.Selected then comp:Select() end
			return comp
		end)))
	end

	ui:CreateComponent("MovingText").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local glowGradient = ui:AddInstance("UIGradient", {
			Offset = Vector2.new(-1, 0),
			Rotation = 0,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(.25, 1),
				NumberSequenceKeypoint.new(.5, 0),
				NumberSequenceKeypoint.new(.75, .5),
				NumberSequenceKeypoint.new(1, 0),
			})
		})

		local label = ui:AddInstance("TextLabel", {
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.new(0, 0, 0, 0),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = props.Text or "",
			TextTransparency = 0,
			TextSize = 25,
			
			Tags = {"Fonts_Black"}
		}, glowGradient)

		props.Text = nil

		-- create container and enable clipping
		local comp = ui:AddInstance("Frame", props, label)
		comp.instance.ClipsDescendants = true

		task.spawn(function()
			local TextService = framework.protected:GetService("TextService")
			local scrollRunning = false
			local scrollTweenThread

			local function startScrollLoop(fullWidth, containerWidth)
				-- cancel previous loop
				if scrollTweenThread then
					scrollRunning = false
					task.cancel(scrollTweenThread)
					scrollTweenThread = nil
				end

				-- if text fits, reset to original mid-Y
				if fullWidth <= containerWidth * 1.05 then
					label.instance.Position = UDim2.new(0, 0, 0, 0)
					return
				end

				local distance = fullWidth - containerWidth
				local tinfo = utils:GetTweenInfos(0, distance/35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				local pauseTime = 2.5

				scrollRunning = true
				scrollTweenThread = task.spawn(pcall, function()
					while scrollRunning and label.instance do
						-- slide left, keep mid-Y
						label:Tween(tinfo, {
							Position = UDim2.new(0, -distance, 0, 0)
						}).Completed:Wait()
						task.wait(pauseTime)

						-- slide back, keep mid-Y
						label:Tween(tinfo, {
							Position = UDim2.new(0, 0, 0, 0)
						}).Completed:Wait()
						task.wait(pauseTime)
					end
				end)
			end

			local updateSize = framework.protected:GCProtect(function()
				if not label.instance or not comp.instance then return end
				-- match text size to frame height
				label.instance.TextSize = comp.instance.AbsoluteSize.Y
				local textSize = TextService:GetTextSize(
					label.instance.Text,
					label.instance.TextSize,
					Enum.Font.MontserratBlack,
					Vector2.new(math.huge, comp.instance.AbsoluteSize.Y)
				)
				local fullWidth = textSize.X

				-- reset label
				label.instance.Position = UDim2.fromScale(0, 0)
				label.instance.Size     = UDim2.new(1, 0, 1, 0)

				startScrollLoop(fullWidth, comp.instance.AbsoluteSize.X)
			end)

			-- animate initial glow offset
			glowGradient:Tween(tweens.glow, { Offset = Vector2.new(1, 0) })

			-- re-run on resize
			comp.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)

			-- initial sizing + scroll start
			task.wait(.5)
			updateSize()
		end)

		return comp
	end)))


	ui:CreateComponent("ScriptObj").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local comp, holdable
		local fav = ui:AddInstance("ImageButton", {
			Id = `ScriptObj_FavsButton_{props.Title}`,

			Visible = not (props.NoFav or props.IsFolder),
			ImageColor3 = Color3.fromHex("#FDC41B"),
			Image = "rbxassetid://80350699155696",
			Position = UDim2.fromScale(.95, .1),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.fromScale(.1, .2),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				local btn = ui:Get(`ScriptObj_FavsButton_{props.Title}`)
				if btn and btn.instance then
					utils:AnimateCascade(btn.instance, {
						AnimateSelf = true,
						SkipTransparency  = true
					})
				end

				if props.OnFavourite then comp:SetFavourite(props.OnFavourite()) end
			end,

			OnRemoved = function()
				if holdable then
					holdable:Remove()
					holdable = nil
				end
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1	
		}))

		local del = ui:AddInstance("ImageButton", {
			Id = `ScriptObj_DelButton_{props.Title}`,

			Image = "rbxassetid://80286816747552",
			Position = UDim2.fromScale(.05, .1),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.fromScale(.1, .2),
			BackgroundTransparency = 1,
			Visible = not not props.OnDelete,

			MouseButton1Click = function()
				utils:AnimateCascade(ui:Get(`ScriptObj_DelButton_{props.Title}`).instance, {
					AnimateSelf = true,
					SkipTransparency  = true
				})

				if props.OnDelete then props.OnDelete() end
			end,

			OnRemoved = function()
				if holdable then
					holdable:Remove()
					holdable = nil
				end
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1	
		}))

		local function getRandomAIColor()
			local aiColors = {
				{255, 0, 0},
				{255, 56, 105},
				{244, 115, 236},
				{21, 166, 254},
				{255, 56, 105}
			}

			local color = aiColors[math.random(1, #aiColors)]
			return Color3.fromRGB(color[1], color[2], color[3])
		end

		local image = props.Image
		if props.IsFolder then
			image = framework.protected:ProtectAsset("rbxassetid://99211126565176")
		else
			image = props.IsLocal and framework.protected:ProtectAsset("rbxassetid://87562736891746")
				or framework.protected:ProtectAsset("rbxassetid://71177623238811")
		end

		comp = ui:AddInstance("ImageButton", {
			Id = `ScriptObj_MainButton_{props.Title}`,

			Size = UDim2.fromScale(1, 1),
			AutoButtonColor = false,
			Parent = props.Parent,
			ImageColor3 = props.Image and Color3.fromHex("#FFF") or getRandomAIColor(),
			Image = image

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.2, 0)

		}), fav, del, ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(.5, .8),
			AnchorPoint = Vector2.new(.5, 1),
			Size = UDim2.fromScale(.9, .2),
			Text = props.Title or "Script",
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_Body"},
			Colors_Text_Primary = {"TextColor3"}

		}, ui:AddInstance("TextLabel", {
			TextColor3 = Color3.fromRGB(175, 175, 175),
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(0, 1),
			Text = props.Description or "",
			Size = UDim2.fromScale(1, .6),
			BackgroundTransparency = 1,
			TextScaled = true

		})), ui:AddInstance("UIGradient", {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#404040")),
				ColorSequenceKeypoint.new(0.5, Color3.fromHex("#FFF")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#404040"))
			}),

			Rotation = 90
		}))

		if props.Slug then comp:AddTags(props.Slug) end
		comp.favourite = fav

		if props.OnClick then
			holdable = framework.utils.inputs.buttons.holdable(comp)
			holdable.OnShortPress:Connect(function(elapsed)
				if elapsed < .2 and props.OnClick then 
					if ui:Get(`ScriptObj_MainButton_{props.Title}`) then
						utils:AnimateCascade(ui:Get(`ScriptObj_MainButton_{props.Title}`).instance, {
							AnimateSelf = true,
							ScaleCascade = true,
							ScaleDirection = "Out",
							SkipTransparency  = true
						})
					end
					props.OnClick() 
				end
			end)
		end

		function comp:SetFavourite(status: boolean, dontUpdate: boolean)
			for _, v in ipairs(ui:GetByTag(props.Slug)) do
				v.favourite.instance.Image = status and framework.protected:ProtectAsset("rbxassetid://137934368112423") or "rbxassetid://80350699155696"
			end

			local scriptsgrid = ui:Get("ScriptsGrid")
			if not dontUpdate and not scriptsgrid.lastQuery then
				framework.dependencies.cloudscripts:FetchFavourites("grid")
			end
		end

		comp:SetFavourite(props.IsFavourite, true)
		return comp
	end)))

	ui:CreateComponent("ExtensionObj").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local del = props.OnDelete and ui:AddInstance("ImageButton", {
			Image = "rbxassetid://80286816747552",
			Position = UDim2.fromScale(.95, .05),
			MouseButton1Click = props.OnDelete,
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.fromScale(.25, .25),
			BackgroundTransparency = 1

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1	
		}))

		return ui:AddInstance("ImageButton", {
			MouseButton1Click = props.OnClick,
			Size = UDim2.fromScale(1, 1),
			AutoButtonColor = false,
			Parent = props.Parent,
			Image = props.Image

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectType = Enum.AspectType.ScaleWithParentSize,
			DominantAxis = Enum.DominantAxis.Width,
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.2, 0)

		}), ui:AddInstance("TextLabel", {
			Position = UDim2.fromScale(.5, 1.05),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.9, .2),
			Text = props.Title or "Extension",
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_Body"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("UIGradient", {
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#404040"))
			}),

			Rotation = -45
		}), del)
	end)))

	ui:CreateComponent("ContentBar").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local layout = ui:AddInstance("UIPageLayout", {
			Id = "ScriptsLayout",

			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			EasingDirection = Enum.EasingDirection.Out,
			SortOrder = Enum.SortOrder.LayoutOrder,
			EasingStyle = Enum.EasingStyle.Linear,
			ScrollWheelInputEnabled = false,
			GamepadInputEnabled = false,
			TouchInputEnabled = false,
			--Circular = true,
			TweenTime = .25
		})

		local comp = ui:AddInstance("Frame", {
			Id = props.Id,

			AnchorPoint = props.AnchorPoint,
			BackgroundTransparency = 1,
			Position = props.Position,
			Size = props.Size

		}, ui:AddInstance("UIAspectRatioConstraint", {
			DominantAxis = Enum.DominantAxis.Height,
			AspectRatio = 1.78

		}), layout)

		local tweenService = framework.protected:GetService("TweenService")
		local scripts, idx, current = {}, -1, nil

		local setSize = framework.protected:GCProtect(function(time: number, scrOffset: number, ySize: number, xPos: number, ZIndex: number)
			local scr = scripts[idx +scrOffset]
			if not scr then return end

			local inner = scr:GetObject()
			local tween = utils:GetTweenInfos(0, time)
			local color, transp = 255/3*ZIndex, ZIndex == 3 and 0 or 1 -1/3*ZIndex

			for _, lbl in ipairs(inner.instance:GetDescendants()) do
				if not lbl:IsA("TextLabel") then continue end
				tweenService:Create(lbl, tween, { TextTransparency = transp }):Play()
			end

			inner.instance.ImageColor3 = Color3.fromRGB(color, color, color)
			scr.instance.instance.ZIndex = ZIndex

			scr.instance:Tween(tween, { Size = UDim2.fromScale(1, ySize) })
			inner:Tween(tween, { Position = UDim2.fromScale(xPos, 0) })
		end)

		local slideIndex = framework.protected:GCProtect(function(increment: number)
			local lenght =  #scripts -1
			local idx = idx
			local bound

			if idx +increment >= lenght then
				bound = 1
				idx = lenght

			elseif idx +increment <= 0 then
				bound = -1
				idx = 0
			else
				idx += increment
			end

			if bound and props.OnBound then props.OnBound(bound) end -- on bound reached
			return idx
		end)

		local updateList = framework.protected:GCProtect(function(timeMult)
			if idx +3 < #scripts then
				if idx == -1 then idx = slideIndex(2) end
			elseif #scripts > 4 and props.OnLoad then task.spawn(props.OnLoad) end -- load more content

			idx = framework.utils.maths.max(idx, 0)
			timeMult = timeMult or 1
			timeMult = .25 *timeMult

			layout.instance.TweenTime = timeMult
			layout.instance:JumpToIndex(idx)

			local scr = scripts[idx +1]
			current = scr

			if current and props.OnSelected then task.spawn(props.OnSelected, scr) end -- on content selected
			setSize(timeMult, 1, 1, 0, 3)
			setSize(timeMult, 0, .8, .35, 2)
			setSize(timeMult, -1, .6, 1, 1)
			setSize(timeMult, -2, .4, 0, 1)
			setSize(timeMult, 2, .8, -.35, 2)
			setSize(timeMult, 3, .6, -1, 1)
			setSize(timeMult, 4, .4, 0, 1)
		end)

		function comp:AddScript(props: {any})
			local scr = {}
			local inner

			inner = ui:AddComponent("ScriptObj", {
				OnFavourite = props.OnFavourite,
				Description = props.Description,
				IsFavourite = props.IsFavourite,
				OnDelete = props.OnDelete,
				IsFolder = props.IsFolder,
				IsLocal = props.IsLocal,
				Title = props.Title,
				Image = props.Image,
				NoFav = props.NoFav,
				Slug = props.Slug,

				OnClick = function()
					if scr == current then
						if props.Callback then props.Callback() end
						return
					end

					local diff = framework.utils.tables.find(scripts, scr)
					-(framework.utils.tables.find(scripts, current) or 0)

					idx = slideIndex(diff)
					updateList(framework.utils.maths.abs(diff))
				end
			})

			local inst = ui:AddInstance("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				LayoutOrder = #scripts,
				Parent = comp
			}, inner)

			scr.instance = inst
			function scr:Remove()
				local found = framework.utils.tables.find(scripts, scr)
				if found then framework.utils.tables.remove(scripts, found) end
				inst:Remove()
			end

			function scr:GetObject()
				return inner
			end

			framework.utils.tables.insert(scripts, scr)
			return scr
		end

		function comp:UpdateList()
			updateList()
			return self
		end

		function comp:Move(increment: number)
			idx = slideIndex(increment)
			updateList()
			return self
		end

		function comp:GetScripts()
			return framework.utils.tables.listCopy(scripts)
		end

		function comp:ClearScripts()
			local scrs = self:GetScripts()
			current = nil
			scripts = {}
			idx = -1

			for _, scr in ipairs(scrs) do scr:Remove() end
			return self
		end

		return comp
	end)))

	ui:CreateComponent("FilterSelector").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local comp = ui:AddInstance("ScrollingFrame", {
			Id = props.Id,

			ScrollingDirection = Enum.ScrollingDirection.X,
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AnchorPoint = props.AnchorPoint,
			ScrollBarThickness = padding,
			BackgroundTransparency = 1,
			Position = props.Position,
			BorderSizePixel = 0,
			Size = props.Size,
			ZIndex = 1

		}, ui:AddInstance("UIListLayout", {
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = props.HorizontalAlignment,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, padding)
		}))

		local current = props.Filters[1]
		for _, filter in ipairs(props.Filters) do
			local img = ui:AddInstance("ImageLabel", {
				Image = "rbxassetid://71605317317599",
				Position = UDim2.fromScale(.5, .5),
				AnchorPoint = Vector2.new(.5, 0),
				ScaleType = Enum.ScaleType.Fit,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,

				Colors_Primary = {"ImageColor3"},
				Tags = {"Colors_Primary"}
			})

			local lbl = ui:AddInstance("TextLabel", {
				Position = UDim2.fromScale(.5, .5),
				AnchorPoint = Vector2.new(.5, .5),
				Size = UDim2.fromScale(1, .5),
				BackgroundTransparency = 1,
				Text = filter.Title[1],
				TextScaled = true,

				Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
				Colors_Text_Primary = {"TextColor3"},
				Country_Code = filter.Title
			})

			ui:AddInstance("TextButton", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Parent = comp,
				Text = "",

				MouseButton1Click = function()
					if current then current:Unselect() end
					current = filter
					filter:Select()
				end

			}, img, lbl, ui:AddInstance("UIAspectRatioConstraint", {
				DominantAxis = Enum.DominantAxis.Height,
				AspectRatio = 2
			}))

			function filter:Select()
				img:Tween(tweens.default, { ImageTransparency = 0 })
				if filter.Callback then filter.Callback(lbl.instance.Text) end
			end

			function filter:Unselect()
				img:Tween(tweens.default, { ImageTransparency = 1 })
			end
		end

		function comp:Refresh()
			if not ui.Loaded then return end
			if current then task.spawn(current.Select, current) end
		end

		--task.defer(comp.Refresh, comp)
		return comp
	end)))

	ui:CreateComponent("HistorySelector").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local padding = props.Padding or 8

		-- Container principale
		local comp = ui:AddInstance("ScrollingFrame", {
			Id = props.Id,

			ScrollingDirection = Enum.ScrollingDirection.X,
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			CanvasSize = UDim2.fromScale(0, 0),
			AnchorPoint = props.AnchorPoint,
			ScrollBarThickness = padding,
			BackgroundTransparency = 1,
			Position = props.Position,
			Visible = props.Visible,
			BorderSizePixel = 0,
			Size = props.Size,
			ZIndex = 1

		}, ui:AddInstance("UIListLayout", {
			HorizontalAlignment = props.HorizontalAlignment or Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, padding)
		}))

		local current = {}
		function comp:SetPath(path: {any})
			for _, v in ipairs(current) do v:Remove() end
			framework.utils.tables.clear(current)

			for i, segment in ipairs(path) do
				if i > 1 then
					framework.utils.tables.insert(current, ui:AddInstance("TextLabel", {
						AutomaticSize = Enum.AutomaticSize.X,
						Size = UDim2.fromScale(0, 1),
						BackgroundTransparency = 1,
						TextTransparency  = .5,
						TextScaled = true,
						LayoutOrder = i *2,
						Parent = comp,
						Text = "›",

						Tags = {"Colors_Text_Primary", "Fonts_Body"},
						Colors_Text_Primary = {"TextColor3"}
					}))
				end

				local isLast = (i == #path)
				framework.utils.tables.insert(current, ui:AddInstance("TextButton", {
					Size = UDim2.fromScale(0, isLast and 1 or .65),
					TextTransparency = isLast and 0 or .5,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					Text = segment.name,
					LayoutOrder = i *2 +1,
					TextScaled = true,
					Parent = comp,

					Tags = {"Colors_Text_Primary", isLast and "Fonts_Body" or "Fonts_HeadingItalic"},
					Colors_Text_Primary = {"TextColor3"},

					MouseButton1Click = function() segment:Browse() end
				}))
			end
		end

		return comp
	end)))

	ui:CreateComponent("CloudScriptInfo").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(scr: {any}, props: {any})
		if not scr.features then
			local res = framework.dependencies.cloudscripts:FetchDetails(scr.slug)
			if res then
				scr.updatedAt = res.updatedAt
				scr.features = res.features
				scr.script = res.script
			end
		end
		
		if not scr.script then 
			task.spawn(function()
				local res = framework.dependencies.cloudscripts:FetchDetails(scr.slug)
				scr.script = res and res.script or ""
			end)
		end

		local innerImg = ui:AddInstance("ImageLabel", {
			Image = scr.Image or "rbxassetid://71177623238811",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.6, .6),
			BackgroundTransparency = 1,
			BorderSizePixel = 0

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.25, 0)

		}), ui:AddInstance("UIAspectRatioConstraint", {
			AspectType = Enum.AspectType.ScaleWithParentSize,
			DominantAxis = Enum.DominantAxis.Width,
			AspectRatio = 16/9
		}))

		local img = ui:AddInstance("ImageLabel", {
			Image = "rbxassetid://99756586318026", --71177623238811",
			ImageColor3 = Color3.fromHex("#F00"),
			Position = UDim2.fromScale(-.1, 0),
			Size = UDim2.fromScale(.6, .75),
			BackgroundTransparency = 1,
			BorderSizePixel = 0

		}, innerImg)

		local comp
		local fav = ui:AddInstance("ImageButton", {
			Image = scr.isFavourite and "rbxassetid://137934368112423" or "rbxassetid://80350699155696",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,
			ImageColor3 = Color3.fromHex("#FDC41B"),

			MouseButton1Click = function() comp:SetFavourite(scr.setFavourite()) end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)
		}))

		comp = ui:AddInstance("ImageButton", {
			BackgroundColor3 = Color3.fromHex("#000"),
			Image = scr.Image or "rbxassetid://71177623238811",
			ImageColor3 = Color3.fromHex("#202020"),
			Position = UDim2.fromScale(0, 0),
			Parent = ui:Get("MainFrame"),
			Size = UDim2.fromScale(1, 1),
			AutoButtonColor = false,
			ZIndex = 499,

		}, ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#FFF"),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = .5,
			Size = UDim2.fromScale(1, 1)

		}, ui:AddInstance("UIPadding", {
			PaddingTop = UDim.new(.075, 0),
			PaddingBottom = UDim.new(.075, 0),
			PaddingLeft = UDim.new(.05, 0),
			PaddingRight = UDim.new(.05, 0)

		}), ui:AddInstance("UIGradient", {
			Rotation = -90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#000")),
				ColorSequenceKeypoint.new(.175, Color3.fromHex("#000")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#707070"))
			}),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, .35)
			})

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Text = scr.title or "Cloud Script",
			Position = UDim2.fromScale(0, .0),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.fromScale(.98, .1),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"}

		}), img, ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(0, .65),
			Size = UDim2.fromScale(.2, .1),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
			Country_Code = {"Creation date:","Data di creazione:","Ngày tạo:","Data de criação:","Tanggal pembuatan:","Дата создания:","Erstellungsdatum:","Fecha de creación:","Date de création :","创建日期：","作成日：","تاريخ الإنشاء:","निर्माण तिथि:","วันที่สร้าง:"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.2, .7),
			Text = scr.createdAt and framework.utils.datetimes.unixToDAgo(framework.utils.datetimes.isoToUnix(scr.createdAt)) or "N/A",
			AnchorPoint = Vector2.new(0, .5),
			Size = UDim2.fromScale(.2, .07),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_HeadingItalic"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(0, .73),
			Size = UDim2.fromScale(.2, .1),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,
			Visible = props.updatedAt and true or false,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
			Country_Code = {"Update date:","Data di aggiornamento:","Ngày cập nhật:","Data de atualização:","Tanggal pembaruan:","Дата обновления:","Aktualisierungsdatum:","Fecha de actualización:","Date de mise à jour :","更新日期：","更新日：","تاريخ التحديث:","अपडेट की तिथि:","วันที่อัปเดต:"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.2, .78),
			AnchorPoint = Vector2.new(0, .5),
			Text = scr.updatedAt and framework.utils.datetimes.unixToDAgo(framework.utils.datetimes.isoToUnix(scr.updatedAt)) or "N/A",
			Size = UDim2.fromScale(.2, .07),
			BackgroundTransparency = 1,
			TextScaled = true,
			Visible = props.updatedAt and true or false,

			Tags = {"Colors_Text_Primary", "Fonts_HeadingItalic"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("ImageLabel", {
			Image = "rbxassetid://71545944975150",	
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromScale(.05, .15),
			BackgroundTransparency = 1

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		})), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Text = scr.game or "Game name N/A",
			Position = UDim2.fromScale(.065, 1),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromScale(.3, .1),
			BackgroundTransparency = 1,
			TextScaled = true,
			TextTransparency = .2,

			Tags = {"Colors_Text_Primary", "Fonts_Body"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#000"),
			Position = UDim2.fromScale(1, .12),
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.fromScale(.5, .65),
			BackgroundTransparency = .5,
			ZIndex = 1,

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding*2),
			PaddingRight = UDim.new(0, padding*2),
			PaddingLeft = UDim.new(0, padding*2),
			PaddingTop = UDim.new(0, padding*2)

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.fromScale(1, .075),
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Heading", "Colors_Text_Primary"},
			Country_Code = {"DESCRIPTION","DESCRIZIONE","MÔ TẢ","DESCRIÇÃO","DESKRIPSI","ОПИСАНИЕ","BESCHREIBUNG","DESCRIPCIÓN","DESCRIPTION","描述","説明","الوصف","विवरण","รายละเอียด"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", { -- NO DESCR PROVIDED
			Text = scr.features or "No description.", --"This highly optimized script leverages Roblox's experimental parallel execution framework to dynamically reshape in-game terrain using real-time quantum noise functions. By integrating asynchronous spatial threading with localized biome-awake AI prediction models, the script ensures seamless environmental transitions across all client-server instances. Includes built-in redundancy bypass for legacy terrain annchors",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.fromScale(0, .075),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.fromScale(1, .9),
			BackgroundTransparency = 1,
			TextWrapped = true,
			TextSize = padding*1.5,

			Tags = {"Fonts_Heading", "Colors_Text_Primary"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.075, 0)

		})), ui:AddInstance("ImageLabel", {
			Id = "Popup_ExecuteButtonShadow",

			BackgroundColor3 = Color3.fromHex("#000"),
			Image = "rbxassetid://111537386489097",
			Position = UDim2.fromScale(1.06, 1.1075),
			Size = UDim2.fromScale(.35, .35),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.117

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://100628992603432",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.3, .3),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				utils:AnimateCascade(ui:Get("Popup_ExecuteButtonShadow").instance, {
					AnimateSelf = true,
					SkipTransparency  = true
				})

				if scr.verified then
					return framework.execution:Execute(scr.script)
				end

				utils:ShowToast("ButtonToast", {
					AdditionalText = {"Script not verified, execute?","Script non verificato, eseguire?","Tập lệnh chưa được xác minh, thực thi?","Script não verificado, executar?","Skrip belum diverifikasi, jalankan?","Скрипт не проверен, выполнить?","Skript nicht verifiziert, ausführen?","Script no verificado, ¿ejecutar?","Script non vérifié, exécuter ?","脚本未验证，执行？","スクリプトが未検証です、実行しますか？","البرنامج النصي غير مُتحقق منه، هل تريد التنفيذ؟","स्क्रिप्ट सत्यापित नहीं है, चलाएँ?","สคริปต์ไม่ได้รับการยืนยัน ต้องการเรียกใช้หรือไม่?"},
					Style = "confirm",

					Callback = function(res: boolean)
						if not res then return end
						framework.execution:Execute(scr.script)
					end
				})
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- COPY BUTTON
			Id = "Popup_CopyButtonShadow",

			BackgroundColor3 = Color3.fromHex("#F00"),
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.885, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://104350786247520",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,

			MouseButton1Click = function() 
				utils:AnimateCascade(ui:Get("Popup_CopyButtonShadow").instance, {
					AnimateSelf = true,
					SkipTransparency  = true
				})

				framework.utils.clipboard:Set(scr.script) 
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- OPEN EDITOR BUTTON
			Id = "Popup_OpenEditorButtonShadow",

			BackgroundColor3 = Color3.fromHex("#F00"),
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.78, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://100582884942929",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				utils:AnimateCascade(ui:Get("Popup_OpenEditorButtonShadow").instance, {
					AnimateSelf = true,
					SkipTransparency  = true
				})

				local editor = framework.utils.inputs.editors:Get("Main_Editor")
				editor:AddTab(scr.title, scr.script)

				utils:ClosePopup()
				for _, page in ipairs(utils.pages) do
					if page.Name == "Executor" then
						ui.showPage(`Page_{page.Name}`, page.Indicator)
						break
					end
				end
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- FAVS BUTTON
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.675, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), fav)))

		scr.loadImage(comp.instance, true)
		scr.loadImage(innerImg.instance, true)

		function comp:SetFavourite(status: boolean)
			fav.instance.Image = status and framework.protected:ProtectAsset("rbxassetid://137934368112423") or "rbxassetid://80350699155696"
			if props.component then props.component:SetFavourite(status) end
		end

		return comp
	end)))

	ui:CreateComponent("LocalScriptInfo").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(file: {any}, props: {any})
		local src, content = file:Read()
		content = content or {}
		src = src or ""

		local comp
		local fav = ui:AddInstance("ImageButton", {
			Image = file:GetProperty("favourite") and "rbxassetid://137934368112423" or "rbxassetid://80350699155696",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,
			ImageColor3 = Color3.fromHex("#FDC41B"),

			MouseButton1Click = function()
				local status = not (file:GetProperty("favourite") and true or false)
				file:SetProperty({ favourite = status })
				comp:SetFavourite(status)

				framework.dependencies.editortabs:GetSaved("tabs")
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)
		}))

		local autoexec
		local updateAutoexec = function()
			autoexec.instance.ImageColor3 = (not not file:GetProperty("autoexecute")) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(85, 170, 0)
		end

		local refreshTabs = function()
			local tabs = framework.dependencies.editortabs
			if utils.tabsMode == "files" then return end
			
			for _, tab in ipairs(tabs:GetTabs()) do
				local state = tab:GetProperty(utils.tabsMode) and true or false
				tab:GetData().instance.instance.Visible = state

				tabs:GetSavedByProperties({
					[utils.tabsMode] = {true}	
				}, "tabs")
			end
		end

		autoexec = ui:AddInstance("ImageButton", {
			Image = "rbxassetid://115061506034125",	
			Position = UDim2.fromScale(.675, .685),
			Size = UDim2.fromScale(.05, .1),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				local status = not (file:GetProperty("autoexecute") and true or false)
				file:SetProperty({ autoexecute = status })
				autoexec.instance.ImageColor3 = status and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(85, 170, 0)
				refreshTabs()
			end
		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1
		}))

		comp = ui:AddInstance("ImageButton", {
			Image = props.Image or "rbxassetid://71177623238811",
			ImageColor3 = Color3.fromHex("#202020"),
			Position = UDim2.fromScale(0, 0),
			Parent = ui:Get("MainFrame"),
			Size = UDim2.fromScale(1, 1),
			AutoButtonColor = false,
			ZIndex = 499

		}, ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#fff"),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = .5,
			Size = UDim2.fromScale(1, 1)

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(.075, 0),
			PaddingRight = UDim.new(.05, 0),
			PaddingLeft = UDim.new(.05, 0),
			PaddingTop = UDim.new(.075, 0)

		}), ui:AddInstance("UIGradient", {
			Rotation = -90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHex("#000")),
				ColorSequenceKeypoint.new(.175, Color3.fromHex("#000")),
				ColorSequenceKeypoint.new(1, Color3.fromHex("#707070"))
			}),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, .35)
			})

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Text = file.name or "Local Script",
			Position = UDim2.fromScale(0, .0),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.fromScale(.98, .1),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_Title"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.675, .15),
			Size = UDim2.fromScale(.3, .075),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
			Country_Code = {"Creation date:","Data di creazione:","Ngày tạo:","Data de criação:","Tanggal pembuatan:","Дата создания:","Erstellungsdatum:","Fecha de creación:","Date de création :","创建日期：","作成日：","تاريخ الإنشاء:","निर्माण तिथि:","วันที่สร้าง:"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			Text = framework.utils.datetimes.unixToDAgo(content.creation or os.time()),
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.675, .25),
			AnchorPoint = Vector2.new(0, .5),
			Size = UDim2.fromScale(.2, .07),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_HeadingItalic"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.675, .32),
			Size = UDim2.fromScale(.3, .075),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
			Country_Code = {"Last viewed:","Ultima visualizzazione:","Lần cuối xem:","Última visualização:","Terakhir dilihat:","Последний просмотр:","Zuletzt angesehen:","Última visualización:","Dernière consultation :","上次查看：","最終閲覧：","آخر مشاهدة:","अंतिम बार देखा गया:","การเข้าชมล่าสุด:"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("TextLabel", {
			Text = framework.utils.datetimes.unixToDAgo(content.viewed or os.time()),
			TextXAlignment = Enum.TextXAlignment.Left,	
			Position = UDim2.fromScale(.675, .42),
			AnchorPoint = Vector2.new(0, .5),
			Size = UDim2.fromScale(.2, .07),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Colors_Text_Primary", "Fonts_HeadingItalic"},
			Colors_Text_Primary = {"TextColor3"}

		}), autoexec, ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(.725, .7),
			Size = UDim2.fromScale(.3, .05),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Heading"},
			Country_Code = {"Auto-Execute","Auto-Esecuzione","Tự động thực thi","Auto-executar","Eksekusi Otomatis","Автовыполнение","Automatische Ausführung","Ejecución automática","Exécution automatique","自动执行","自動実行","التنفيذ التلقائي","स्वचालित निष्पादन","เรียกใช้โดยอัตโนมัติ"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#000"),
			Position = UDim2.fromScale(0, .12),
			Size = UDim2.fromScale(.65, .65),
			AnchorPoint = Vector2.new(0, 0),
			BackgroundTransparency = .5,
			ZIndex = 1,

		}, ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding*2),
			PaddingRight = UDim.new(0, padding*2),
			PaddingLeft = UDim.new(0, padding*2),
			PaddingTop = UDim.new(0, padding*2)

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(0, 0),
			Size = UDim2.fromScale(1, .075),
			AnchorPoint = Vector2.new(0, 0),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,
			Text = "CONTENT",

			Tags = {"Country_Code", "Fonts_Heading", "Colors_Text_Primary"},
			Country_Code = {"CONTENT","CONTENUTO","Nội dung","Conteúdo","Konten","Контент","Inhalt","Contenido","Contenu","内容","コンテンツ","المحتوى","सामग्री","เนื้อหา"},
			Colors_Text_Primary = {"TextColor3"}

		}), ui:AddComponent("CodeEditor", {
			Position = UDim2.fromScale(0, .1),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.fromScale(1, .7),
			Text = src,

			Focused = framework.protected:GCProtect(function()
				utils:EditorMode(true, .175)

				--framework.utils.inputs.editors:Get("Main_Editor"):ToggleHighlighter(false)
			end),

			FocusLost = framework.protected:GCProtect(function()
				utils:EditorMode(false)

				--local editor = framework.utils.inputs.editors:Get("Main_Editor")
				--local tabs = framework.dependencies.editortabs

				--local tab = tabs:GetSelection()
				--if not tab then return end

				--tab:SetSource(editor:GetText())
				--editor:ToggleHighlighter(true)
			end)

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.075, 0)

		})), ui:AddInstance("ImageLabel", { -- EXECUTE BUTTON
			BackgroundColor3 = Color3.fromHex("#000"),
			Position = UDim2.fromScale(1.06, 1.1075),
			Image = "rbxassetid://111537386489097",
			Size = UDim2.fromScale(.35, .35),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.1170212766

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://100628992603432",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.3, .3),
			BackgroundTransparency = 1,

			MouseButton1Click = function() framework.execution:Execute(src) end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- COPY BUTTON
			BackgroundColor3 = Color3.fromHex("#F00"),
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.885, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99,

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), ui:AddInstance("ImageButton", { 
			Image = "rbxassetid://104350786247520", 
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,

			MouseButton1Click = function() framework.utils.clipboard:Set(src) end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- OPEN EDITOR BUTTON
			BackgroundColor3 = Color3.fromHex("#F00"),
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.78, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99,

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://100582884942929",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				local editor = framework.utils.inputs.editors:Get("Main_Editor")
				editor:AddTab(file.name, src)

				utils:ClosePopup()
				for _, page in ipairs(utils.pages) do
					if page.Name == "Executor" then
						ui.showPage(`Page_{page.Name}`, page.Indicator)
						break
					end
				end
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)

		}))), ui:AddInstance("ImageLabel", { -- FAVS BUTTON
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(.675, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(1,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), fav), ui:AddInstance("ImageLabel", { -- DELETE SCRIPT BUTTON
			Image = "rbxassetid://96112258106990",
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.fromScale(.112, .133),
			AnchorPoint = Vector2.new(0,1),
			BackgroundTransparency = 1,
			ZIndex = 99

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1.125

		}), ui:AddInstance("ImageButton", {
			Image = "rbxassetid://80286816747552",
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			Size = UDim2.fromScale(.75, .75),
			BackgroundTransparency = 1,

			MouseButton1Click = function()
				utils:ShowToast("ButtonToast", {
					AdditionalText = {`Delete {file.name}?`,`Eliminare {file.name}?`,`Xóa {file.name}?`,`Excluir {file.name}?`,`Hapus {file.name}?`,`Удалить {file.name}?`,`{file.name} löschen?`,`¿Eliminar {file.name}?`,`Supprimer {file.name}?`,`删除 {file.name}?`,`{file.name} を削除しますか？`,`هل تريد حذف {file.name}؟`,`{file.name} हटाएँ?`,`ลบ {file.name}?`},
					AdditionalTitle = {"Delete file","Eliminare file","Xóa tệp","Excluir arquivo","Hapus file","Удалить файл","Datei löschen","¿Eliminar archivo?","Supprimer le fichier","删除文件","ファイルを削除","حذف الملف","फ़ाइल हटाएँ","ลบไฟล์"},
					Style = "confirm",

					Callback = function(res: boolean)
						if not res then return end
						file:Delete()

						framework.dependencies.scripthub:Browse(nil, true, "scripthub")
						framework.dependencies.editortabs:GetSaved("tabs")
						utils:ClosePopup()
					end
				})
			end

		}, ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.5, 0)
		})))))

		function comp:SetFavourite(status: boolean)
			fav.instance.Image = status and framework.protected:ProtectAsset("rbxassetid://137934368112423") or "rbxassetid://80350699155696"
			if props.component then props.component:SetFavourite(status) end
			refreshTabs()
		end

		updateAutoexec()
		return comp
	end)))

	ui:CreateComponent("CodeEditor").OnCreating:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(props: {any})
		local sizes = ui:AddInstance("UISizeConstraint", {
			MaxSize = Vector2.new(math.huge, math.huge),
			MinSize = Vector2.zero
		})

		local lines = ui:AddInstance("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Top,
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromScale(.025, 0),
			Size = UDim2.fromScale(.05, 0),
			BackgroundTransparency = 1,
			TextTransparency = .45,
			Text = "",

			Tags = {"FontSizes_Editor", "Colors_Text_Primary", "Fonts_Editor"},
			Colors_Text_Primary = {"TextColor3"}

		}, sizes)

		local textbox = ui:AddInstance("TextBox", {
			Id = props.Id,

			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			AutomaticSize = Enum.AutomaticSize.XY,
			Size = UDim2.fromScale(1, 1),
			FocusLost = props.FocusLost,
			BackgroundTransparency = 1,
			ClearTextOnFocus = false,
			Focused = props.Focused,
			MultiLine = true,

			Tags = {"FontSizes_Editor", "Colors_Text_Primary", "Fonts_Editor"},
			Colors_Text_Primary = {"TextColor3"}
		})

		local scrollx = ui:AddInstance("ScrollingFrame", {
			ScrollingDirection = Enum.ScrollingDirection.X,
			AutomaticCanvasSize = Enum.AutomaticSize.X,
			AutomaticSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.fromScale(0, 0),
			Position = UDim2.fromScale(.1, 0),
			ScrollBarThickness = padding,
			Size = UDim2.fromScale(.9, .7),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,

			Colors_Primary = {"ScrollBarImageColor3"},
			Tags = {"Colors_Primary"}

		}, textbox, ui:AddInstance("Frame", {
			Size = UDim2.fromOffset(padding * 10, padding*10),
			Position = UDim2.fromScale(0, 1),
			BackgroundTransparency = 1,

			Tags = {"UI_WindowState"},
			UI_WindowState = {
				Size = {false, UDim2.fromOffset(padding * 12.5, padding*12.5), UDim2.fromOffset(padding * 15, padding*15)}
			}
		}))

		local overlay = ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = .5,
			Visible = false,
			ZIndex = 2

		}, ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromRGB(138, 138, 138),
			Position = UDim2.fromScale(.5, .1),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.5, .1)

		}, ui:AddInstance("TextLabel", {
			Position = UDim2.fromScale(.5, .1),
			AnchorPoint = Vector2.new(.5, 0),
			Size = UDim2.fromScale(.9, .75),
			BackgroundTransparency = 1,
			TextScaled = true,

			Country_Code = {"Text too long to be edited, read only.","Testo troppo lungo per essere modificato, solo lettura.","Văn bản quá dài để chỉnh sửa, chỉ đọc.","Texto muito longo para ser editado, somente leitura.","Teks terlalu panjang untuk diedit, hanya baca.","Текст слишком длинный для редактирования, только для чтения.","Text zu lang zum Bearbeiten, nur Lesezugriff.","Texto demasiado largo para editar, solo lectura.","Texte trop long pour être modifié, lecture seule.","文本过长无法编辑，仅可读取。","テキストが長すぎて編集できません。読み取り専用です。","النص طويل جدًا ولا يمكن تحريره، للقراءة فقط.","पाठ संपादन के लिए बहुत लंबा है, केवल पढ़ने के लिए।","ข้อความยาวเกินไป ไม่สามารถแก้ไขได้ อ่านอย่างเดียว"},
			Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Editor"}

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})))

		local editor = framework.utils.inputs.editors.new(props.Id)
		local scrolly = ui:AddInstance("ScrollingFrame", {
			ScrollingDirection = Enum.ScrollingDirection.Y,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.fromScale(0, 0),
			AnchorPoint = props.AnchorPoint,
			ScrollBarThickness = padding,
			BackgroundTransparency = 1,
			Position = props.Position,
			BorderSizePixel = 0,
			Size = props.Size,
			ZIndex = 1,

			Colors_Primary = {"ScrollBarImageColor3"},
			Tags = {"Colors_Primary"},

			OnRemoved = function() editor:Remove() end

		}, lines, scrollx, overlay)

		local highlightmaxchars = 10000
		local constraint = sizes.instance
		local updateLines = framework.protected:GCProtect(function()
			local y = scrollx.instance.AbsoluteSize.Y

			constraint.MinSize = Vector2.zero -- Prevent roblox from being too smart
			constraint.MaxSize = Vector2.new(math.huge, math.huge)

			constraint.MaxSize = Vector2.new(math.huge, y)
			y = framework.utils.maths.clamp(y, constraint.MaxSize.Y, math.huge)
			constraint.MinSize = Vector2.new(0, y)
		end)

		updateLines()
		scrollx.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateLines)
		textbox.instance:GetPropertyChangedSignal("TextEditable"):Connect(function()
			overlay.instance.Visible = not textbox.instance.TextEditable
		end)

		editor:ConnectHighlighter(textbox, highlightmaxchars)
		editor:SetHighlighterColors(ui.highColors)
		editor:ConnectLinesCounter(lines)
		editor:SetText(props.Text or "")
		return scrolly
	end)))

	ui:CreateComponent("SettingToggle").OnCreating:Connect(framework.protected:GCProtect(function(props: {any})
		local state, toggle, knob = false, nil, nil
		
		local function updateColor(color)
			if state then
				return toggle:Tween(tweens.default, {
					BackgroundColor3 = color,
					BackgroundTransparency = 0
				})
			end
			
			toggle:Tween(tweens.default, {
				BackgroundColor3 = Color3.fromHex("#555"),
				BackgroundTransparency = 0
			})
		end
		
		local function update(enabled: boolean?)
			state = enabled
			
			local goalPos = enabled and UDim2.fromScale(.8, .5) or UDim2.fromScale(.2, .5)
			knob:Tween(tweens.default, { Position = goalPos })

			local succ, err = pcall(Color3.fromHex, framework.settings:GetSetting("Colors_Primary"))
			updateColor(succ and err or Color3.fromHex(framework.settings:GetDefaultSetting("Colors_Primary")))
		end
		
		knob = ui:AddInstance("Frame", {
			Position = UDim2.fromScale(.8, .5),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.65, .8),
			BackgroundTransparency = 1

		}, ui:AddInstance("UIAspectRatioConstraint"), ui:AddInstance("Frame", {
			BackgroundColor3 = Color3.fromHex("#fff"),
			Size = UDim2.fromScale(1, 1)

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)

		}), ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)

		}), ui:AddInstance("UIAspectRatioConstraint")))
		
		toggle = ui:AddInstance("ImageButton", {
			Position = UDim2.fromScale(.875, .5),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.15, .5),

			Tags = {"Colors_Primary"},
			Colors_Primary = updateColor,

			MouseButton1Click = framework.protected:GCProtect(function()
				state = not state
				update(state)

				props.Callback(state)
			end)

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)

		}), knob)

		local comp = ui:AddInstance("Frame", {
			Id = props.Id or ("Setting_" .. (props.Title:gsub("%s+", ""))),

			BackgroundColor3 = Color3.fromHex("#000"),
			ZIndex = -(props.LayoutOrder or 0),
			LayoutOrder = props.LayoutOrder,
			Size = UDim2.fromScale(.9, .2),
			BackgroundTransparency = .7,
			Position = props.Position

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0.25, 0)

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Bottom,
			Position = UDim2.fromScale(.025, .1),
			TextColor3 = Color3.fromHex("#fff"),
			Size = UDim2.fromScale(.6, .4),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Heading"},
			Country_Code = props.Title

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.fromScale(.025, .85),
			TextColor3 = Color3.fromHex("#fff"),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromScale(.6, .3),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Description"},
			Country_Code = props.Description

		}), toggle)

		knob.instance:GetPropertyChangedSignal("Position"):Connect(function()
			update(state)
		end)

		task.defer(function()
			update(props.Enabled())
		end)
		
		return comp
	end))
		
	ui:CreateComponent("SettingDropdown").OnCreating:Connect(framework.protected:GCProtect(function(props: {any})
		local btn, list, content, listLayout
		local lastText = props.Options[1].Name

		btn = ui:AddInstance("TextButton", {
			Text = utils:Translate(lastText),
			Position = UDim2.fromScale(.975, .5),
			AnchorPoint = Vector2.new(1, .5),
			Size = UDim2.fromScale(.25, .5),
			BackgroundTransparency = .85,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Body","Colors_Text_Primary","Colors_Primary"},
			Colors_Primary = {"BackgroundColor3"},
			Colors_Text_Primary = {"TextColor3"},
			
			On_Country_Code = framework.protected:GCProtect(function()
				btn.instance.Text = utils:Translate(lastText)
			end),

			MouseButton1Click = framework.protected:GCProtect(function()
				list.instance.Visible = not list.instance.Visible
			end)

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.35, 0)
			
		}), ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0, padding),
			PaddingRight = UDim.new(0, padding),
			PaddingLeft = UDim.new(0, padding),
			PaddingTop = UDim.new(0, padding)
		}))

		-- frame scrollabile
		list = ui:AddInstance("ScrollingFrame", {
			BackgroundColor3 = Color3.fromHex("#000"),
			Position = UDim2.fromScale(.975, 1.05),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Size = UDim2.fromScale(.25, 2.5), -- altezza massima visibile (2.5 ~ 40% schermo)
			AnchorPoint = Vector2.new(1,0),
			BackgroundTransparency = .15,
			ClipsDescendants = true,
			ScrollBarThickness = 4,
			BorderSizePixel = 0,
			Visible = false,
			ZIndex = 10,

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(.15, 0)
			
		}), ui:AddInstance("UIPadding", {
			PaddingBottom = UDim.new(0.05, 0),
			PaddingRight = UDim.new(0.05, 0),
			PaddingLeft = UDim.new(0.05, 0),
			PaddingTop = UDim.new(0.05, 0)
		}))

		-- contenitore autosize
		content = ui:AddInstance("Frame", {
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Parent = list.instance
			
		}, ui:AddInstance("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 10), -- padding maggiore per touch
			SortOrder = Enum.SortOrder.LayoutOrder
		}))

		listLayout = content.instance:FindFirstChildOfClass("UIListLayout")

		-- opzioni
		for _, option in ipairs(props.Options) do
			ui:AddInstance("TextButton", {
				Parent = content.instance,
				Size = UDim2.new(1, 0, 0, 30), -- altezza fissa in pixel
				BackgroundTransparency = 1,
				TextScaled = true,
				TextWrapped = true,

				Tags = {"Country_Code", "Colors_Text_Primary","Fonts_Body"},
				Colors_Text_Primary = {"TextColor3"},
				Country_Code = option.Name,

				MouseButton1Click = framework.protected:GCProtect(function()
					btn.instance.Text = utils:Translate(option.Name)
					lastText = option.Name
					
					list.instance.Visible = false
					props.Callback(option.Value)
				end)
			})
		end

		-- aggiorna canvas size in base al contenitore
		listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			list.instance.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 50)
		end)

		if props.SelectedValue then
			task.defer(function()
				local val = props.SelectedValue()
				for _, option in ipairs(props.Options) do
					if val == option.Value then
						lastText = option.Name
						btn.instance.Text = utils:Translate(option.Name)
						break
					end
				end
			end)
		end

		local comp = ui:AddInstance("Frame", {
			Id = props.Id or `Setting_{props.Title:gsub("%s+", "")}`,

			BackgroundColor3 = Color3.fromHex("#000"),
			ZIndex = -(props.LayoutOrder or 0),
			LayoutOrder = props.LayoutOrder,
			Size = UDim2.fromScale(.9, .2),
			BackgroundTransparency = .7,
			Position = props.Position

		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
			
		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Bottom,
			Position = UDim2.fromScale(.025, .1),
			TextColor3 = Color3.fromHex("#fff"),
			Size = UDim2.fromScale(.6, .4),
			BackgroundTransparency = 1,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Heading"},
			Country_Code = props.Title

		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.fromScale(.025, .85),
			TextColor3 = Color3.fromHex("#fff"),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromScale(.6, .3),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,

			Tags = {"Country_Code", "Fonts_Description"},
			Country_Code = props.Description

		}), btn, list)

		return comp
	end))
	
	ui:CreateComponent("SettingNumeric").OnCreating:Connect(framework.protected:GCProtect(function(props: {any})
		props.Increment = props.Increment or 1
		props.Min = props.Min or -math.huge
		props.Max = props.Max or math.huge
		props.Value = props.Value or 0

		local value = ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.fromScale(.35, 1),
			Text = tostring(props.Value),
			BackgroundTransparency = 1,
			TextScaled = true,
			LayoutOrder = 2,

			Tags = {"Fonts_Body","Colors_Text_Primary"},
			Colors_Text_Primary = {"TextColor3"}
		})

		local function setNum(num: number)
			num = framework.utils.maths.clamp(num, props.Min, props.Max)
			if props.Value ~= num then
				props.Value = num
				value.instance.Text = tostring(num)
				props.Callback(num)
			end
		end

		local process
		local stop = framework.protected:GCProtect(function()
			if process then task.cancel(process) end
		end)
		
		local down = ui:AddInstance("TextButton", {
			Size = UDim2.fromScale(.25, 1),
			BackgroundTransparency = .2,
			TextScaled = true,
			LayoutOrder = 1,
			Text = "−",
			
			MouseButton1Up = stop,
			MouseButton1Click = framework.protected:GCProtect(function()
				setNum(props.Value - props.Increment)
			end),
			
			Tags = {"Fonts_Body","Colors_Text_Primary","Colors_Primary"},
			Colors_Primary = {"BackgroundColor3"},
			Colors_Text_Primary = {"TextColor3"}
			
		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}))
		
		local up = ui:AddInstance("TextButton", {
			Size = UDim2.fromScale(.25, 1),
			BackgroundTransparency = .2,
			TextScaled = true,
			LayoutOrder = 3,
			Text = "+",
			
			MouseButton1Up = stop,
			MouseButton1Click = framework.protected:GCProtect(function()
				setNum(props.Value + props.Increment)
			end),
			
			Tags = {"Fonts_Body","Colors_Text_Primary","Colors_Primary"},
			Colors_Primary = {"BackgroundColor3"},
			Colors_Text_Primary = {"TextColor3"}
			
		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}))

		local comp = ui:AddInstance("Frame", {
			Id = props.Id or ("Setting_" .. (props.Title:gsub("%s+", ""))),
			
			BackgroundColor3 = Color3.fromHex("#000"),
			ZIndex = -(props.LayoutOrder or 0),
			LayoutOrder = props.LayoutOrder,
			Size = UDim2.fromScale(.9, .2),
			BackgroundTransparency = .7,
			Position = props.Position
			
		}, ui:AddInstance("UICorner", {
			CornerRadius = UDim.new(0.25, 0)
			
		}), ui:AddInstance("TextLabel", {
			TextYAlignment = Enum.TextYAlignment.Bottom,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromScale(.025, .1),
			TextColor3 = Color3.fromHex("#fff"),
			Size = UDim2.fromScale(.6, .4),
			BackgroundTransparency = 1,
			TextScaled = true,
			
			Tags = {"Country_Code", "Fonts_Heading"},
			Country_Code = props.Title
			
		}), ui:AddInstance("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			Position = UDim2.fromScale(.025, .85),
			TextColor3 = Color3.fromHex("#fff"),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.fromScale(.6, .3),
			BackgroundTransparency = 1,
			TextTransparency = .5,
			TextScaled = true,
			
			Tags = {"Country_Code", "Fonts_Description"},
			Country_Code = props.Description
			
		}), ui:AddInstance("Frame", {
			AnchorPoint = Vector2.new(1, .5),
			Position = UDim2.fromScale(.975, .5),
			Size = UDim2.fromScale(.38, .55),
			BackgroundTransparency = 1
			
		}, ui:AddInstance("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6)
			
		}), down, value, up))

		-- press & hold
		local hup = framework.utils.inputs.buttons.holdable(up)
		hup.OnShortPress:Connect(framework.protected:GCProtect(function()
			setNum(props.Value + props.Increment)
		end))
		--[[hup.OnLongPress:Connect(framework.protected:GCProtect(function()
			local tim = .5
			process = task.spawn(function()
				while true do
					setNum(props.Value + props.Increment)
					task.wait(tim)
					tim = math.max(.1, tim - .1)
				end
			end)
		end))]]

		local hdown = framework.utils.inputs.buttons.holdable(down)
		hdown.OnShortPress:Connect(framework.protected:GCProtect(function()
			setNum(props.Value - props.Increment)
		end))
		--[[hdown.OnLongPress:Connect(framework.protected:GCProtect(function()
			local tim = .5
			process = task.spawn(function()
				while true do
					setNum(props.Value - props.Increment)
					task.wait(tim)
					tim = math.max(.1, tim - .1)
				end
			end)
		end))]]

		task.defer(function()
			setNum(props.StartValue())
		end)

		return comp
	end))

	local pages do
		local user = framework.protected:GetService("Players").LocalPlayer
		local displayName, aiName = user.DisplayName, "Arcy"

		pages = {
			{ Name = "Home", Icon = "rbxassetid://16548334799",
				Content = ui:AddInstance("Frame", {Id = "Home"},

				ui:AddInstance("ImageLabel", {
					Id = "ProfilePanelBackground",

					Position = UDim2.fromScale(.03, .15),
					Size = UDim2.fromScale(.375, .2),
					BackgroundTransparency = 1,

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.28, 0)

				}), ui:AddInstance("ImageLabel", {
					Id = "UserPFP",

					AnchorPoint = Vector2.new(0, .5),
					Position = UDim2.fromScale(.05, .5),
					Size = UDim2.fromScale(.3, .725),
					BackgroundTransparency = 1,

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				}), ui:AddInstance("ImageLabel", {
					Id = "PFPOverlay",

					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,

					Colors_Primary = {"ImageColor3"},
					Tags = {"Colors_Primary"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})), ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.3035, .2),
					Size = UDim2.fromScale(.6, .2),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Welcome","Benvenuto","Chào mừng","Bem-vindo","Selamat datang","Добро пожаловать","Willkommen","Bienvenido","Bienvenue","欢迎","ようこそ","مرحبًا","स्वागत","ยินดีต้อนรับ"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddComponent("MovingText", {
					Id = "MagicNicknameContainer",

					Position = UDim2.fromScale(.3035, .45),
					Size = UDim2.fromScale(.625, .35),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Text = displayName

				})), ui:AddInstance("ImageButton", {
					Id = "HomeTipBackground",
					
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.fromScale(.58, .15),
					Size = UDim2.fromScale(.16, .2),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					
					MouseButton1Click = framework.protected:GCProtect(function()
						framework.dependencies.plugins:Open("AXS_Hub", ui:Get("ExtensionContent"))
						for _, page in ipairs(utils.pages) do
							if page.Name == "Extensions" then
								ui.showPage(`Page_{page.Name}`, page.Indicator)
								break
							end
						end
					end)
					
				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.28, 0)

				}), ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://125983090347378",
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .35),
					Size = UDim2.fromScale(.75,.75),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1
					
				}), ui:AddInstance("TextLabel", {
					Text = "Arceus Hub",
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(.5, .75),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.8, .2),
					TextScaled = true,
					
					Tags = {"Fonts_Body", "Colors_Text_Primary"},
					Colors_Text_Primary = {"TextColor3"}
					
				})), ui:AddInstance("ImageLabel", {
					Id = "BestScriptsPanelBackground",

					Position = UDim2.fromScale(.03, .37),
					Size = UDim2.fromScale(.55, .36),
					BackgroundTransparency = 1,
					ClipsDescendants = true,

					Colors_Secondary = {"BackgroundColor3"},
					Tags = {"Colors_Secondary"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.15, 0)

				}), ui:AddInstance("TextLabel", {
					Position = UDim2.fromScale(.05, .05),
					Size = UDim2.fromScale(.9, .1),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Country_Code = {"Best Scripts","Migliori Scripts","Các kịch bản tốt nhất","Melhores scripts","Skrip terbaik","Лучшие скрипты","Beste Skripte","Mejores scripts","Meilleurs scripts","最佳脚本","最高のスクリプト","أفضل البرامج النصية","सर्वश्रेष्ठ स्क्रिप्ट","สคริปต์ที่ดีที่สุด"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddComponent("ContentBar", {
					Id = "BestScriptsBar",

					Position = UDim2.fromScale(.5, .575),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(1, .725)

				})), ui:AddInstance("Frame", {
					Id = "AIPanelBackground",

					Position = UDim2.fromScale(.03, .75),
					Size = UDim2.fromScale(.55, .2),
					BackgroundTransparency = .5,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					ClipsDescendants = true,

					Tags = {"Colors_Secondary"}

				}, ui:AddInstance("UIGradient", {
					Id = "AIPanelGradient",

					Rotation = 10,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(.0, Color3.fromHex("#15A6FE")),
						ColorSequenceKeypoint.new(.33, Color3.fromHex("#F473EC")),
						ColorSequenceKeypoint.new(.66, Color3.fromHex("#FF3869")),
						ColorSequenceKeypoint.new(1.0, Color3.fromHex("#FF3869"))
					})

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.3, 0)

				}), ui: AddInstance("ImageButton", {
					Id = "AIPanelBackgroundOverlay",
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					AutoButtonColor = false,
					ZIndex = 30,

					MouseButton1Click = framework.protected:GCProtect(function()
						for _, page in ipairs(utils.pages) do
							if page.Name == "ArceusIntelligence" then
								ui.showPage(`Page_{page.Name}`, page.Indicator)
								break
							end
						end
					end)

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.3, 0)

				}), ui:AddInstance("TextLabel", {
					AnchorPoint = Vector2.new(1, 0),
					TextXAlignment = Enum.TextXAlignment.Right,
					Position = UDim2.fromScale(.95, .1),
					Size = UDim2.fromScale(.35, .15),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Arceus Intelligence"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Caption"},
					Colors_Text_Primary = {"TextColor3"},

				}), ui:AddInstance("TextLabel", {
					AnchorPoint = Vector2.new(0, 1),
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.3, .425),
					Size = UDim2.fromScale(.2, .15),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Let's talk","Parliamo","Hãy nói chuyện","Vamos conversar","Mari bicara","Давай поговорим","Lass uns reden","Hablemos","Parlons","让我们谈谈","話しましょう","هيا نتحدث","चलिए बात करते हैं","มาคุยกันเถอะ"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Colors_Text_Primary = {"TextColor3"},

				}), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(0, .5),
					Position = UDim2.fromScale(.3 , .55),
					Size = UDim2.fromScale(.8, .275),
					BackgroundTransparency = 1,
					TextTransparency = .5,
					TextScaled = true,

					Country_Code = {`Hello! I'm {aiName}!`,`Ciao! Sono {aiName}!`,`Xin chào! Tôi là {aiName}!`,`Olá! Eu sou {aiName}!`,`Halo! Saya {aiName}!`,`Привет! Я {aiName}!`,`Hallo! Ich bin {aiName}!`,`Hola! Soy {aiName}!`,`Bonjour! Je suis {aiName}!`,`你好！我是 {aiName}！`,`こんにちは！私は {aiName} です！`,`مرحبًا! أنا {aiName}!`,`नमस्ते! मैं {aiName} हूँ!`,`สวัสดี! ฉันคือ {aiName}!`},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Colors_Text_Primary = {"TextColor3"},

				}), ui: AddInstance("ImageLabel", {
					Id = "AIIcon",
					Position = UDim2.fromScale(.05 , .5),
					Size = UDim2.fromScale(.85, .85),
					AnchorPoint = Vector2.new(0, .5),
					BackgroundTransparency = 1,

					Tags = {"Colors_Text_Primary"}

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui: AddInstance("ImageLabel", {
					Image = "rbxassetid://102982068367172",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.4, .4),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1,
					ImageTransparency = .2,

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}))))), ui:AddInstance("ImageLabel", {
					Id = "SlidersContainerBackground",

					Position = UDim2.fromScale(.97, .95),
					Size = UDim2.fromScale(.36 , .8),
					AnchorPoint = Vector2.new(1, 1),
					BackgroundTransparency = 1,

					Tags = {"Colors_Secondary"},
					Colors_Secondary = {"BackgroundColor3"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.11, 0)

				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.065, 0),
					PaddingTop = UDim.new(.065, 0),
					PaddingRight = UDim.new(.1, 0),
					PaddingLeft = UDim.new(.1, 0),

				}), ui:AddInstance("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(.05, 0)

				}), framework.protected:GCProtect(function()					
					local cache = {}
					local getHumanoid = framework.protected:GCProtect(function(char)
						local succ, hum: Humanoid = pcall(char.WaitForChild, char, "Humanoid")
						if not succ then return end

						return hum
					end)

					local frames, sliders = {}, {
						{
							Icon = "rbxassetid://15054333892",
							Label = {"Gravity","Gravità","Trọng lực","Gravidade","Gravitasi","Гравитация","Schwerkraft","Gravedad","Gravité","重力","重力","الجاذبية","गुरुत्वाकर्षण","แรงโน้มถ่วง"},
							Id = "Gravity",

							Def = 196.2, Min = .001, Max = 250, Ena = false,
							Set = framework.protected:GCProtect(function(value: number)
								framework.protected:GetService("Workspace").Gravity = value
							end)
						},
						{
							Icon = "rbxassetid://15054332032",
							Label = {"Jump","Salto","Nhảy","Pular","Lompat","Прыжок","Sprung","Salto","Saut","跳跃","ジャンプ","قفزة","कूद","กระโดด"},
							Id = "Jump",

							Def = 7.2, Min = 0, Max = 250, Ena = false,
							Set = framework.protected:GCProtect(function(value: number)
								cache.jump = cache.jump or {}
								local ccon, jcon = 
									cache.jump.ccon, cache.jump.jcon

								if ccon then ccon:Disconnect() end
								if jcon then jcon:Disconnect() end

								local plr: Player = framework.protected:GetService("Players").LocalPlayer
								local char = plr.Character

								if char then
									local hum = getHumanoid(char)
									if hum then
										hum.UseJumpPower = false
										hum.JumpHeight = value
									end
								end

								cache.jump.ccon = plr.CharacterAdded:Connect(function(char)
									local hum = getHumanoid(char)
									if not hum then return end

									hum.UseJumpPower = false
									hum.JumpHeight = value
									cache.jump.jcon = hum:GetPropertyChangedSignal("JumpHeight"):Connect(function()

										hum.UseJumpPower = false
										hum.JumpHeight = value
									end)
								end)
							end)
						},
						{
							Icon = "rbxassetid://15054335513",
							Label = {"Speed","Velocità","Tốc độ","Velocidade","Kecepatan","Скорость","Geschwindigkeit","Velocidad","Vitesse","速度","速度","السرعة","गति","ความเร็ว"},
							Id = "Speed",

							Def = 16, Min = 0, Max = 500, Ena = false,
							Set = framework.protected:GCProtect(function(value: number)
								cache.speed = cache.speed or {}
								local ccon, scon = 
									cache.speed.ccon, cache.speed.scon

								if ccon then ccon:Disconnect() end
								if scon then scon:Disconnect() end

								local plr: Player = framework.protected:GetService("Players").LocalPlayer
								local char = plr.Character

								if char then
									local hum = getHumanoid(char)
									if hum then hum.WalkSpeed = value end
								end

								cache.speed.ccon = plr.CharacterAdded:Connect(function(char)
									local hum = getHumanoid(char)
									if not hum then return end

									hum.WalkSpeed = value
									cache.speed.jcon = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
										hum.WalkSpeed = value
									end)
								end)
							end)
						}
					}

					for i, slider in ipairs(sliders) do
						local img = ui:AddInstance("ImageLabel", {
							Id = `Slider_{slider.Label[1]}`,

							Image = "rbxassetid://97199452213620", --"rbxassetid://113076933640634",
							ImageColor3 = Color3.fromHex("#F00"),
							Position = UDim2.fromScale(.5, .5),
							AnchorPoint = Vector2.new(.5, .5),
							Size = UDim2.fromScale(1, 1),
							BackgroundTransparency = 1,
							ZIndex = 2,
							
							Colors_Primary = {"ImageColor3"},
							Tags = {"Colors_Primary"}
						})

						local img2 = ui:AddInstance("ImageLabel", {
							Image = "rbxassetid://71605317317599", 
							Position = UDim2.fromScale(.5, .5),
							AnchorPoint = Vector2.new(.5, .5),
							Size = UDim2.fromScale(4, 4),
							BackgroundTransparency = 1
						})

						local bar = ui:AddInstance("TextButton", {
							Id = `Slider_{slider.Label[1]}_Bar`,

							BackgroundColor3 = Color3.fromRGB(255, 0, 0),
							Position = UDim2.fromScale(.5, 1),
							AnchorPoint = Vector2.new(.5, 1),
							Size = UDim2.fromScale(1, 1),
							--BackgroundTransparency = 1, -- Bar edit
							AutoButtonColor = false,
							LayoutOrder = 1,
							Text = "",
							
							Colors_Primary = {"BackgroundColor3"},
							Tags = {"Colors_Primary"}
						})

						local lbl = ui:AddInstance("TextLabel", {
							TextXAlignment = Enum.TextXAlignment.Center,
							Position = UDim2.fromScale(.5, .05),
							Size = UDim2.fromScale(.75, .085),
							AnchorPoint = Vector2.new(.5, 0),
							BackgroundTransparency = 1,
							TextScaled = true,
							Text = "75%",
							ZIndex = 5,

							Tags = {"Colors_Text_Primary", "Fonts_Title"},
							Colors_Text_Primary = {"TextColor3"}
						})

						local setValue = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(percent: number)
							slider.Set(framework.utils.maths.clamp(slider.Min +percent *(slider.Max -slider.Min), slider.Min, slider.Max))
							utils:Vibrate(Enum.HapticEffectType.UIClick)
						end))

						local btn, sld, status
						local updateColor = framework.protected:GCProtect(function(color)
							local props = { ImageColor3 = status and
								color or Color3.fromRGB(
									framework.utils.maths.max(color.R *255*2/5, 0),
									framework.utils.maths.max(color.G *255*2/5, 0),
									framework.utils.maths.max(color.B *255*2/5, 0)
								)
							}

							--img:Tween(tweens.default, props)
							img2:Tween(tweens.default, props)
							props.BackgroundColor3 = props.ImageColor3
							props.ImageColor3 = nil
							
							bar:Tween(tweens.default, props)
						end)
						
						local setEnabled = framework.protected:GCProtect(function(ignore: boolean)
							status = slider.Ena
							
							slider.Ena = not slider.Ena
							if status then sld:Enable() else sld:Disable() end

							if not (ignore == true) then
								if status then
									setValue(sld.percentage)
								else
									slider.Set(slider.Def)
								end
							end

							local succ, err = pcall(Color3.fromHex, framework.settings:GetSetting("Colors_Primary"))
							local color: Color3 = succ and err or Color3.fromHex(framework.settings:GetDefaultSetting("Colors_Primary"))

							updateColor(color)
							utils:AnimateCascade(ui:Get(`SliderToggle_{slider.Label[1]}`).instance, {
								AnimateSelf = true,
								SkipTransparency  = true
							})
						end)

						local setLabel = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(percent: number)
							lbl.instance.Text = `{framework.utils.maths.round(percent*100)}%`
							--[[local anim = utils:GetAnimation(`Slider_{slider.Label[1]}`)
							if not anim then return end

							local total = anim:GetFrameCount()
							local idx = framework.utils.maths.ceil(percent * (total -1))

							anim:SetFrame(idx)]]
							utils:Vibrate(Enum.HapticEffectType.UIHover)
						end))

						btn = ui:AddInstance("TextButton", {
							Id = `SliderToggle_{slider.Label[1]}`,

							Size = UDim2.fromScale(.3, .1),
							Position = UDim2.fromScale(.3, 1.05),
							BackgroundTransparency = 1,
							LayoutOrder = 2,
							ZIndex = 1,
							Text = "",

							MouseButton1Click = setEnabled,
							Colors_Primary = updateColor,
							Tags = {"Colors_Primary"},
							
						}, img2, ui:AddInstance("UICorner", {
							CornerRadius = UDim.new(1, 0)

						}), ui:AddInstance("UIAspectRatioConstraint", {
							AspectRatio = 1
						}))

						framework.utils.tables.insert(frames, ui:AddInstance("Frame", {
							Size = UDim2.fromScale(.17, .6),
							BackgroundTransparency = 1,
							ClipsDescendants = true, -- Bar edit
							LayoutOrder = i

						}, ui:AddInstance("UIListLayout", {
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							VerticalAlignment = Enum.VerticalAlignment.Center,
							VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
							FillDirection = Enum.FillDirection.Vertical,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(.045, 0)

						}), ui:AddInstance("CanvasGroup", {
							--Image = "rbxassetid://97199452213620",
							Id = slider.Id .. "Container",
							Size = UDim2.fromScale(1, .7),
							BackgroundTransparency = 1

						}, ui:AddInstance("UICorner", {
							CornerRadius = UDim.new(.35, 0)

						}), ui:AddInstance("UIAspectRatioConstraint", {
							AspectRatio = .2713

						}),	img, bar, lbl, ui:AddInstance("ImageLabel", {
							Size = UDim2.fromScale(.65, .25),
							Position = UDim2.fromScale(.5, .825),
							AnchorPoint = Vector2.new(.5, .5),
							BackgroundTransparency = 1,
							Image = slider.Icon

						}, ui:AddInstance("UIAspectRatioConstraint", {
							AspectRatio = 1

						}))), btn, ui:AddInstance("TextLabel", {
							Size = UDim2.fromScale(1, .065),
							BackgroundTransparency = 1,
							Text = slider.Label[1],
							TextScaled = true,
							LayoutOrder = 3,

							Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Heading"},
							Colors_Text_Primary = {"TextColor3"},
							Country_Code = slider.Label
						})))

						local start = framework.utils.maths.clamp((slider.Def -slider.Min)/(slider.Max -slider.Min), 0, 1)
						sld = framework.utils.inputs.sliders.vertical({bar}, start, slider.Id)

						setEnabled(true)
						setLabel(start)

						sld.OnPercentageUpdated:Connect(setLabel)
						sld.OnPercentageChanged:Connect(setValue)

						framework.animator.OnAnimationLoaded:Connect(function(anim: {any})
							if framework.utils.strings.sub(anim.id, 1, 7) == "Slider_" then
								--setLabel(sld.percentage)
							end
						end)
					end

					return frames
				end)))
			},
			{ Name = "Executor", Icon = "rbxassetid://133382010896956",
				Content = ui:AddInstance("Frame", {Id = "Executor"},

				ui:AddInstance("Frame", {
					Id = "Editor",

					Position = UDim2.fromScale(.03, .95),
					AnchorPoint = Vector2.new(0, 1),
					Size = UDim2.fromScale(.65, .8),
					BackgroundTransparency = .2,

					Tags = {"Colors_Secondary", "UI_WindowState"},
					Colors_Secondary = {"BackgroundColor3"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.05, 0)

				}), ui:AddInstance("Frame", {
					Size = UDim2.new(1, -padding, .35, 0),
					Position = UDim2.fromScale(0, 1),
					AnchorPoint = Vector2.new(0, 1),
					BackgroundTransparency = 0,
					ZIndex = 95,

					Tags = {"Colors_Secondary", "UI_WindowState"},
					Colors_Secondary = {"BackgroundColor3"}

				}, ui:AddInstance("UICorner", {

					CornerRadius = UDim.new(.15, 0)
				}), ui:AddInstance("UIGradient", {
					Rotation = -90, -- verticale: dall'alto in basso

					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(.65, .1),
						NumberSequenceKeypoint.new(1, 1)
					})

				})), ui:AddInstance("Frame", {
					Position = UDim2.fromScale(.92, .1),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.112, .112),
					BackgroundTransparency = 0,
					ZIndex = 95,

					Tags = {"Colors_Secondary", "UI_WindowState"},
					Colors_Secondary = {"BackgroundColor3"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				}), ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddComponent("CodeEditor", {
					Id = "Main_Editor",

					Position = UDim2.fromScale(0, .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(1, .925),

					Focused = framework.protected:GCProtect(function()
						utils:EditorMode(true, .175)

						framework.utils.inputs.editors:Get("Main_Editor"):ToggleHighlighter(false)
					end),

					FocusLost = framework.protected:GCProtect(function()
						utils:EditorMode(false)

						local editor = framework.utils.inputs.editors:Get("Main_Editor")
						local tabs = framework.dependencies.editortabs

						local tab = tabs:GetSelection()
						if not tab then return end

						tab:SetSource(editor:GetText())
						editor:ToggleHighlighter(true)
					end)

				}), ui:AddInstance("ImageLabel", { -- EDITOR AI BUTTON
					Id = "EditorAIButtonShadow",

					BackgroundColor3 = Color3.fromHex("#000"),
					Image = "rbxassetid://112235731951114",
					Position = UDim2.fromScale(.1, .87),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.8, .8),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("ImageButton", {
					Id = "EditorAIButton",

					Image = "rbxassetid://91074694855691",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.3, .3),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function() -- alura
						if utils.axintDebounce then return end
						utils.axintDebounce = true

						local background = ui:Get("BackgroundGlow")
						utils:ShowToast("InputToast", {
							PlaceholderText = {"Walkspeed script...","Script per correre...","Kịch bản tốc độ chạy...","Script de velocidade de caminhada...","Skrip kecepatan berjalan...","Скрипт скорости ходьбы...","Gehgeschwindigkeits-Skript...","Script de velocidad de caminata...","Script de vitesse de marche...","行走速度脚本...","歩行速度スクリプト...","سكريبت سرعة المشي...","चलने की गति स्क्रिप्ट...","สคริปต์ความเร็วในการเดิน..."},
							AdditionalText = {"Instant code with Arcy","Scripta con Arcy","Mã tức thì với Arcy","Código instantâneo com Arcy","Kode instan dengan Arcy","Мгновенный код с Arcy","Sofortiger Code mit Arcy","Código instantáneo con Arcy","Code instantané avec Arcy","Arcy 的即时代码","Arcy でインスタントコード","كود فوري مع Arcy","Arcy के साथ त्वरित कोड","รหัสทันทีด้วย Arcy"},
							Style = "ai",
							Callback = function(txt: string)
								if framework.utils.strings.gsub(txt, "%s", "") == "" then 
									utils.axintDebounce = false
									return
								end

								local editor = framework.utils.inputs.editors:Get("Main_Editor")
								local tab = editor:AddTab("AI Script", "-- Arcy is reasoning...")

								local axint = framework.dependencies.axintelligence
								local res = axint:Chat(txt)
								local src = ""

								if res then
									if framework.utils.strings.gsub(res.texts[1], "%s", "") ~= "" then
										background:Tween(tweens.default, {
											ImageColor3 = Color3.fromHex("#707070")
										})

										task.delay(3, function()
											background:Tween(tweens.slow_default, {  
												ImageColor3 = Color3.fromHex("#000"),
											})
										end)

										src ..= [=[--[[
		]=] ..res.texts[1].. [=[

]]

]=]
									end

									if #res.codes > 0 then
										src ..= [[-- Generated by Arcy, Arceus Intelligence.
]]
										src ..= res.codes[1]
									else
										src ..= "-- Arcy didn't generate any code..."
									end
								end

								tab:SetSource(src)
								utils.axintDebounce = false
							end
						})
					end)

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR EXECUTE BUTTON
					Id = "EditorSSExecuteButtonShadow",

					BackgroundColor3 = Color3.fromHex("#000"),
					Image = "rbxassetid://111537386489097",
					Position = UDim2.fromScale(.9, .725),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.25, .25),
					BackgroundTransparency = 1,
					Visible = false,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1.117

				}), ui:AddInstance("ImageButton", {
					Id = "EditorSSExecuteButton",

					Image = "rbxassetid://123607114821398",
					ImageColor3 = Color3.fromHex("#58B2FF"),
					Size = UDim2.fromScale(.225, .225),
					Position = UDim2.fromScale(.505, .5),
					AnchorPoint = Vector2.new(.5, .5),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorSSExecuteButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()

						local src = tab and tab:GetSource()
						if not src or src == "" then return end

						local name = tab:GetName()
						utils:ShowToast("ButtonToast", {
							AdditionalText = {`Execute {name} at Server-Side?`,`Esegui {name} sul lato server?`,`Thực thi {name} ở phía máy chủ?`,`Executar {name} no lado do servidor?`,`Eksekusi {name} di sisi server?`,`Выполнить {name} на стороне сервера?`,`{name} auf der Serverseite ausführen?`,`¿Ejecutar {name} en el lado del servidor?`,`Exécuter {name} côté serveur ?`,`在服务器端执行 {name}？`,`サーバー側で {name} を実行しますか？`,`تنفيذ {name} على جانب الخادم؟`,`सर्वर-पक्ष पर {name} निष्पादित करें?`,`ดำเนินการ {name} ที่ฝั่งเซิร์ฟเวอร์หรือไม่?`},
							AdditionalTitle = {"Execute","Esegui","Thực thi","Executar","Eksekusi","Выполнить","Ausführen","Ejecutar","Exécuter","执行","実行","تنفيذ","निष्पादित करें","ดำเนินการ"},
							Style = "confirm",

							Callback = function(res: boolean)
								if not res then return end
								framework.dependencies.serverside:Execute(src)
							end
						})
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}))), ui:AddInstance("ImageLabel", { -- EDITOR EXECUTE BUTTON
					Id = "EditorExecuteButtonShadow",

					BackgroundColor3 = Color3.fromHex("#000"),
					Image = "rbxassetid://111537386489097",
					Position = UDim2.fromScale(.9, .87),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.35, .35),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1.117

				}), ui:AddInstance("ImageButton", {
					Id = "EditorExecuteButton",

					Image = "rbxassetid://100628992603432",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.3, .3),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorExecuteButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()

						local src = tab and tab:GetSource()
						if not src or src == "" then
							-- POPUP EXECUTE CLIPBOARD
							return utils:ShowToast("ButtonToast", {
								AdditionalText = {"Execute clipboard?","Eseguire appunto?","Thực thi khay nhớ tạm?","Executar área de transferência?","Jalankan clipboard?","Выполнить буфер обмена?","Zwischenablage ausführen?","¿Ejecutar portapapeles?","Exécuter le presse-papiers?","执行剪贴板？","クリップボードを実行しますか？","تنفيذ الحافظة؟","क्लिपबोर्ड निष्पादित करें?","เรียกใช้คลิปบอร์ด?"},
								AdditionalTitle = {"Execute","Esegui","Thực thi","Executar","Eksekusi","Выполнить","Ausführen","Ejecutar","Exécuter","执行","実行","تنفيذ","निष्पादित करें","ดำเนินการ"},
								Style = "confirm",

								Callback = function(res: boolean)
									if not res then return end
									framework.execution:Execute(framework.utils.clipboard:Get())
								end
							})
						end

						local name = tab:GetName()
						utils:ShowToast("ButtonToast", {
							AdditionalText = {`Execute {name}?`,`Eseguire {name}?`,`Thực thi {name}?`,`Executar {name}?`,`Jalankan {name}?`,`Выполнить {name}?`,`Ausführen {name}?`,`¿Ejecutar {name}?`,`Exécuter {name}?`,`执行{name}？`,`{name}を実行しますか？`,`تنفيذ {name}؟`,`{name} निष्पादित करें?`,`ดำเนินการ {name}?`},
							AdditionalTitle = {"Execute","Esegui","Thực thi","Executar","Eksekusi","Выполнить","Ausführen","Ejecutar","Exécuter","执行","実行","تنفيذ","निष्पादित करें","ดำเนินการ"},
							Style = "confirm",

							Callback = function(res: boolean)
								if not res then return end
								framework.execution:Execute(src)
							end
						})
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR PASTE BUTTON
					Id = "EditorPasteButtonShadow",

					BackgroundColor3 = Color3.fromHex("#F00"),
					Position = UDim2.fromScale(.815, .87),
					Image = "rbxassetid://96112258106990",
					Size = UDim2.fromScale(.112, .112),
					AnchorPoint = Vector2.new(1, .5),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1.125

				}), ui:AddInstance("ImageButton", {
					Id = "EditorPasteButton",

					Image = "rbxassetid://105828625810947",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.7, .7),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorPasteButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()

						if not tab then return end -- shouldnt happen
						tab:SetSource(framework.utils.clipboard:Get())
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR COPY BUTTON
					Id = "EditorCopyButtonShadow",

					BackgroundColor3 = Color3.fromHex("#F00"),
					Position = UDim2.fromScale(.7, .87),
					Image = "rbxassetid://96112258106990",
					Size = UDim2.fromScale(.112, .112),
					AnchorPoint = Vector2.new(1, .5),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1.125

				}), ui:AddInstance("ImageButton", {
					Id = "EditorCopyButton",

					Image = "rbxassetid://104350786247520",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.7, .7),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorCopyButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()
						if not tab then return end

						framework.utils.clipboard:Set(tab:GetSource())
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR CLEAR BUTTON
					Id = "EditorClearButtonShadow",

					BackgroundColor3 = Color3.fromHex("#F00"),
					Position = UDim2.fromScale(.585, .87),
					Image = "rbxassetid://96112258106990",
					Size = UDim2.fromScale(.112, .112),
					AnchorPoint = Vector2.new(1, .5),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1.125

				}), ui:AddInstance("ImageButton", {
					Id = "EditorClearButton",

					Image = "rbxassetid://140071393343502",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.7, .7),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorClearButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()
						if not tab then return end

						local name = tab:GetName()
						utils:ShowToast("ButtonToast", {
							AdditionalText = {`Clear {name}?`,`Cancellare {name}?`,`Xóa {name}?`,`Limpar {name}?`,`Bersihkan {name}?`,`Очистить {name}?`,`{name} löschen?`,`Borrar {name}?`,`Effacer {name}?`,`清除{name}?`,`{name}をクリアしますか？`,`مسح {name}?`,`{name} साफ़ करें?`,`ล้าง {name}?`},
							AdditionalTitle = {"Clear editor","Pulire editor","Xóa trình soạn thảo","Limpar editor","Bersihkan editor","Очистить редактор","Editor löschen","Limpiar editor","Effacer l'éditeur","清除编辑器","エディタをクリア","مسح المحرر","संपादक साफ़ करें","ล้างตัวแก้ไข"},
							Style = "confirm",

							Callback = function(res: boolean)
								if not res then return end
								tab:SetSource("")
							end
						})
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR SAVE & INFO BUTTON
					Id = "EditorSaveButtonShadow", 

					Image = "rbxassetid://119555396926142",
					BackgroundColor3 = Color3.fromHex("#F00"),
					Position = UDim2.fromScale(.92, .1),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.25, .25),
					BackgroundTransparency = 1,
					ZIndex = 99

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("ImageButton", {
					Id = "EditorSaveButton",

					Image = "rbxassetid://80105268646831",
					Position = UDim2.fromScale(.5, .5),
					Size = UDim2.fromScale(.275, .275),
					AnchorPoint = Vector2.new(.5,.5),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorSaveButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()
						if not tab then return end

						if tab:GetData().isFile then
							return utils:ShowPopup("LocalScriptInfo", tab:GetFile(), {})
						end

						tab:ToFile()
						tabs:GetSaved("tabs") -- Call to scripthub browse
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				}))), ui:AddInstance("ImageLabel", { -- EDITOR CONSOLE BUTTON
					Id = "EditorConsoleButtonShadow", 

					Image = "rbxassetid://119555396926142",
					BackgroundColor3 = Color3.fromHex("#F00"),
					Position = UDim2.fromScale(.92, .25),
					ImageColor3 = Color3.fromHex("#0F0"),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.25, .25),
					BackgroundTransparency = 1,
					ZIndex = 99,

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("ImageButton", {
					Id = "EditorConsoleButton",

					Image = "rbxassetid://116356073714133",
					Position = UDim2.fromScale(.5, .5),
					Size = UDim2.fromScale(.275, .275),
					AnchorPoint = Vector2.new(.5,.5),
					BackgroundTransparency = 1,
					AutoButtonColor = false,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("EditorConsoleButtonShadow").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local stgui = framework.protected:GetService("StarterGui")
						stgui:SetCore("DevConsoleVisible", not stgui:GetCore("DevConsoleVisible"))
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				})))), ui:AddInstance("Frame", { -- EDITOR SIDEBAR
					Id = "EditorSideBar",

					Position = UDim2.fromScale(.97, .95),
					AnchorPoint = Vector2.new(1, 1),
					Size = UDim2.fromScale(.27, .8),
					BackgroundTransparency = .3,

					Tags = {"Colors_Secondary", "UI_WindowState"},
					Colors_Secondary = {"BackgroundColor3"},

				}, ui:AddInstance("TextLabel", {
					Id = "CategoryTitle",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.075,.03),
					Size = UDim2.fromScale(.85, .08),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Files","File","Tệp tin","Arquivos","Berkas","Файлы","Dateien","Archivos","Fichiers","文件","ファイル","ملفات","फ़ाइलें","ไฟล์"},
					Tags = {"Colors_Text_Primary", "Fonts_Title", "Country_Code"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextBox", {
					Id = "TabsSearchBox",

					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromHex("FFF"),
					Position = UDim2.fromScale(.5, .125),
					Size = UDim2.fromScale(.85, .085),
					AnchorPoint = Vector2.new(.5, 0),
					BackgroundTransparency = .8,
					ClearTextOnFocus = false,
					TextScaled = true,
					Text = "",

					Country_Code_Placeholder = {"Search scripts...", "Cerca script...", "Tìm kiếm kịch bản...", "Pesquisar scripts...", "Cari skrip...", "Поиск сценариев...", "Skripte suchen...", "Buscar scripts...", "Rechercher des scripts...", "搜索脚本...", "スクリプトを検索...", "البحث عن السكربتات...", "स्क्रिप्ट खोजें...", "ค้นหาสคริปต์..."},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Colors_Text_Primary = {"TextColor3"},

					FocusLost = framework.protected:GCProtect(function()
						local tabs = framework.dependencies.editortabs
						local query = ui:Get("TabsSearchBox").instance.Text

						local valid = framework.utils.strings.gsub(query, "[%s]+", "") ~= ""
						for _, tab in ipairs(tabs:GetTabs()) do
							local instance = tab:GetData().instance
							local name = tab:GetName()

							instance.instance.Visible = (not valid) or
								(framework.utils.strings.find(name, query) and true or false)
						end

						if valid then
							return tabs:SearchSaved(query, "tabs") -- Call to scriphub search
						end

						return tabs:GetSaved("tabs") -- Call to scripthub browse
					end)

				}, ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.25,0),
					PaddingRight = UDim.new(.05, 0),
					PaddingLeft = UDim.new(.075, 0),
					PaddingTop = UDim.new(.25,0)

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})), ui:AddInstance("TextButton", {
					Id = "NewFileButton",

					BackgroundColor3 = Color3.fromHex("FFF"),
					Position = UDim2.fromScale(.075, .23),
					Size = UDim2.fromScale(.225,.225),
					BackgroundTransparency = .9,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("NewFileButton").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local editor = framework.utils.inputs.editors:Get("Main_Editor")
						local cont = nil

						if utils.tabsMode ~= "files" then
							cont = { [utils.tabsMode] = true }
						end

						editor:AddTab(nil, "", cont)
					end)

				}, ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://112476312219988",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.25, 0)	

				}), ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextButton", {
					Id = "FavouriteButton",

					BackgroundColor3 = Color3.fromHex("FFF"),
					Position = UDim2.fromScale(.5, .23),
					Size = UDim2.fromScale(.225, .225),
					AnchorPoint = Vector2.new(.5,0),
					BackgroundTransparency = .9,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("FavouriteButton").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						local tab = tabs:GetSelection()

						if not tab then return end
						local status = not (tab:GetProperty("favourite") or false)
						tab:SetProperty("favourite", status)

						ui:Get("FavouriteButtonImage").instance.Image = status
							and framework.protected:ProtectAsset("rbxassetid://137934368112423") or "rbxassetid://80350699155696"
					end)

				}, ui:AddInstance("ImageLabel", {
					Id = "FavouriteButtonImage",

					Image = "rbxassetid://80350699155696",
					ImageColor3 = Color3.fromHex("#FDC41B"),
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.25, 0)

				}), ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextButton", {
					Id = "DeleteFileButton",

					BackgroundColor3 = Color3.fromHex("FFF"),
					Position = UDim2.fromScale(.925, .23),
					Size = UDim2.fromScale(.225, .225),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .9,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("DeleteFileButton").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						utils:ShowToast("ButtonToast", {
							AdditionalText = {"Delete selected tab?","Eliminare scheda selezionata?","Xóa tab được chọn?","Excluir guia selecionada?","Hapus tab terpilih?","Удалить выбранную вкладку?","Ausgewählte Registerkarte löschen?","¿Eliminar pestaña seleccionada?","Supprimer l'onglet sélectionné ?","删除所选选项卡？","選択したタブを削除しますか？","حذف علامة التبويب المحددة؟","चयनित टैब हटाएं?","ลบแท็บที่เลือก?"},
							AdditionalTitle = {"Delete","Elimina","Xóa","Excluir","Hapus","Удалить","Löschen","Eliminar","Supprimer","删除","削除","حذف","हटाएं","ลบ"},
							Style = "confirm",

							Callback = function(res: boolean)
								if not res then return end
								local tabs = framework.dependencies.editortabs
								local tab = tabs:GetSelection()
								if tab then tab:Delete(true) end
							end
						})
					end)

				}, ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://80286816747552",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5,.5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.25, 0)	

				}), ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("ScrollingFrame", {
					Id = "TabsList",

					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromHex("#000"),
					Position = UDim2.fromScale(.5, .375),
					CanvasSize = UDim2.fromScale(0, 0),
					AnchorPoint = Vector2.new(.5, 0),
					Size = UDim2.fromScale(.85, .45),
					BackgroundTransparency = 1,
					ScrollBarThickness = 0

				}, ui:AddInstance("UIListLayout", {
					Id = "TabsLayout",
					
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(.025, 0)

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.1, 0)

				})), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.1, 0)

				}), ui:AddInstance("Frame", {
					Id = "CategoryButtons",

					Position = UDim2.fromScale(.5, .955),
					AnchorPoint = Vector2.new(.5, 1),
					Size = UDim2.fromScale(.85, .1),
					BackgroundTransparency = 1,
					ClipsDescendants = true

				}, ui:AddInstance("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 0)

				}), ui:AddComponent("CategoryButton", {
					LongTitle = {"Files","Files","Tệp tin","Arquivos","Berkas","Файлы","Dateien","Archivos","Fichiers","文件","ファイル","ملفات","फ़ाइलें","ไฟล์"},
					Title = {"Files","Files","Tệp","Arq","Ber","Фай","Dat","Arc","Fic","文","ファ","ملف","फ़ा","ไฟ"},
					BackgroundColor3 = Color3.fromHex("#58B2FF"),
					Image = "rbxassetid://93716878735644",
					Selected = true,

					Callback = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("CategoryBtn_Files").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						utils.tabsMode = "files"

						for _, tab in ipairs(tabs:GetTabs()) do
							tab:GetData().instance.instance.Visible = true
						end

						framework.dependencies.editortabs:GetSaved("tabs")
					end)

				}), ui:AddComponent("CategoryButton", {
					LongTitle = {"Favourites","Preferiti","Yêu thích","Favoritos","Favorit","Избранное","Favoriten","Favoritos","Favoris","收藏夹","お気に入り","المفضلة","पसंदीदा","รายการโปรด"},
					Title = {"Favs","Prefs","Yêu","Fav","Fav","Изб","Fav","Fav","Fav","喜好","おき","مفض","पस","โปร"},
					BackgroundColor3 = Color3.fromHex("#FDC41B"),
					Image = "rbxassetid://80350699155696",
					LayoutOrder = 1,

					Callback = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("CategoryBtn_Favs").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						utils.tabsMode = "favourite"

						for _, tab in ipairs(tabs:GetTabs()) do
							local state = tab:GetProperty("favourite") and true or false
							tab:GetData().instance.instance.Visible = state
						end

						framework.dependencies.editortabs:GetSavedByProperties({
							favourite = {true}	
						}, "tabs")
					end)

				}), ui:AddComponent("CategoryButton", {
					LongTitle = {"Auto-Execute","Auto-Esecuzione","Tự động thực thi","Auto-executar","Eksekusi Otomatis","Автовыполнение","Automatische Ausführung","Ejecución automática","Exécution automatique","自动执行","自動実行","التنفيذ التلقائي","स्वचालित निष्पादन","เรียกใช้โดยอัตโนมัติ"},
					Title = {"Auto","Auto","Tự","Aut","Oto","Авт","Auto","Auto","Auto","自","自","تلق","स्व","อัต"},
					BackgroundColor3 = Color3.fromHex("#1EC997"),
					Image = "rbxassetid://100628992603432",
					LayoutOrder = 2,

					Callback = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("CategoryBtn_Auto").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						local tabs = framework.dependencies.editortabs
						utils.tabsMode = "autoexecute"

						for _, tab in ipairs(tabs:GetTabs()) do
							local state = tab:GetProperty("autoexecute") and true or false
							tab:GetData().instance.instance.Visible = state
						end

						framework.dependencies.editortabs:GetSavedByProperties({
							autoexecute = {true}	
						}, "tabs")
					end)
				}))))
			},
			{ Name = "ScriptHub", Icon = "rbxassetid://137348934767807",
				Content = ui:AddInstance("Frame", {Id = "ScriptHub"},

				ui:AddInstance("Frame", {
					Id = "ScriptsSwitch",
					Position = UDim2.fromScale(.08, .065),
					Size = UDim2.fromScale(.22, .085),
					AnchorPoint = Vector2.new(0, .5),
					BackgroundTransparency = .85
					
				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0),
					
				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.05, 0),
					PaddingRight = UDim.new(.1, 0),
					PaddingLeft = UDim.new(.1, 0),
					PaddingTop = UDim.new(.05, 0)
				}), 

				ui:AddInstance("TextButton", {
					Id = "ScriptsSwitchButton",
					
					Size = UDim2.fromScale(1,1),
					BackgroundTransparency = 1,
					TextScaled = true,
					
					Country_Code = {"CloudScripts ☁️","ScriptsCloud ☁️","Kịch bản đám mây ☁️","ScriptsNaNuvem ☁️","Skrip Awan ☁️","Облачные скрипты ☁️","Cloud-Skripte ☁️","ScriptsEnLaNube ☁️","ScriptsCloud ☁️","云端脚本 ☁️","クラウドスクリプト ☁️","السكربتات السحابية ☁️","क्लाउड स्क्रिप्ट्स ☁️","สคริปต์คลาวด์ ☁️"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Colors_Text_Primary = {"TextColor3"},
					
					MouseButton1Click = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						if searchbox.loading then return end
						
						local dropdown = ui:Get("ScriptsSwitchDropdown")
						dropdown.instance.Visible = not dropdown.instance.Visible
					end)
				}, ui:AddInstance("UICorner", { CornerRadius = UDim.new(.5,0) })),

				ui:AddInstance("Frame", {
					Id = "ScriptsSwitchDropdown",
					
					BackgroundColor3 = Color3.fromHex("#000"),
					Position = UDim2.fromScale(0,1),
					BackgroundTransparency = 0.2,
					Size = UDim2.fromScale(1,3),
					Visible = false
					
				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.15,0)
					
				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.05,0),
					PaddingRight = UDim.new(.05,0),
					PaddingLeft = UDim.new(.05,0),
					PaddingTop = UDim.new(.05,0)
					
				}), ui:AddInstance("UIListLayout", {
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0,4)
				}), 

				-- CloudScripts ☁️
				ui:AddInstance("TextButton", {
					Id = "OptionCloudScripts",
					Size = UDim2.fromScale(1, .33),
					BackgroundTransparency = 1,
					TextScaled = true,
					LayoutOrder = 1,
					ZIndex = 11,
					
					Tags = {"Country_Code", "Colors_Text_Primary","Fonts_Body"},
					Country_Code = {"CloudScripts ☁️","ScriptsCloud ☁️","Kịch bản đám mây ☁️","ScriptsNaNuvem ☁️","Skrip Awan ☁️","Облачные скрипты ☁️","Cloud-Skripte ☁️","ScriptsEnLaNube ☁️","ScriptsCloud ☁️","云端脚本 ☁️","クラウドスクリプト ☁️","السكربتات السحابية ☁️","क्लाउड स्क्रिप्ट्स ☁️","สคริปต์คลาวด์ ☁️"},
					Colors_Text_Primary = {"TextColor3"},
					
					MouseButton1Click = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						if searchbox.loading then return end
						
						ui:Get("ScriptsSwitchButton").instance.Text = utils:Translate({"CloudScripts ☁️","ScriptsCloud ☁️","Kịch bản đám mây ☁️","ScriptsNaNuvem ☁️","Skrip Awan ☁️","Облачные скрипты ☁️","Cloud-Skripte ☁️","ScriptsEnLaNube ☁️","ScriptsCloud ☁️","云端脚本 ☁️","クラウドスクリプト ☁️","السكربتات السحابية ☁️","क्लाउड स्क्रिप्ट्स ☁️","สคริปต์คลาวด์ ☁️"})
						ui:Get("ScriptsSwitchDropdown").instance.Visible = false

						local headerText, gridSubtitle = ui:Get("ScriptHubHeader"), ui:Get("GridSubtitle")
						local barFilter, gridFilter = ui:Get("BarFilter"), ui:Get("GridFilter")
						local scriptBloxText, scriptBloxLogo = ui:Get("PoweredByText"), ui:Get("ScriptBloxLogo")
						local newScript, newFolder = ui:Get("NewScriptButton"), ui:Get("NewFolderButton")
						local backPath, nextPath, pathBar = ui:Get("BackPathButton"), ui:Get("NextPathButton"), ui:Get("PathBar")
						local scriptsgrid, scriptslist = ui:Get("ScriptsGrid"), ui:Get("CloudBestScriptsBar")

						headerText.instance.Text = utils:Translate({"Best Scripts","Migliori Scripts","Các kịch bản tốt nhất","Melhores scripts","Skrip Terbaik","Лучшие скрипты","Beste Skripte","Mejores scripts","Meilleurs scripts","最佳脚本","最高のスクリプト","أفضل السكربتات","सर्वश्रेष्ठ स्क्रिप्ट्स","สคริปต์ที่ดีที่สุด"})
						searchbox.mode = "cloudscripts"
						gridSubtitle.instance.Text = utils:Translate({"Explore categories","Esplora categorie","Khám phá các danh mục","Explorar categorias","Jelajahi kategori","Исследуйте категории","Kategorien erkunden","Explorar categorías","Explorer les catégories","浏览类别","カテゴリを探す","استكشف الفئات","श्रेणियों का अन्वेषण करें","สำรวจหมวดหมู่"})
						scriptBloxLogo.instance.Image = framework.protected:ProtectAsset("rbxassetid://96600063364054")
						scriptBloxText.instance.TextColor3 = Color3.fromHex("#8C7DFF")

						searchbox.instance.Visible = true
						--gridText.instance.Visible = true
						barFilter.instance.Visible = true
						gridFilter.instance.Visible = true
						scriptBloxText.instance.Visible = true
						scriptBloxLogo.instance.Visible = true
						newScript.instance.Visible = false
						newFolder.instance.Visible = false
						backPath.instance.Visible = false
						nextPath.instance.Visible = false
						pathBar.instance.Visible = false

						local cloudscripts = framework.dependencies.cloudscripts
						local query = scriptsgrid.lastQuery
						ui:Get("CloudBestScriptsBar"):ClearScripts()
						for _, v in ipairs(ui:Get("ScriptsGrid").instance:GetChildren()) do
							if not v:IsA("UIGridLayout") then v:Destroy() end
						end
						if query then query:Refresh() else cloudscripts:FetchFavourites("grid") end
						query = scriptslist.lastQuery
						if query then query:Refresh() else cloudscripts:FetchTrending("topbar") end
					end)
				}),

				-- ServerSide 🌐
				ui:AddInstance("TextButton", {
					Id = "OptionServerSide",
					Size = UDim2.fromScale(1, .33),
					BackgroundTransparency = 1,
					TextScaled = true,
					LayoutOrder = 2,
					ZIndex = 11,
					
					Tags = {"Country_Code", "Colors_Text_Primary","Fonts_Body"},
					Country_Code = {"Server Side 🌐","Lato Server 🌐","Phía máy chủ 🌐","Lado do Servidor 🌐","Sisi Server 🌐","Серверная сторона 🌐","Serverseitig 🌐","Lado del Servidor 🌐","Côté Serveur 🌐","服务器端 🌐","サーバー側 🌐","جانب الخادم 🌐","सर्वर साइड 🌐","ฝั่งเซิร์ฟเวอร์ 🌐"},
					Colors_Text_Primary = {"TextColor3"},
					
					MouseButton1Click = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						if searchbox.loading then return end
						
						ui:Get("ScriptsSwitchButton").instance.Text = utils:Translate({"Server Side 🌐","Lato Server 🌐","Phía máy chủ 🌐","Lado do Servidor 🌐","Sisi Server 🌐","Серверная сторона 🌐","Serverseitig 🌐","Lado del Servidor 🌐","Côté Serveur 🌐","服务器端 🌐","サーバー側 🌐","جانب الخادم 🌐","सर्वर साइड 🌐","ฝั่งเซิร์ฟเวอร์ 🌐"})
						ui:Get("ScriptsSwitchDropdown").instance.Visible = false

						local headerText, gridSubtitle = ui:Get("ScriptHubHeader"), ui:Get("GridSubtitle")
						local scriptBloxText, scriptBloxLogo = ui:Get("PoweredByText"), ui:Get("ScriptBloxLogo")
						local newScript, newFolder = ui:Get("NewScriptButton"), ui:Get("NewFolderButton")
						local barFilter, gridFilter = ui:Get("BarFilter"), ui:Get("GridFilter")
						local backPath, nextPath, pathBar = ui:Get("BackPathButton"), ui:Get("NextPathButton"), ui:Get("PathBar")

						headerText.instance.Text = utils:Translate({"Server Side","Lato Server","Phía máy chủ","Lado do Servidor","Sisi Server","Серверная сторона","Serverseitig","Lado del Servidor","Côté Serveur","服务器端","サーバー側","جانب الخادم","सर्वर साइड","ฝั่งเซิร์ฟเวอร์"})
						searchbox.mode = "serverside"
						gridSubtitle.instance.Text = utils:Translate({"Explore serversided games","Esplora i giochi lato server","Khám phá các trò chơi phía máy chủ","Explore jogos do lado do servidor","Jelajahi game sisi server","Исследуйте серверные игры","Erkunde serverseitige Spiele","Explora juegos del lado del servidor","Explorez les jeux côté serveur","探索服务器端游戏","サーバー側のゲームを探す","استكشف الألعاب الجانبية للخادم","सर्वर साइड गेम्स का अन्वेषण करें","สำรวจเกมฝั่งเซิร์ฟเวอร์"})
						scriptBloxLogo.instance.Image = framework.protected:ProtectAsset("rbxassetid://96326191043043")
						scriptBloxText.instance.TextColor3 = Color3.fromRGB(220,220,220)

						scriptBloxText.instance.Visible = true
						scriptBloxLogo.instance.Visible = true
						gridFilter.instance.Visible = false
						searchbox.instance.Visible = false
						newScript.instance.Visible = false
						newFolder.instance.Visible = false
						barFilter.instance.Visible = false
						backPath.instance.Visible = false
						nextPath.instance.Visible = false
						pathBar.instance.Visible = false

						framework.dependencies.serverside:GetGames(1)
					end)
				}),

				-- LocalScripts 📂
				ui:AddInstance("TextButton", {
					Id = "OptionLocalScripts",
					Size = UDim2.fromScale(1, .33),
					BackgroundTransparency = 1,
					TextScaled = true,
					LayoutOrder = 3,
					ZIndex = 11,
					
					Tags = {"Country_Code", "Colors_Text_Primary","Fonts_Body"},
					Country_Code = {"LocalScripts 📂","ScriptLocali 📂","Kịch bản cục bộ 📂","ScriptsLocais 📂","Skrip Lokal 📂","Локальные скрипты 📂","Lokale Skripte 📂","ScriptsLocales 📂","ScriptsLocaux 📂","本地脚本 📂","ローカルスクリプト 📂","السكربتات المحلية 📂","स्थानीय स्क्रिप्ट्स 📂","สคริปต์ท้องถิ่น 📂"},
					Colors_Text_Primary = {"TextColor3"},
					
					MouseButton1Click = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						if searchbox.loading then return end
						
						ui:Get("ScriptsSwitchButton").instance.Text = utils:Translate({"LocalScripts 📂","ScriptLocali 📂","Kịch bản cục bộ 📂","ScriptsLocais 📂","Skrip Lokal 📂","Локальные скрипты 📂","Lokale Skripte 📂","ScriptsLocales 📂","ScriptsLocaux 📂","本地脚本 📂","ローカルスクリプト 📂","السكربتات المحلية 📂","स्थानीय स्क्रिप्ट्स 📂","สคริปต์ท้องถิ่น 📂"})
						ui:Get("ScriptsSwitchDropdown").instance.Visible = false

						local headerText, gridSubtitle = ui:Get("ScriptHubHeader"), ui:Get("GridSubtitle")
						local barFilter, gridFilter = ui:Get("BarFilter"), ui:Get("GridFilter")
						local scriptBloxText, scriptBloxLogo = ui:Get("PoweredByText"), ui:Get("ScriptBloxLogo")
						local newScript, newFolder = ui:Get("NewScriptButton"), ui:Get("NewFolderButton")
						local backPath, nextPath, pathBar = ui:Get("BackPathButton"), ui:Get("NextPathButton"), ui:Get("PathBar")

						headerText.instance.Text = utils:Translate({"Favourite Scripts","Script Preferiti","Các kịch bản yêu thích","Scripts favoritos","Skrip Favorit","Любимые скрипты","Lieblingsskripte","Scripts favoritos","Scripts favoris","最喜欢的脚本","お気に入りのスクリプト","السكربتات المفضلة","पसंदीदा स्क्रिप्ट्स","สคริปต์ที่ชื่นชอบ"})
						searchbox.mode = "scripthub"
						gridSubtitle.instance.Text = utils:Translate({"Explore your saved scripts","Esplora i tuoi script salvati","Khám phá các kịch bản đã lưu của bạn","Explore seus scripts salvos","Jelajahi skrip yang Anda simpan","Исследуйте свои сохраненные скрипты","Erkunde deine gespeicherten Skripte","Explora tus scripts guardados","Explorez vos scripts enregistrés","浏览您保存的脚本","保存したスクリプトを探す","استكشف السكربتات المحفوظة الخاصة بك","अपने सहेजे गए स्क्रिप्ट्स का अन्वेषण करें","สำรวจสคริปต์ที่คุณบันทึกไว้"})

						barFilter.instance.Visible = false
						gridFilter.instance.Visible = false
						scriptBloxText.instance.Visible = false
						scriptBloxLogo.instance.Visible = false
						newScript.instance.Visible = true
						newFolder.instance.Visible = true
						backPath.instance.Visible = true
						nextPath.instance.Visible = true
						pathBar.instance.Visible = true

						framework.dependencies.scripthub:Browse(nil, true, "scripthub")
					end)
				}))), ui:AddInstance("ScrollingFrame", {
					Id = "ScriptHubScroll",

					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					Position = UDim2.fromScale(0, .14),
					CanvasSize = UDim2.fromScale(0, 1.2),
					Size = UDim2.fromScale(1, .835),
					ScrollBarThickness = padding/3,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					BorderSizePixel = 0,
					ZIndex = -1,

					Colors_Primary = {"ScrollBarImageColor3"},
					Tags = {"Colors_Primary"}

				}, 	
				--ui:AddInstance("UIListLayout", {
				--	Id = "ScriptHubLayout",

				--	HorizontalAlignment = Enum.HorizontalAlignment.Center,
				--	VerticalAlignment = Enum.VerticalAlignment.Top,
				--	FillDirection = Enum.FillDirection.Vertical,
				--	SortOrder = Enum.SortOrder.LayoutOrder,
				--	Padding = UDim.new(0, 0)
				--	}), 
				ui:AddInstance("Frame", {
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1

				}, ui:AddInstance("UIPadding",{
					PaddingBottom = UDim.new(.15, 0),
					PaddingRight = UDim.new(.03, 0),
					PaddingLeft = UDim.new(.03, 0),
					PaddingTop = UDim.new(0, 0)

				}), ui:AddInstance("TextLabel", {
					Id = "ScriptHubHeader",
					
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, .05),
					Size = UDim2.fromScale(.3, .08),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black"},
					Country_Code = {"Best Scripts","Migliori Scripts","Các kịch bản tốt nhất","Melhores scripts","Skrip Terbaik","Лучшие скрипты","Beste Skripte","Mejores scripts","Meilleurs scripts","最佳脚本","最高のスクリプト","أفضل السكربتات","सर्वश्रेष्ठ स्क्रिप्ट्स","สคริปต์ที่ดีที่สุด"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, 0),
					Size = UDim2.fromScale(.3, .045),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Country_Code = {"Let's explore","Esploriamo","Hãy khám phá","Vamos explorar","Mari jelajahi","Давайте исследовать","Lass uns erkunden","Vamos explorar","Explorons","让我们探索","探検しましょう","دعونا نستكشف","चलो अन्वेषण करें","มาสำรวจกัน"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddComponent("FilterSelector", {
					Id = "BarFilter",

					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					Position = UDim2.fromScale(0, .15),
					Size = UDim2.fromScale(.5, .1),

					Filters = {
						{
							Title = {"Popular","Popolari","Phổ biến","Populares","Populer","Популярные","Beliebt","Populares","Populaire","流行","人気","شائع","लोकप्रिय","ที่นิยม"},
							Callback = framework.protected:GCProtect(function()
								local scriptslist, searchbox = ui:Get("CloudBestScriptsBar"), ui:Get("CloudSearchBox")
								local cloudscripts = framework.dependencies.cloudscripts

								searchbox.mode = "cloudscripts"
								local query = cloudscripts.newQuery(searchbox.instance.Text, {
									verify = framework.enums.ScriptBloxVerify.Verified,
									patch = framework.enums.ScriptBloxPatch.Unpatched,
									search = framework.enums.ScriptBloxSearch.None,
									sortBy = framework.enums.ScriptBloxSort.Views,
									order = framework.enums.ScriptBloxOrder.Desc,
									type = framework.enums.ScriptBloxType.None,
									auth = framework.enums.ScriptBloxAuth.None,
									mode = framework.enums.ScriptBloxMode.Free
								}, "topbar")

								scriptslist.lastQuery = query
								query:Fetch()
							end)
						},
						{
							Title = {"Newest","Nuovi","Mới nhất","Mais recentes","Terbaru","Новейшие","Neueste","Más recientes","Plus récents","最新","最新","الأحدث","नवीनतम","ใหม่ล่าสุด"},
							Callback = framework.protected:GCProtect(function()
								local scriptslist, searchbox = ui:Get("CloudBestScriptsBar"), ui:Get("CloudSearchBox") 
								local cloudscripts = framework.dependencies.cloudscripts

								searchbox.mode = "cloudscripts"
								local query = cloudscripts.newQuery(searchbox.instance.Text, {
									verify = framework.enums.ScriptBloxVerify.Verified,
									patch = framework.enums.ScriptBloxPatch.Unpatched,
									sortBy = framework.enums.ScriptBloxSort.CreatedAt,
									search = framework.enums.ScriptBloxSearch.None,
									order = framework.enums.ScriptBloxOrder.Desc,
									type = framework.enums.ScriptBloxType.None,
									auth = framework.enums.ScriptBloxAuth.None,
									mode = framework.enums.ScriptBloxMode.Free
								}, "topbar")

								scriptslist.lastQuery = query
								query:Fetch()
							end)
						},
						{
							Title = {"Trending","Evidenza","Xu hướng","Tendências","Sedang Tren","Популярное","Trend","Tendencias","Tendance","流行","トレンド","شائع","रुझान","แนวโน้ม"},
							Callback = framework.protected:GCProtect(function()
								local scriptslist, searchbox = ui:Get("CloudBestScriptsBar"), ui:Get("CloudSearchBox") 
								local cloudscripts = framework.dependencies.cloudscripts

								searchbox.mode = "cloudscripts"
								scriptslist.lastQuery = nil
								cloudscripts:FetchTrending("topbar")
							end)
						}
					}

				}), ui:AddInstance("ImageLabel", {
					Id = "ScriptBloxLogo",

					Image = "rbxassetid://96600063364054",
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.fromScale(.15, .15),
					AnchorPoint = Vector2.new(1, 0),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 2.098

				})), ui:AddInstance("TextLabel", {
					Id = "PoweredByText",

					TextYAlignment = Enum.TextYAlignment.Center,
					TextXAlignment = Enum.TextXAlignment.Right,
					TextColor3 = Color3.fromHex("#8C7DFF"),
					Position = UDim2.fromScale(.85, .075),
					AnchorPoint = Vector2.new(1, .5),
					Size = UDim2.fromScale(.13, .1),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Powered by:", "Fornito da:", "Cung cấp bởi:", "Desenvolvido por:", "Didukung oleh:", "Работает на:", "Bereitgestellt von:", "Desarrollado por:", "Propulsé par:", "提供支持：", "提供：", "بدعم من:", "के द्वारा संचालित:", "ขับเคลื่อนโดย:"},
					Tags = {"Country_Code", "Fonts_Heading"}

				}), ui:AddInstance("Frame", 
					{
						AutomaticSize = Enum.AutomaticSize.X,
						Position = UDim2.fromScale(1, .025),
						Size = UDim2.fromScale(0.5, .11),
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						
					}, ui:AddInstance("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
						VerticalFlex = Enum.UIFlexAlignment.Fill

					}), ui:AddInstance("TextButton", {
					Id = "NewScriptButton",

					BackgroundColor3 = Color3.fromHex("#2B5780"),
					AutomaticSize = Enum.AutomaticSize.X,
					Position = UDim2.fromScale(1, .025),
					Size = UDim2.fromScale(0, .11),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .5,
					Visible = false,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("NewScriptButton").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						utils:ShowToast("InputToast", {
							PlaceholderText = {"Script name","Nome script","Tên kịch bản","Nome do script","Nama skrip","Имя скрипта","Skriptname","Nombre del script","Nom du script","脚本名称","スクリプト名","اسم البرنامج النصي","स्क्रिप्ट का नाम","ชื่อสคริปต์"},
							AdditionalText = {"Create script","Creazione script","Tạo kịch bản","Criar script","Buat skrip","Создать сценарий","Skript erstellen","Crear script","Créer un script","创建脚本","スクリプトを作成","إنشاء نص","स्क्रिप्ट बनाएं","สร้างสคริปต์"},

							Callback = function(res: any)
								res = framework.utils.strings.gsub(res or "", ".lua", "")
								res = framework.utils.strings.gsub(res or "", "[./]", "")
								if res == "" then return end

								local scripthub = framework.dependencies.scripthub
								scripthub:NewFile(res, "", nil, nil, nil, nil, true)
								scripthub:Browse(nil, true, "scripthub")
							end
						})
					end)

				}, ui:AddInstance("UIPadding", {
					PaddingLeft = UDim.new(.075, 0)

				}), ui:AddInstance("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly

				}), ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://112476312219988",
					Position = UDim2.fromScale(.1, .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextLabel", {
					Position = UDim2.fromScale(.625, .5),
					AutomaticSize = Enum.AutomaticSize.X,
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(0, .55),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Country_Code = {"New script", "Nuovo script", "Kịch bản mới", "Novo script", "Skrip baru", "Новый сценарий", "Neues Skript", "Nuevo script", "Nouveau script", "新脚本", "新しいスクリプト", "نص جديد", "नया स्क्रिप्ट", "สคริปต์ใหม่"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})), ui:AddInstance("TextButton", {
					Id = "NewFolderButton",

					BackgroundColor3 = Color3.fromHex("#FDC41B"),
					Position = UDim2.fromScale(.71, .025),
					AutomaticSize = Enum.AutomaticSize.X,
					Size = UDim2.fromScale(0, .11),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .6,
					Visible = false,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:AnimateCascade(ui:Get("NewFolderButton").instance, {
							AnimateSelf = true,
							SkipTransparency  = true
						})

						utils:ShowToast("InputToast", {
							PlaceholderText = {"Folder name","Nome cartella","Tên thư mục","Nome da pasta","Nama folder","Имя папки","Ordnername","Nombre de carpeta","Nom du dossier","文件夹名称","フォルダー名","اسم المجلد","फ़ोल्डर का नाम","ชื่อโฟลเดอร์"},
							AdditionalText = {"Create Folder","Creazione Cartella","Tạo thư mục","Criar pasta","Buat folder","Создать папку","Ordner erstellen","Crear carpeta","Créer un dossier","创建文件夹","フォルダーを作成","إنشاء مجلد","फ़ोल्डर बनाएँ","สร้างโฟลเดอร์"},

							Callback = function(res: any)
								res = framework.utils.strings.gsub(res or "", "[./]", "")
								if res == "" then return end

								local scripthub = framework.dependencies.scripthub
								scripthub:NewFolder(res, nil, true)
								scripthub:Browse(nil, true, "scripthub")
							end
						})
					end)

				}, ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://112476312219988",
					Position = UDim2.fromScale(.1, .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextLabel", {
					Position = UDim2.fromScale(.625, .5),
					AutomaticSize = Enum.AutomaticSize.X,
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(0, .55),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Country_Code = {"New folder","Nuova cartella","Thư mục mới","Nova pasta","Folder baru","Новая папка","Neuer Ordner","Nueva carpeta","Nouveau dossier","新建文件夹","新しいフォルダー","مجلد جديد","नया फ़ोल्डर","โฟลเดอร์ใหม่"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				}), ui:AddInstance("UIPadding", {
					PaddingLeft = UDim.new(.075, 0)

				}), ui:AddInstance("UIListLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly

				}))), ui:AddInstance("TextBox", {
					Id = "CloudSearchBox",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(1, .175),
					Size = UDim2.fromScale(.25, .095),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .5,
					ClearTextOnFocus = false,
					TextScaled = true,
					Text = "",

					FocusLost = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						local keywords = searchbox.instance.Text

						if utils.cloudKeyword == keywords then return end
						utils.cloudKeyword = keywords

						--searchbox.mode = "scripthub"
						if searchbox.mode == "scripthub" then
							local scripthub = framework.dependencies.scripthub
							return scripthub:Search(keywords, nil, "scripthub")
						end

						local scriptsgrid, scriptslist = ui:Get("ScriptsGrid"), ui:Get("CloudBestScriptsBar")
						local cloudscripts = framework.dependencies.cloudscripts

						local query = scriptsgrid.lastQuery
						if query then
							query = cloudscripts.newQuery(keywords, query:GetFilters(), "grid")
							scriptsgrid.lastQuery = query
							query:Fetch()
						end

						query = scriptslist.lastQuery
						if query then
							query = cloudscripts.newQuery(keywords, query:GetFilters(), "topbar")
							scriptslist.lastQuery = query
							query:Fetch()
						end
					end),

					Tags = {"Country_Code", "Colors_Secondary", "Colors_Text_Primary", "Fonts_Heading"},
					Country_Code_Placeholder = {"Search...", "Cerca...", "Tìm kiếm...", "Pesquisar...", "Cari...", "Поиск...", "Suchen...", "Buscar...", "Rechercher...", "搜索...", "検索...", "بحث...", "खोजें...", "ค้นหา..."},
					Colors_Secondary = {"BackgroundColor3"},
					Colors_Text_Primary = {"TextColor3"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.25,0),
					PaddingRight = UDim.new(.05, 0),
					PaddingLeft = UDim.new(.075, 0),
					PaddingTop = UDim.new(.25, 0)

				})), ui:AddComponent("ContentBar", {
					Id = "CloudBestScriptsBar",

					Position = UDim2.fromScale(.5, .3),
					AnchorPoint = Vector2.new(.5, 0),
					Size = UDim2.fromScale(.85, .5),

					OnLoad = framework.protected:GCProtect(function()
						local searchbox = ui:Get("CloudSearchBox")
						if searchbox.mode == "scripthub" or searchbox.loading then return end

						local scriptslist = ui:Get("CloudBestScriptsBar")
						local query = scriptslist.lastQuery
						if query then query:Fetch() end
					end)

				}), ui:AddInstance("TextLabel", {
					Id = "GridFilterText",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, .9),
					Size = UDim2.fromScale(.3, .08),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Colors_Text_Primary", "Fonts_Black"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "GridSubtitle",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, .85),
					Size = UDim2.fromScale(.3, .045),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Country_Code = {"Explore categories","Esplora categorie","Khám phá danh mục","Explorar categorias","Jelajahi kategori","Изучить категории","Kategorien erkunden","Explorar categorías","Explorer les catégories","探索类别","カテゴリを探索","استكشاف الفئات","श्रेणियों का अन्वेषण करें","สำรวจหมวดหมู่"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddComponent("FilterSelector", {
					Id = "GridFilter",

					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Position = UDim2.fromScale(1, .89),
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.fromScale(.5, .1),

					Filters = {
						{
							Title = {"All","Tutti","Tất cả","Todos","Semua","Все","Alle","Todos","Tous","全部","すべて","الكل","सभी","ทั้งหมด"},
							Callback = framework.protected:GCProtect(function(filter: string)
								local scriptsgrid, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudSearchBox")
								local cloudscripts = framework.dependencies.cloudscripts
								ui:Get("GridFilterText").instance.Text = filter

								searchbox.mode = "cloudscripts"
								local query = cloudscripts.newQuery(searchbox.instance.Text, {
									patch = framework.enums.ScriptBloxPatch.Unpatched,
									search = framework.enums.ScriptBloxSearch.None,
									verify = framework.enums.ScriptBloxVerify.None,
									sortBy = framework.enums.ScriptBloxSort.Views,
									order = framework.enums.ScriptBloxOrder.None,
									type = framework.enums.ScriptBloxType.None,
									auth = framework.enums.ScriptBloxAuth.None,
									mode = framework.enums.ScriptBloxMode.None
								}, "grid")

								scriptsgrid.lastQuery = query
								query:Fetch()
							end)
						},
						{
							Title = {"Verified","Verificati","Đã xác minh","Verificado","Terverifikasi","Проверено","Verifiziert","Verificado","Vérifié","已验证","確認済み","تم التحقق","सत्यापित","ได้รับการยืนยัน"},
							Callback = framework.protected:GCProtect(function(filter: string)
								local scriptsgrid, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudSearchBox")
								local cloudscripts = framework.dependencies.cloudscripts
								ui:Get("GridFilterText").instance.Text = filter

								searchbox.mode = "cloudscripts"
								local query = cloudscripts.newQuery(searchbox.instance.Text, {
									verify = framework.enums.ScriptBloxVerify.Verified,
									patch = framework.enums.ScriptBloxPatch.Unpatched,
									search = framework.enums.ScriptBloxSearch.None,
									sortBy = framework.enums.ScriptBloxSort.Views,
									order = framework.enums.ScriptBloxOrder.None,
									type = framework.enums.ScriptBloxType.None,
									auth = framework.enums.ScriptBloxAuth.None,
									mode = framework.enums.ScriptBloxMode.None
								}, "grid")

								scriptsgrid.lastQuery = query
								query:Fetch()
							end)
						},
						{
							Title = {"Suggested","Consigliati","Được đề xuất","Sugeridos","Disarankan","Рекомендуемые","Vorgeschlagen","Sugeridos","Suggérés","推荐","おすすめ","مقترح","अनुशंसित","แนะนำ"},
							Callback = framework.protected:GCProtect(function(filter: string)
								local scriptsgrid, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudSearchBox")
								local cloudscripts = framework.dependencies.cloudscripts
								ui:Get("GridFilterText").instance.Text = filter

								searchbox.mode = "cloudscripts"
								local query = cloudscripts.newQuery(searchbox.instance.Text, {
									verify = framework.enums.ScriptBloxVerify.Verified,
									patch = framework.enums.ScriptBloxPatch.Unpatched,
									search = framework.enums.ScriptBloxSearch.None,
									type = framework.enums.ScriptBloxType.Specific,
									sortBy = framework.enums.ScriptBloxSort.Views,
									order = framework.enums.ScriptBloxOrder.None,
									auth = framework.enums.ScriptBloxAuth.None,
									mode = framework.enums.ScriptBloxMode.None
								}, "grid")

								scriptsgrid.lastQuery = query
								query:Fetch()
							end)
						},
						{
							Title = {"Favourites","Preferiti","Yêu thích","Favoritos","Favorit","Избранное","Favoriten","Favoritos","Favoris","收藏夹","お気に入り","المفضلة","पसंदीदा","รายการโปรด"},
							Callback = framework.protected:GCProtect(function(filter: string)
								local scriptsgrid, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudSearchBox")
								local cloudscripts = framework.dependencies.cloudscripts
								ui:Get("GridFilterText").instance.Text = filter

								searchbox.mode = "cloudscripts"
								scriptsgrid.lastQuery = nil
								cloudscripts:FetchFavourites("grid")
							end)
						}
					}

				}), ui:AddInstance("TextButton", {
					Id = "BackPathButton",

					Position = UDim2.fromScale(0, .9),
					Size = UDim2.fromScale(.065, .1),
					BackgroundTransparency = 1,
					TextScaled = true,
					Visible = false,
					Text = "‹",

					Tags = {"Colors_Text_Primary", "Fonts_Title"},
					Colors_Text_Primary = {"TextColor3"},

					MouseButton1Click = framework.protected:GCProtect(function()
						framework.dependencies.scripthub:BrowsePrevious("scripthub")
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1,

				})), ui:AddInstance("TextButton", {
					Id = "NextPathButton",

					Position = UDim2.fromScale(.05, .9),
					Size = UDim2.fromScale(.065, .1),
					BackgroundTransparency = 1,
					TextScaled = true,
					Visible = false,
					Text = "›",

					Tags = {"Colors_Text_Primary", "Fonts_Title"},
					Colors_Text_Primary = {"TextColor3"},

					MouseButton1Click = framework.protected:GCProtect(function()
						framework.dependencies.scripthub:BrowseNext("scripthub")
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1,

				})), ui:AddComponent("HistorySelector", {
					Id = "PathBar",

					Position = UDim2.fromScale(1, .89),
					Size = UDim2.fromScale(.8, .115),
					AnchorPoint = Vector2.new(1, 0),
					Visible = false,
					Padding = 6

				})), ui:AddInstance("Frame", {
					Id = "ScriptsGrid",

					Position = UDim2.fromScale(0, .88),
					AutomaticSize = Enum.AutomaticSize.Y,
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ClipsDescendants = false,
					LayoutOrder = 1

				}, ui:AddInstance("UIGridLayout", {
					Id = "ScriptsGridLayout",

					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					CellPadding = UDim2.fromOffset(padding*3, padding*3), -- UDim2.fromScale(.02, 0),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					CellSize = UDim2.fromScale(.3, 0) -- .3
				}))))
			},
			{ Name = "ArceusIntelligence", Icon = "rbxassetid://95922875106065",
				Content = ui:AddInstance("Frame", {},

				ui:AddInstance("ImageLabel", {
					Id = "AITipsPanelBackground",

					Position = UDim2.fromScale(.03, .15),
					Size = UDim2.fromScale(.55, .58),
					BackgroundTransparency = 1,

					Colors_Secondary = {"BackgroundColor3"},
					Tags = {"Colors_Secondary"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.1, 0)

				}), ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://105134483657581", -- AI Shadow
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5),
					Size = UDim2.fromScale(1.35,1.4),
					BackgroundTransparency = 1,
					ZIndex = -1
				}), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Right,
					TextYAlignment = Enum.TextYAlignment.Top,
					Position = UDim2.fromScale(.95, .035),
					Size = UDim2.fromScale(.45, .055),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					TextScaled = true,
					ZIndex = 3,

					Country_Code = {"Arceus Intelligence"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Caption"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "AITipsSubtitle",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.05, .09),
					Size = UDim2.fromScale(.9, .065),
					BackgroundTransparency = 1,
					TextTransparency = .5,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Heading"},
					Country_Code = {"ARCY TIPS","SUGGERIMENTI ARCY","MẸO ARCY","DICAS ARCY","TIP ARCY","СОВЕТЫ ARCY","ARCY-TIPPS","CONSEJOS ARCY","ASTUCES ARCY","ARCY 提示","ARCY のヒント","نصائح ARCY","ARCY युक्तियाँ","เคล็ดลับ ARCY"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "AITipsTitle",

					Position = UDim2.fromScale(.05, .165),
					Size = UDim2.fromScale(.9, .09),
					BackgroundTransparency = 1,
					TextScaled = true,
					TextXAlignment = Enum.TextXAlignment.Left,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Country_Code = {"Change your language","Cambia lingua","Thay đổi ngôn ngữ","Mudar seu idioma","Ubah bahasa Anda","Изменить язык","Sprache ändern","Cambiar idioma","Changer de langue","更改语言","言語を変更する","غير لغتك","अपनी भाषा बदलें","เปลี่ยนภาษาของคุณ"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "AITipsText",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.05, .275),
					Size = UDim2.fromScale(.9, .4),
					BackgroundTransparency = 1,
					TextTransparency = .35,
					TextScaled = true,

					Country_Code = {"Arceus Intelligence allows you to translate your interface instantly using AI, ensuring a seamless experience in any language! 🌍✨","Arceus Intelligence ti permette di tradurre immediatamente la tua interfaccia utilizzando l'IA, garantendo un'esperienza fluida in qualsiasi lingua! 🌍✨","Arceus Intelligence cho phép bạn dịch giao diện ngay lập tức bằng AI, đảm bảo trải nghiệm mượt mà trong bất kỳ ngôn ngữ nào! 🌍✨","O Arceus Intelligence permite que você traduza sua interface instantaneamente usando IA, garantindo uma experiência perfeita em qualquer idioma! 🌍✨","Arceus Intelligence memungkinkan Anda menerjemahkan antarmuka secara instan menggunakan AI, memastikan pengalaman yang mulus dalam bahasa apa pun! 🌍✨","Arceus Intelligence позволяет мгновенно переводить интерфейс с помощью ИИ, обеспечивая бесшовный опыт на любом языке! 🌍✨","Arceus Intelligence ermöglicht es Ihnen, Ihre Oberfläche mit KI sofort zu übersetzen und so ein nahtloses Erlebnis in jeder Sprache zu gewährleisten! 🌍✨","Arceus Intelligence te permite traducir tu interfaz al instante usando IA, ¡asegurando una experiencia fluida en cualquier idioma! 🌍✨","Arceus Intelligence vous permet de traduire instantanément votre interface grâce à l'IA, garantissant une expérience fluide dans n'importe quelle langue ! 🌍✨","Arceus Intelligence 让您能够使用 AI 即时翻译界面，确保在任何语言下都能获得无缝体验！🌍✨","Arceus Intelligence を使えば、AI でインターフェースを瞬時に翻訳でき、どの言語でもシームレスな体験が可能になります！🌍✨","تتيح لك Arceus Intelligence ترجمة واجهتك على الفور باستخدام الذكاء الاصطناعي، مما يضمن تجربة سلسة بأي لغة! 🌍✨","Arceus Intelligence आपको AI का उपयोग करके तुरंत आपका इंटरफ़ेस अनुवादित करने की अनुमति देता है, किसी भी भाषा में सहज अनुभव सुनिश्चित करता है! 🌍✨","Arceus Intelligence ช่วยให้คุณแปลอินเทอร์เฟซของคุณได้ทันทีด้วย AI เพื่อให้แน่ใจว่าคุณจะได้รับประสบการณ์ที่ราบรื่นในทุกภาษา! 🌍✨"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("ScrollingFrame", {
					Id = "LanguagePicker",

					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromHex("#000"),
					Position = UDim2.fromScale(.05, .275),
					CanvasSize = UDim2.fromScale(0, 1),
					ScrollBarThickness = padding/3,
					Size = UDim2.fromScale(.9, .4),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 10

				}, ui:AddInstance("UIGridLayout", {
					CellPadding = UDim2.new(0, padding, 0, padding * 1.5),
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					CellSize = UDim2.new(.475, 0, .3, 0),
					FillDirectionMaxCells = 2

				}), framework.protected:GCProtect(function()
					local langs = {
						{ Code = "EN", Gradient = { "#00247D", "#FFFFFF", "#CF142B" }, Label = {
							"English","Inglese","Tiếng Anh","Inglês","Inggris","Английский",
							"Englisch","Inglés","Anglais","英语","英語","الإنجليزية",
							"अंग्रेज़ी","อังกฤษ"
						} },
						{ Code = "IT", Gradient = { "#008C45", "#F4F5F0", "#CD212A" }, Label = {
							"Italian","Italiano","Tiếng Ý","Italiano","Bahasa Italia",
							"Итальянский","Italienisch","Italiano","Italien","意大利语",
							"イタリア語","الإيطالية","इतालवी","ภาษาอิตาลี"
						} },
						{ Code = "VI", Gradient = { "#DA251D", "#FFCD00", "#DA251D" }, Label = {
							"Vietnamese","Vietnamita","Tiếng Việt","Vietnamita","Bahasa Vietnam",
							"Вьетнамский","Vietnamesisch","Vietnamita","Vietnamien","越南语",
							"ベトナム語","الفيتنامية","वियतनामी","ภาษาเวียดนาม"
						} },
						{ Code = "PT", Gradient = { "#006600", "#FF0000", "#FFCC00" }, Label = {
							"Portuguese","Portoghese","Tiếng Bồ Đào Nha","Português","Bahasa Portugis",
							"Португальский","Portugiesisch","Portugués","Portugais","葡萄牙语",
							"ポルトガル語","البرتغالية","पुर्तगाली","ภาษาโปรตุเกส"
						} },
						{ Code = "ID", Gradient = { "#FF0000", "#FFFFFF", "#FF0000" }, Label = {
							"Indonesian","Indonesiano","Tiếng Indonesia","Indonésio","Bahasa Indonesia",
							"Индонезийский","Indonesisch","Indonesio","Indonésien","印度尼西亚语",
							"インドネシア語","الإندونيسية","इंडोनेशियाई","ภาษาอินโดนีเซีย"
						} },
						{ Code = "RU", Gradient = { "#FFFFFF", "#0033A0", "#D52B1E" }, Label = {
							"Russian","Russo","Tiếng Nga","Russo","Bahasa Rusia","Русский",
							"Russisch","Ruso","Russe","俄语","ロシア語","الروسية","रूसी","ภาษารัสเซีย"
						} },
						{ Code = "DE", Gradient = { "#000000", "#DD0000", "#FFCE00" }, Label = {
							"German","Tedesco","Tiếng Đức","Alemão","Bahasa Jerman","Немецкий",
							"Deutsch","Alemán","Allemand","德语","ドイツ語","الألمانية","जर्मन","ภาษาเยอรมัน"
						} },
						{ Code = "ES", Gradient = { "#AA151B", "#F1BF00", "#AA151B" }, Label = {
							"Spanish","Spagnolo","Tiếng Tây Ban Nha","Espanhol","Bahasa Spanyol",
							"Испанский","Spanisch","Español","Espagnol","西班牙语","スペイン語","الإسبانية",
							"स्पेनिश","ภาษาสเปน"
						} },
						{ Code = "FR", Gradient = { "#0055A4", "#FFFFFF", "#EF4135" }, Label = {
							"French","Francese","Tiếng Pháp","Francês","Bahasa Prancis","Французский",
							"Französisch","Francés","Français","法语","フランス語","الفرنسية","फ्रांसीसी","ภาษาฝรั่งเศส"
						} },
						{ Code = "ZH", Gradient = { "#DE2910", "#FFDE00", "#DE2910" }, Label = {
							"Chinese","Cinese","Tiếng Trung","Chinês","Bahasa Mandarin","Китайский",
							"Chinesisch","Chino","Chinois","中文","中国語","الصينية","चीनी","ภาษาจีน"
						} },
						{ Code = "JA", Gradient = { "#FFFFFF", "#BC002D", "#FFFFFF" }, Label = {
							"Japanese","Giapponese","Tiếng Nhật","Japonês","Bahasa Jepang","Японский",
							"Japanisch","Japonés","Japonais","日语","日本語","اليابانية","जापानी","ภาษาญี่ปุ่น"
						} },
						{ Code = "AR", Gradient = { "#007A3D", "#FFFFFF", "#CE1126" }, Label = {
							"Arabic","Arabo","Tiếng Ả Rập","Árabe","Bahasa Arab","Арабский",
							"Arabisch","Árabe","Arabe","阿拉伯语","アラビア語","العربية","अरबी","ภาษาอาหรับ"
						} },
						{ Code = "HI", Gradient = { "#FF9933", "#FFFFFF", "#138808" }, Label = {
							"Hindi","Hindi","Tiếng Hin-đi","Hindi","Bahasa Hindi","Хинди",
							"Hindi","Hindi","Hindi","印地语","ヒンディー語","الهندية","हिन्दी","ภาษาฮินดี"
						} },
						{ Code = "TH", Gradient = { "#A51931", "#FFFFFF", "#2D2A4A" }, Label = {
							"Thai","Thailandese","Tiếng Thái","Tailandês","Bahasa Thailand","Тайский",
							"Thailändisch","Tailandés","Thaï","泰语","タイ語","التايلاندية","थाई","ไทย"
						} },
					}

					local btns = {}
					for _, info in ipairs(langs) do
						local gradientColors = info.Gradient or { "#AAAAAA", "#888888", "#666666" }

						framework.utils.tables.insert(btns, ui:AddInstance("TextButton", {
							Id = `LangBtn_{info.Code}`,

							Size = UDim2.fromScale(.4, .07),
							BackgroundTransparency = .5,
							Country_Code = info.Label,
							TextTransparency = .1,
							Text = info.Label[1],
							TextScaled = true,

							Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black"},
							Colors_Text_Primary = {"TextColor3"},

							MouseButton1Click = framework.protected:GCProtect(function()
								local aiBtn = ui:Get("AITipsButton")
								aiBtn.CountryCode = info.Code

								aiBtn.instance.Text = utils:Translate({`Translate to {info.Code}`,`Traduci in {info.Code}`,`Dịch sang {info.Code}`,`Traduzir para {info.Code}`,`Terjemahkan ke {info.Code}`,`Перевести на {info.Code}`,`Ins {info.Code} übersetzen`,`Traducir a {info.Code}`,`Traduire en {info.Code}`,`翻译为 {info.Code}`,`{info.Code} に翻訳する`,`ترجمة إلى {info.Code}`,`{info.Code} में अनुवाद करें`,`แปลเป็น {info.Code}`})
								aiBtn.instance.BackgroundColor3 = Color3.fromHex("#FFF")
								aiBtn.instance.TextTransparency = 0
								aiBtn.instance.Active = true
							end)

						}, ui:AddInstance("UIPadding", {
							PaddingTop    = UDim.new(.2, 0),
							PaddingBottom = UDim.new(.2, 0)

						}), ui:AddInstance("UIGradient", {
							Rotation = 30,
							Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0,   Color3.fromHex(gradientColors[1])),
								ColorSequenceKeypoint.new(.5, Color3.fromHex(gradientColors[2])),
								ColorSequenceKeypoint.new(1,   Color3.fromHex(gradientColors[3])),
							})

						}), ui:AddInstance("UICorner", {
							CornerRadius = UDim.new(.4, 0)
						})))
					end

					return btns
				end)), ui:AddInstance("TextButton", {
					Id = "AITipsButton",

					Position = UDim2.fromScale(.5, .9),
					TextColor3 = Color3.fromHex("#FFF"),
					AnchorPoint = Vector2.new(.5, 1),
					Size = UDim2.fromScale(.9, .15),
					BackgroundTransparency = .75,
					TextTransparency = .1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black"},
					Country_Code = {"Translate","Traduci","Dịch","Traduzir","Terjemahkan","Перевести","Übersetzen","Traducir","Traduire","翻译","翻訳する","ترجم","अनुवाद करें","แปล"},
					-- Colors_Text_Primary = {"TextColor3"}

					MouseButton1Click = framework.protected:GCProtect(function()
						local languagePicker = ui:Get("LanguagePicker").instance
						local aiBtn, aiText = ui:Get("AITipsButton"), ui:Get("AITipsText")

						if aiBtn.selectable and aiBtn.instance.Active then 
							utils:ShowToast("ButtonToast", {
								AdditionalText = {"Translate?","Tradurre?","Dịch?","Traduzir?","Terjemahkan?","Перевести?","Übersetzen?","Traducir?","Traduire?","翻译？","翻訳する？","ترجم؟","अनुवाद करें?","แปล?"},
								Style = "confirm",

								Callback = function(res: boolean)
									if not res then return end
									framework.settings:SetSetting("Country_Code", aiBtn.CountryCode)
									aiText:Tween(tweens.default, {
										TextTransparency = 0
									})

									aiBtn.instance.Text = utils:Translate({"Translate","Traduci","Dịch","Traduzir","Terjemahkan","Перевести","Übersetzen","Traducir","Traduire","翻译","翻訳する","ترجم","अनुवाद करें","แปล"})
									-- Refresh static translations

									local isScripthub = ui:Get("CloudSearchBox").mode == "scripthub"
									ui:Get("ScriptsSwitchButton").instance.Text = isScripthub
										and utils:Translate({"LocalScripts 📂","Script locali 📂","Kịch bản cục bộ 📂","Scripts locais 📂","Skrip Lokal 📂","Локальные скрипты 📂","Lokale Skripte 📂","Scripts locales 📂","Scripts locaux 📂","本地脚本 📂","ローカルスクリプト 📂","السكريبتات المحلية 📂","स्थानीय स्क्रिप्ट 📂","สคริปต์ภายในเครื่อง 📂"})
										or utils:Translate({"CloudScripts ☁️","ScriptCloud ☁️","Kịch bản đám mây ☁️","Scripts na nuvem ☁️","Skrip Awan ☁️","Облачные скрипты ☁️","CloudSkripte ☁️","Scripts en la nube ☁️","Scripts Cloud ☁️","云脚本 ☁️","クラウドスクリプト ☁️","سكريبتات السحابة ☁️","क्लाउडस्क्रिप्ट्स ☁️","สคริปต์คลาวด์ ☁️"})

									framework.dependencies.scripthub:Browse(nil, true, "scripthub")
									--framework.dependencies.editortabs:GetSaved("tabs")

									if not isScripthub then
										ui:Get("GridFilter"):Refresh()
										--ui:Get("BarFilter"):Refresh()
									end

									aiText.instance.Visible = true
									languagePicker.Visible = false
									aiBtn.selectable = false
								end
							})
							return 
						else
							utils:AnimateCascade(aiBtn, {
								SkipTransparency = true,
								ScaleDirection = "In",
								ScaleCascade = true,
								AnimateSelf = true
							})
						end

						aiText:Tween(tweens.default, {
							TextTransparency = 1
						})

						task.delay(1, function()
							aiText.instance.Visible = false
						end)

						aiBtn.instance.Text = utils:Translate({"Select a language","Seleziona la lingua","Chọn ngôn ngữ","Selecione um idioma","Pilih bahasa","Выберите язык","Sprache auswählen","Selecciona un idioma","Sélectionnez une langue","选择语言","言語を選択","اختر لغة","एक भाषा चुनें","เลือกภาษา"})
						languagePicker.Visible = true
						aiBtn.selectable = true

						aiBtn.instance.BackgroundColor3 = Color3.fromHex("#000")
						aiBtn.instance.TextTransparency = .5
						utils:AnimateCascade(languagePicker)
						aiBtn.instance.Active = false
					end)

				}, ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.2, 0),
					PaddingTop = UDim.new(.2, 0)

				}), ui:AddInstance("UIGradient", {
					Rotation = 30,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHex("#FF0000")),
						ColorSequenceKeypoint.new(.4, Color3.fromHex("#FF3869")),
						ColorSequenceKeypoint.new(.7, Color3.fromHex("#F473EC")),
						ColorSequenceKeypoint.new(1, Color3.fromHex("#15A6FE"))
					})

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new (.4,0)

				}))), ui:AddInstance("Frame", {
					Id = "AIPanelBackground2",

					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Position = UDim2.fromScale(.03, .75),
					Size = UDim2.fromScale(.55, .2),
					BackgroundTransparency = .375,
					ClipsDescendants = true,

					Tags = {"Colors_Secondary"}

				}, ui:AddInstance("UIGradient", {
					Rotation = 10,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHex("#FF0000")),
						ColorSequenceKeypoint.new(.4, Color3.fromHex("#FF3869")),
						ColorSequenceKeypoint.new(.70, Color3.fromHex("#F473EC")),
						ColorSequenceKeypoint.new(1, Color3.fromHex("#15A6FE"))
					})

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.3, 0)

				}), ui: AddInstance("ImageButton", {
					Id = "AIPlayerBackgroundOverlay",

					ImageColor3 = Color3.fromHex("#000"),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ZIndex = 30,

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:ShowToast("InputToast", {
							PlaceholderText = {"Play music","Ascolta musica","Phát nhạc","Ouvir música","Putar musik","Воспроизвести музыку","Musik abspielen","Reproducir música","Écouter de la musique","播放音乐","音楽を再生","تشغيل الموسيقى","संगीत चलाएँ","เล่นเพลง"},
							AdditionalText = {"Song id...", "Id musica...", "Id bài hát...", "Id da música...", "Id lagu...", "Id песни...", "Song-ID...", "Id de canción...", "Id de la chanson...", "歌曲ID...", "曲ID...", "معرف الأغنية...", "गीत आईडी...", "รหัสเพลง..."},

							Callback = function(res: any)
								if res == "" then return end
								local trackplayer = framework.dependencies.track
								local data = trackplayer:Play(res)
								
								if not data then return end
								ui:Get("PlayIcon").instance.Image = trackplayer:IsPaused() and 
									framework.protected:ProtectAsset("rbxassetid://131442639815262") or framework.protected:ProtectAsset("rbxassetid://74770554858723")

								ui:Get("TrackArtist").instance.Text = data.Creator.Name
								ui:Get("TrackTitle").instance.Text = data.Name
							end
						})
					end)

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.3, 0)

				}), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Right,
					Position = UDim2.fromScale(.95, .1),
					Size = UDim2.fromScale(.35, .15),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					TextScaled = true,

					Country_Code = {"Arceus Intelligence"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Caption"},
					Colors_Text_Primary = {"TextColor3"},

				}), ui:AddInstance("TextLabel", {
					Id = "TrackArtist",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(.3, .425),
					AnchorPoint = Vector2.new(0, 1),
					Size = UDim2.fromScale(.6, .15),
					BackgroundTransparency = 1,
					TextTransparency = .5,
					
					Country_Code = {"Click to change song...","Clicca per cambiare canzone...","Nhấp để thay đổi bài hát...","Clique para mudar a música...","Klik untuk mengubah lagu...","Нажмите, чтобы сменить песню...","Klicken Sie, um das Lied zu wechseln...","Haz clic para cambiar la canción...","Cliquez pour changer de chanson...","点击更改歌曲...","曲を変更するにはクリックしてください...","انقر لتغيير الأغنية...","गाना बदलने के लिए क्लिक करें...","คลิกเพื่อเปลี่ยนเพลง..."},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Heading"},
					Colors_Text_Primary = {"TextColor3"},
					TextScaled = true

				}), ui:AddInstance("TextLabel", {
					Id = "TrackTitle",

					TextXAlignment = Enum.TextXAlignment.Left,
					Text = "Arceus X Theme",
					Position = UDim2.fromScale(.3 , .55),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.65, .275),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Colors_Text_Primary", "Fonts_Heading"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui: AddInstance("ImageButton", {
					Id = "AIIcon2",

					Position = UDim2.fromScale(.05 , .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.85, .85),
					BackgroundTransparency = 1,

					Tags = {"Colors_Text_Primary"},
					MouseButton1Click = framework.protected:GCProtect(function()
						local trackplayer = framework.dependencies.track
						trackplayer:Toggle(ui:Get("SoundTrack"))
						
						ui:Get("PlayIcon").instance.Image = trackplayer:IsPaused() and 
							framework.protected:ProtectAsset("rbxassetid://131442639815262") or framework.protected:ProtectAsset("rbxassetid://74770554858723")
					end)

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}), ui: AddInstance("ImageLabel", {
					Id = "PlayIcon",

					Image = "rbxassetid://131442639815262", -- Pause = 74770554858723
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(.4, .4),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1,
					ImageTransparency = .2,

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				}))), ui:AddInstance("Frame", {  -- AI SONG PLAYER
					Position = UDim2.fromScale(.99, .85),
					Size = UDim2.fromScale(.685, .025),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .8

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				}), ui:AddInstance("ImageButton", {
					Id = "TrackSlider",

					Position = UDim2.fromScale(0, .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.7, 1.75),
					AutoButtonColor = false,
					BorderSizePixel = 0,

					Colors_Primary = {"BackgroundColor3"},
					Tags = {"Colors_Primary"}

				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				})), ui:AddInstance("TextLabel", {
					Id = "TrackTime",

					TextYAlignment = Enum.TextYAlignment.Bottom,
					TextXAlignment = Enum.TextXAlignment.Right,
					Position = UDim2.fromScale(1, 0),
					AnchorPoint = Vector2.new(1, 1),
					Size = UDim2.fromScale(1, 7),
					BackgroundTransparency = 1,
					TextTransparency = .25,
					Text = "1:30 / 3:15",
					TextScaled = true,

					Tags = {"Colors_Text_Primary", "Fonts_Editor"},
					Colors_Text_Primary = {"TextColor3"}

				})))), ui:AddInstance("Frame", {  -- AI CHAT PANEL
					Id = "AIChatPanelBackground",

					Position = UDim2.fromScale(.97, .95),
					Size = UDim2.fromScale(.36 , .8),
					AnchorPoint = Vector2.new(1, 1),
					BackgroundTransparency = 1,

					Colors_Secondary = {"BackgroundColor3"},
					Tags = {"Colors_Secondary"}

				}, ui:AddInstance("ImageLabel", {
					Id = "ZoomedImage",
					Image = "rbxassetid://89942914228029",
					Position = UDim2.fromScale(.5, .5),
					Size = UDim2.fromScale(1.4, 1.4), -- immagine ingrandita
					AnchorPoint = Vector2.new(.5, .5),
					BackgroundTransparency = 1,
					ZIndex = -1
				}), ui:AddInstance("ImageLabel", {
					Id = "AIChatPanelBackgroundOverlay",

					Image = "rbxassetid://112235731951114",
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = .35

				}, ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Right,
					Position = UDim2.fromScale(1.025, -.025),
					TextYAlignment = Enum.TextYAlignment.Top,
					Size = UDim2.fromScale(.55, .075),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Caption"},
					Country_Code = {"Arceus Intelligence"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "AIResponseTitle",

					Position = UDim2.fromScale(.5, .1),
					AnchorPoint = Vector2.new(.5, 0),
					Size = UDim2.fromScale(.5, .05),
					BackgroundTransparency = 1,
					TextTransparency = .5,
					TextScaled = true,

					Country_Code = {`Hello! I'm {aiName}!`,`Ciao! Sono {aiName}!`,`Xin chào! Tôi là {aiName}!`,`Olá! Eu sou {aiName}!`,`Halo! Saya {aiName}!`,`Привет! Я {aiName}!`,`Hallo! Ich bin {aiName}!`,`Hola! Soy {aiName}!`,`Bonjour! Je suis {aiName}!`,`你好！我是 {aiName}！`,`こんにちは！私は {aiName} です！`,`مرحبًا! أنا {aiName}!`,`नमस्ते! मैं {aiName} हूँ!`,`สวัสดี! ฉันคือ {aiName}!`},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Heading"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("ScrollingFrame", {
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					Position = UDim2.fromScale(0.5, .17),
					Size = UDim2.fromScale(.985, .675),
					AnchorPoint = Vector2.new(.5,0),
					CanvasSize = UDim2.fromScale(0,0),
					ScrollBarThickness = padding/3,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,

				}, ui:AddInstance("TextLabel", {
					Id = "AIResponse",

					TextYAlignment = Enum.TextYAlignment.Top,
					AutomaticSize = Enum.AutomaticSize.XY,
					Position = UDim2.fromScale(.5, 0),
					AnchorPoint = Vector2.new(.5,0),
					Size = UDim2.fromScale(.8, 0),
					BackgroundTransparency = 1,
					TextTransparency = .45,
					TextSize = padding * 2,
					TextWrap = true,
					RichText = true,
					LineHeight = .9,

					Country_Code = {"What can I do for\nyou today?","Cosa posso fare per te oggi?","Bạn cần tôi làm gì hôm nay?","O que posso fazer por você hoje?","Apa yang bisa saya lakukan untuk Anda hari ini?","Что я могу сделать для вас сегодня?","Was kann ich heute für dich tun?","¿Qué puedo hacer por ti hoy?","Que puis-je faire pour vous aujourd'hui?","我今天能为您做些什么？","今日何をお手伝いできますか？","ماذا يمكنني أن أفعل من أجلك اليوم؟","मैं आज आपके लिए क्या कर सकता हूँ?","วันนี้ฉันจะช่วยอะไรคุณได้บ้าง?"},
					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black", "UI_WindowState"},
					Colors_Text_Primary = {"TextColor3"},

					UI_WindowState = {
						TextSize = { padding * 2, padding * 2.5, padding * 3 }
					}

				}, ui:AddInstance("UIGradient", {
					Rotation = 210,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromHex("#FF2E56")),
						ColorSequenceKeypoint.new(.23, Color3.fromHex("#FF3869")),
						ColorSequenceKeypoint.new(.66, Color3.fromHex("#F473EC")),
						ColorSequenceKeypoint.new(1, Color3.fromHex("#7390F6"))
					})

				}))), ui:AddInstance("TextBox", {
					Id = "AIBox",

					TextXAlignment = Enum.TextXAlignment.Left,
					TextColor3 = Color3.fromHex("#FFF"),
					Position = UDim2.fromScale(.5, .875),
					AnchorPoint = Vector2.new(.5, 0),
					Size = UDim2.fromScale(.9, .1),
					BackgroundTransparency = .85,
					TextTransparency = .5,
					TextScaled = true,
					Text = "",

					Country_Code_Placeholder = {"Teach me how to...", "Insegnami come fare...", "Dạy tôi cách...", "Ensine-me como...", "Ajari saya cara...", "Научи меня, как...", "Lehre mich, wie man...", "Enséñame cómo...", "Apprends-moi comment...", "教我如何...", "どうやって...するか教えて...", "علمني كيف...", "मुझे सिखाओ कैसे...", "สอนฉันวิธี..."},
					Tags = {"Country_Code"},

					FocusLost = framework.protected:GCProtect(function()
						if utils.axintDebounce then return end
						utils.axintDebounce = true

						local input, output = ui:Get("AIBox").instance, ui:Get("AIResponse").instance
						local background = ui:Get("BackgroundGlow")
						local axint = framework.dependencies.axintelligence

						local outmsg = output.Text
						output.Text = utils:Translate({"Reasoning...","Ragionamento...","Đang suy luận...","Raciocínio...","Penalaran...","Рассуждение...","Überlegung...","Razonando...","Raisonnement...","推理...","推論中...","التفكير...","तर्क कर रहा है...","กำลังให้เหตุผล..."})
						local prompt = input.Text
						input.Text = ""

						local res = axint:Chat(prompt)
						if res then
							local msg = framework.utils.strings.gsub(res.texts[1], "%s", "")
							if msg == "" then
								outmsg = "Arceus Intelligence is not available, please try again later"
							else
								outmsg = res.texts[1]
								background:Tween(tweens.default, {
									ImageColor3 = Color3.fromHex("#707070")
								})

								task.delay(3, function()
									background:Tween(tweens.slow_default, { 
										ImageColor3 = Color3.fromHex("#000"),
									})
								end)
							end

							if #res.codes > 0 then
								utils:ShowToast("ButtonToast", {
									AdditionalText = {`{framework.utils.strings.sub(res.codes[1], 1, 50)}`},
									AdditionalTitle = {"Allow arcy to execute?","Permettere ad arcy di eseguire?","Cho phép Arcy thực thi?","Permitir que o Arcy execute?","Izinkan Arcy untuk mengeksekusi?","Разрешить Arcy выполнять?","Arcy ausführen lassen?","¿Permitir que Arcy ejecute?","Autoriser Arcy à exécuter ?","允许 Arcy 执行？","Arcy に実行を許可しますか？","السماح لـ Arcy بالتنفيذ؟","क्या Arcy को निष्पादन की अनुमति दें?","อนุญาตให้ Arcy ดำเนินการหรือไม่?"},
									Style = "confirm",

									Callback = function(yes: boolean)
										if not yes then return end
										framework.execution:Execute(res.codes[1])
									end
								})
							end
						end

						utils:AnimateCascade(output, {
							AnimateSelf = true,
							ScaleCascade = true,
							ScaleDirection = "In"
						})

						output.Text = outmsg
						utils.axintDebounce = false
					end)

				}, ui:AddInstance("UIPadding", {
					PaddingRight = UDim.new(.05, 0),
					PaddingLeft = UDim.new(.2, 0),
					PaddingBottom = UDim.new(.3, 0),
					PaddingTop = UDim.new(.3, 0)

				}), ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://135762677969700", -- AI Icon
					Position = UDim2.fromScale(-.05,.5),
					AnchorPoint = Vector2.new(1,.5),
					Size = UDim2.fromScale(.15,1.5),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1
				}), ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://93050869167661", -- Shadow Glow
					Size = UDim2.fromScale(2,6.4), -- Without padding --> Size = UDim2.fromScale(1.75,4),
					AnchorPoint = Vector2.new(.5,.5),
					Position = UDim2.fromScale(.4,.5),
					BackgroundTransparency = 1,
					ImageTransparency = .25
				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				})), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.11, 0)

				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.065, 0),
					PaddingTop = UDim.new(.065, 0),
					PaddingRight = UDim.new(.1, 0),
					PaddingLeft = UDim.new(.1, 0)
				}))))
			},
			{ Name = "Extensions", Icon = "rbxassetid://136247171547858",
				Content = ui:AddInstance("Frame", {Id = "Extensions"},

				ui:AddInstance("TextButton", {
					Id = "ExtensionBackButton",

					BackgroundColor3 = Color3.fromHex("#FF0000"),
					Position = UDim2.fromScale(.08, .03),
					Size = UDim2.fromScale(.115, .06),
					AnchorPoint = Vector2.new(0,0),
					BackgroundTransparency = .45,
					Visible = false,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						local backButton, detachButton = ui:Get("ExtensionBackButton"), ui:Get("ExtensionDetachButton")
						local page, content = ui:Get("ExtensionPage"), ui:Get("ExtensionContent")

						backButton.instance.Visible = false
						detachButton.instance.Visible = false
						content.instance.Visible = false
						page.instance.Visible = true
					end)

				}, ui:AddInstance("TextLabel", {Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(1, .65),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
					Country_Code = {"‹	Back","‹	Indietro","‹	Quay lại","‹	Voltar","‹	Kembali","‹	Назад","‹	Zurück","‹	Atrás","‹	Retour","‹	返回","‹	戻る","‹	عودة","‹	वापस","‹	ย้อนกลับ"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})), ui:AddInstance("TextButton", {
					Id = "ExtensionDetachButton",

					BackgroundColor3 = Color3.fromHex("#58B2FF"),
					Position = UDim2.fromScale(.225, .03),
					Size = UDim2.fromScale(.135, .06),
					AnchorPoint = Vector2.new(0, 0),
					BackgroundTransparency = .5,
					Visible = false,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						local plugins = framework.dependencies.plugins
						local last = plugins:GetLastOpened()
						if last then last:Detach() end
					end)

				}, ui:AddInstance("TextLabel", {
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(1, .65),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Title"},
					Country_Code = {" 🔗  Detach"," 🔗  Stacca"," 🔗  Tháo"," 🔗  Desanexar"," 🔗  Lepas"," 🔗  Отсоединить"," 🔗  Lösen"," 🔗  Desacoplar"," 🔗  Détacher"," 🔗  分离"," 🔗  分離"," 🔗  فصل"," 🔗  अलग करें"," 🔗  ถอด"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})),
				ui:AddInstance("ScrollingFrame", {
					Id = "ExtensionPage",

					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromHex("#FFF"),
					Position = UDim2.fromScale(0, .14),
					Size = UDim2.fromScale(1, .835),
					ScrollBarThickness = padding/3,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					BorderSizePixel = 0,

					Colors_Primary = {"ScrollBarImageColor3"},
					Tags = {"Colors_Primary"}

				}, ui:AddInstance("UIPadding",{
					PaddingLeft = UDim.new(.03, 0)

				}), ui:AddInstance("Frame", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1

				}, ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, .05),
					Size = UDim2.fromScale(.3, .08),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black"},
					Country_Code = {"Extensions","Estensioni","Tiện ích mở rộng","Extensões","Ekstensi","Расширения","Erweiterungen","Extensiones","Extensions","扩展","拡張機能","الإضافات","एक्सटेंशन","ส่วนขยาย"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, 0),
					Size = UDim2.fromScale(.3, .045),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Country_Code = {"Discover","Scopri le","Khám phá","Descobrir","Temukan","Обнаружить","Entdecken","Descubrir","Découvrir","发现","発見","اكتشف","खोजें","ค้นพบ"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextButton", {
					BackgroundColor3 = Color3.fromHex("#2B5780"),
					Position = UDim2.fromScale(.95, .05),
					Size = UDim2.fromScale(.15, .09),
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = .5,
					Text = "",

					MouseButton1Click = framework.protected:GCProtect(function()
						utils:ShowToast("InputToast", {
							PlaceholderText = {"Extension url","Url dell'estensione","URL tiện ích mở rộng","URL de extensão","URL ekstensi","URL расширения","Erweiterungs-URL","URL de extensión","URL de l'extension","扩展 URL","拡張機能のURL","رابط الإضافة","एक्सटेंशन URL","URL ส่วนขยาย"},
							AdditionalText = {"Install extension","Installa estensione","Cài đặt tiện ích mở rộng","Instalar extensão","Pasang ekstensi","Установить расширение","Erweiterung installieren","Instalar extensión","Installer l'extension","安装扩展","拡張機能をインストール","تثبيت الإضافة","एक्सटेंशन इंस्टॉल करें","ติดตั้งส่วนขยาย"},

							Callback = function(res: any)
								if not res then return end
								framework.dependencies.plugins:Install(res)
							end
						})
					end)

				}, ui:AddInstance("ImageLabel", {
					Image = "rbxassetid://112476312219988",
					Position = UDim2.fromScale(.1, .5),
					AnchorPoint = Vector2.new(0, .5),
					Size = UDim2.fromScale(.6, .6),
					BackgroundTransparency = 1

				}, ui:AddInstance("UIAspectRatioConstraint", {
					AspectRatio = 1

				})), ui:AddInstance("TextLabel", {
					Position = UDim2.fromScale(.625, .5),
					AnchorPoint = Vector2.new(.5, .5),
					Size = UDim2.fromScale(1, .55),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Body"},
					Country_Code = {"Install","Installa","Cài đặt","Instalar","Pasang","Установить","Installieren","Instalar","Installer","安装","インストール","تثبيت","इंस्टॉल","ติดตั้ง"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.35, 0)

				})) --[[,ui:AddInstance("TextBox", {
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromHex("000"),
					Position = UDim2.fromScale(1, .175),
					Size = UDim2.fromScale(.25, .095),
					AnchorPoint = Vector2.new(1, 0),
					PlaceholderText = "Search...",
					BackgroundTransparency = .5,
					TextScaled = true,
					Text = "",

					Tags = {"Colors_Text_Primary", "Fonts_Heading"},
					Colors_Text_Primary = {"TextColor3"}
					
				}, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(.5, 0)

				}), ui:AddInstance("UIPadding", {
					PaddingBottom = UDim.new(.25,0),
					PaddingRight = UDim.new(.05, 0),
					PaddingLeft = UDim.new(.075, 0),
					PaddingTop = UDim.new(.25,0)

				})),--]]), ui:AddInstance("Frame", {
					Id = "ExtensionHome",

					AutomaticSize = Enum.AutomaticSize.Y,
					Position = UDim2.fromScale(0, .175),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ClipsDescendants = false

				}, ui:AddInstance("UIGridLayout", {
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					FillDirection = Enum.FillDirection.Horizontal,
					CellPadding = UDim2.fromScale(.05, .075),
					SortOrder = Enum.SortOrder.LayoutOrder,
					CellSize = UDim2.fromScale(.15, 0)

				}))), ui:AddInstance("Frame", {
					Id = "ExtensionContent",

					--AutomaticSize = Enum.AutomaticSize.Y,
					Position = UDim2.fromScale(0, .175),
					Size = UDim2.fromScale(1, .8),
					BackgroundTransparency = 1,
					Visible = false
				}))
			},
			{ Name = "Settings", Icon = "rbxassetid://102545631972477",
				Content = ui:AddInstance("Frame", {Id = "Settings"},

				ui:AddInstance("ScrollingFrame", {
					Id = "SettingsPage",

					ScrollingDirection = Enum.ScrollingDirection.Y,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromHex("#FFF"),
					Position = UDim2.fromScale(0, .14),
					Size = UDim2.fromScale(1, .835),
					ScrollBarThickness = padding/3,
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					BorderSizePixel = 0,

					Colors_Primary = {"ScrollBarImageColor3"},
					Tags = {"Colors_Primary"}

				}, ui:AddInstance("UIPadding",{
					PaddingLeft = UDim.new(.03, 0),
					PaddingTop = UDim.new(.02, 0),
					PaddingRight = UDim.new(.03, 0),
					PaddingBottom = UDim.new(.02, 0)

				}), ui:AddInstance("Frame", {
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1

				}, ui:AddInstance("TextLabel", {
					Id = "SettingsTitle",
					
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, .05),
					Size = UDim2.fromScale(.3, .08),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Black"},
					Country_Code = {"Settings","Impostazioni","Cài đặt","Configuración","Pengaturan","Настройки","Einstellungen","Configurações","Paramètres","设置","設定","الإعدادات","सेटिंग्स","การตั้งค่า"},
					Colors_Text_Primary = {"TextColor3"}

				}), ui:AddInstance("TextLabel", {
					Id = "SettingsSubtitle",

					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.fromScale(0, 0),
					Size = UDim2.fromScale(.3, .045),
					BackgroundTransparency = 1,
					TextScaled = true,

					Tags = {"Country_Code", "Colors_Text_Primary", "Fonts_Description"},
					Country_Code = {"Configure","Configura","Định cấu hình","Configurar","Konfigurasi","Настроить","Konfigurieren","Configurar","Configurer","配置","構成","تكوين","कॉन्फ़िगर","กำหนดค่า"},
					Colors_Text_Primary = {"TextColor3"}

				})), ui:AddInstance("Frame", {
					Id = "SettingsHome",

					-- niente auto-layout: gestiamo noi lo stacking in scale
					AutomaticSize = Enum.AutomaticSize.None,
					Position = UDim2.fromScale(0, .175),
					-- altezza in scale calcolata per contenere tutti i blocchi
					-- BLOCK_H = 0.14, GAP = 0.03, N = 6  => totalScale = N*BLOCK_H + (N-1)*GAP = 0.99
					Size = UDim2.fromScale(1, 0.99),

					BackgroundTransparency = 1,
					ClipsDescendants = false
				}, framework.protected:GCProtect(function()
					-- configurazione spacing in SCALE
					local LEFT    = 0.0   -- 5% margine sinistro
					local WIDTH   = 0.90   -- 90% larghezza
					local BLOCK_H = 0.14   -- altezza di ogni setting (in scale)
					local GAP     = 0.09   -- spazio verticale tra setting (in scale)

					local function y(i)
						return (i-1) * (BLOCK_H + GAP)
					end

					return {
						-- Colori
						ui:AddComponent("SettingDropdown", {
							Id = "Setting_PrimaryColor",
							
							Description = {"Choose the primary color theme","Scegli il tema colore principale","Chọn chủ đề màu chính","Elige el tema de color principal","Pilih tema warna utama","Выберите основную цветовую тему","Wählen Sie das Hauptfarbthema","Escolha o tema de cor primário","Choisissez le thème de couleur principal","选择主要颜色主题","主要なカラーテーマを選択","اختر نظام الألوان الأساسي","प्राथमिक रंग थीम चुनें","เลือกธีมสีหลัก"},
							Title = {"Primary Color","Colore primario","Màu chính","Color primario","Warna utama","Основной цвет","Primärfarbe","Cor primária","Couleur principale","主色","プライマリカラー","اللون الأساسي","प्राथमिक रंग","สีหลัก"},
							
							Position = UDim2.fromScale(LEFT, y(1)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 1,
							
							Options = {
								{ Name = {"Red","Rosso","Đỏ","Rojo","Merah","Красный","Rot","Vermelho","Rouge","红色","赤","أحمر","लाल","สีแดง"}, Value = framework.settings:GetDefaultSetting("Colors_Primary") },
								{ Name = {"Blue","Blu","Xanh dương","Azul","Biru","Синий","Blau","Azul","Bleu","蓝色","青","أزرق","नीला","สีน้ำเงิน"}, Value = Color3.fromRGB(59, 130, 246):ToHex() },      -- #3B82F6
								{ Name = {"Green","Verde","Xanh lá","Verde","Hijau","Зелёный","Grün","Verde","Vert","绿色","緑","أخضر","हरा","สีเขียว"}, Value = Color3.fromRGB(34, 197, 94):ToHex() },      -- #22C55E
								{ Name = {"Purple","Viola","Tím","Púrpura","Ungu","Фиолетовый","Lila","Roxo","Violet","紫色","紫","أرجواني","बैंगनी","สีม่วง"}, Value = Color3.fromRGB(139, 92, 246):ToHex() },    -- #8B5CF6
								{ Name = {"Orange","Arancione","Cam","Naranja","Oranye","Оранжевый","Orange","Laranja","Orange","橙色","オレンジ","برتقالي","नारंगी","สีส้ม"}, Value = Color3.fromRGB(249, 115, 22):ToHex() },    -- #F97316
								{ Name = {"Amber","Ambra","Hổ phách","Ámbar","Amber","Янтарный","Bernstein","Âmbar","Ambre","琥珀色","琥珀","كهرماني","अंबर","สีเหลืองอำพัน"}, Value = Color3.fromRGB(245, 158, 11):ToHex() },     -- #F59E0B
								{ Name = {"Teal","Verde petrolio","Xanh lục lam","Verde azulado","Hijau kebiruan","Бирюзовый","Türkisblau","Verde-azulado","Sarcelle","蓝绿色","ティール","أزرق مخضر","हरित-नीला","สีน้ำเงินเขียว"}, Value = Color3.fromRGB(20, 184, 166):ToHex() },      -- #14B8A6
								{ Name = {"Cyan","Ciano","Xanh cyan","Cian","Sian","Голубой","Cyan","Ciano","Cyan","青色","シアン","سماوي","हरिनील","สีฟ้า"}, Value = Color3.fromRGB(6, 182, 212):ToHex() },       -- #06B6D4
								{ Name = {"Pink","Rosa","Hồng","Rosa","Merah muda","Розовый","Rosa","Rosa","Rose","粉红色","ピンク","وردي","गुलाबी","สีชมพู"}, Value = Color3.fromRGB(236, 72, 153):ToHex() },      -- #EC4899
								{ Name = {"Indigo","Indaco","Chàm","Índigo","Nila","Индиго","Indigo","Índigo","Indigo","靛蓝色","インディゴ","نيلي","जामुनी","สีคราม"}, Value = Color3.fromRGB(99, 102, 241):ToHex() },    -- #6366F1
								{ Name = {"Lime","Lime","Xanh lá chanh","Lima","Hijau limau","Лаймовый","Limette","Limão","Citron vert","酸橙色","ライム","ليموني","हल्का हरा","สีมะนาว"}, Value = Color3.fromRGB(132, 204, 22):ToHex() },      -- #84CC16
							},
							
							SelectedValue = function()
								return framework.settings:GetSetting("Colors_Primary")
							end,
							
							Callback = framework.protected:GCProtect(function(value: string)
								framework.settings:SetSetting("Colors_Primary", value)
							end)
						}),

						--[[
						ui:AddComponent("SettingDropdown", {
							Id = "Setting_SecondaryColor",
							
							Description = {"Choose the secondary color theme"},
							Title = {"Secondary Color"},
							
							Position = UDim2.fromScale(LEFT, y(2)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 2,
							
							Options = {
								{ Name = "Blue", Value = Color3.fromRGB(0, 128, 255):ToHex() },
								{ Name = "Orange", Value = Color3.fromRGB(255, 128, 0):ToHex() }
							},
							
							Callback = framework.protected:GCProtect(function(value: string)
								framework.settings:SetSetting("Colors_Secondary", value)
							end)
						}),

						-- Interfaccia
						ui:AddComponent("SettingToggle", {
							Id = "Setting_Translate",
							
							Description = {"Enable automatic translations (AI Page)"},
							Title = {"Translate"},
							Enabled = false,
							
							Position = UDim2.fromScale(LEFT, y(3)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 3,
							
							Callback = framework.protected:GCProtect(function(state: boolean)
								print("Translate setting:", state)
							end)
						}),]]
						
						ui:AddComponent("SettingDropdown", {
							Id = "Setting_FPSCap",

							Description = {"Choose the maximum FPS limit","Scegli il limite massimo di FPS","Chọn giới hạn FPS tối đa","Elige el límite máximo de FPS","Pilih batas FPS maksimum","Выберите максимальный предел FPS","Wählen Sie das maximale FPS-Limit","Escolha o limite máximo de FPS","Choisissez la limite maximale de FPS","选择最大FPS限制","最大FPS制限を選択","اختر الحد الأقصى لمعدل الإطارات في الثانية","अधिकतम FPS सीमा चुनें","เลือกขีดจำกัด FPS สูงสุด"},
							Title = {"FPS Cap","Limite FPS","Giới hạn FPS","Límite de FPS","Batas FPS","Ограничение FPS","FPS-Limit","Limite de FPS","Limite de FPS","FPS上限","FPS制限","الحد الأقصى لمعدل الإطارات","FPS सीमा","จำกัด FPS"},

							Position = UDim2.fromScale(LEFT, y(2)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 2,

							Options = {
								{ Name = {"30 Fps","30 FPS","30 FPS","30 FPS","30 FPS","30 кадров/с","30 FPS","30 FPS","30 FPS","30帧每秒","30 FPS","30 إطار/ث","30 एफपीएस","30 เฟรมต่อวินาที"}, Value = 30 },
								{ Name = {"60 Fps","60 FPS","60 FPS","60 FPS","60 FPS","60 кадров/с","60 FPS","60 FPS","60 FPS","60帧每秒","60 FPS","60 إطار/ث","60 एफपीएस","60 เฟรมต่อวินาที"}, Value = 60 },
								{ Name = {"120 Fps","120 FPS","120 FPS","120 FPS","120 FPS","120 кадров/с","120 FPS","120 FPS","120 FPS","120帧每秒","120 FPS","120 إطار/ث","120 एफपीएस","120 เฟรมต่อวินาที"}, Value = 120 },
								{ Name = {"144 Fps","144 FPS","144 FPS","144 FPS","144 FPS","144 кадров/с","144 FPS","144 FPS","144 FPS","144帧每秒","144 FPS","144 إطار/ث","144 एफपीएस","144 เฟรมต่อวินาที"}, Value = 144 },
								{ Name = {"240 Fps","240 FPS","240 FPS","240 FPS","240 FPS","240 кадров/с","240 FPS","240 FPS","240 FPS","240帧每秒","240 FPS","240 إطار/ث","240 एफपीएस","240 เฟรมต่อวินาที"}, Value = 240 },
								{ Name = {"Unlimited","Illimitato","Không giới hạn","Ilimitado","Tidak terbatas","Неограниченный","Unbegrenzt","Ilimitado","Illimité","无限","無制限","غير محدود","असीमित","ไม่จำกัด"}, Value = 1000 }
							},

							SelectedValue = function()
								return framework.settings:GetSetting("Setting_Fps")
							end,

							Callback = framework.protected:GCProtect(function(value: string)
								framework.settings:SetSetting("Setting_Fps", value)
								framework.env.setfpscap(value)
							end)
						}),

						ui:AddComponent("SettingNumeric", {
							Id = "Setting_EditorTextSize",

							Description = {"Set the size of the editor text","Imposta la dimensione del testo dell'editor","Đặt kích thước văn bản của trình soạn thảo","Establecer el tamaño del texto del editor","Atur ukuran teks editor","Установите размер текста редактора","Stellen Sie die Schriftgröße des Editors ein","Defina o tamanho do texto do editor","Définir la taille du texte de l’éditeur","设置编辑器文本大小","エディタのテキストサイズを設定","حدد حجم نص المحرر","संपादक पाठ का आकार सेट करें","ตั้งค่าขนาดข้อความของตัวแก้ไข"},
							Title = {"Editor Text Size","Dimensione testo editor","Kích thước văn bản trình soạn thảo","Tamaño de texto del editor","Ukuran teks editor","Размер текста редактора","Editor-Textgröße","Tamanho do texto do editor","Taille du texte de l’éditeur","编辑器文本大小","エディタのテキストサイズ","حجم نص المحرر","संपादक टेक्स्ट आकार","ขนาดข้อความของตัวแก้ไข"},
							StartValue = function()
								return framework.settings:GetSetting("FontSizes_Editor") or framework.settings:GetDefaultSetting("FontSizes_Editor")
							end,

							Increment = 1, Max = 32, Min = 8,
							Position = UDim2.fromScale(LEFT, y(3)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 3,

							Callback = framework.protected:GCProtect(function(value: number)
								framework.settings:SetSetting("FontSizes_Editor", value)
							end)
						}),
						

						-- Generali
						ui:AddComponent("SettingToggle", {
							Id = "Setting_DisableIntro",
							
							Description = {"Skip the intro when starting","Salta l'introduzione all'avvio","Bỏ qua phần giới thiệu khi khởi động","Saltar la introducción al iniciar","Lewati intro saat memulai","Пропустить вступление при запуске","Intro beim Start überspringen","Pular a introdução ao iniciar","Passer l’introduction au démarrage","启动时跳过介绍","起動時にイントロをスキップ","تخطي المقدمة عند بدء التشغيل","स्टार्ट करते समय इंट्रो छोड़ें","ข้ามอินโทรเมื่อเริ่มต้น"},
							Title = {"Disable Intro","Disattiva introduzione","Tắt phần giới thiệu","Desactivar introducción","Nonaktifkan intro","Отключить вступление","Intro deaktivieren","Desativar introdução","Désactiver l’introduction","禁用介绍","イントロを無効にする","تعطيل المقدمة","इंट्रो अक्षम करें","ปิดการใช้อินโทร"},
							Enabled = function()
								return not framework.settings:GetSetting("User_Intro")
							end,
							
							Position = UDim2.fromScale(LEFT, y(4)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 4,
							
							Callback = framework.protected:GCProtect(function(state: boolean)
								framework.settings:SetSetting("User_Intro", not state)
							end)
						}),
						
						-- Interfaccia
						--[[ui:AddComponent("SettingToggle", {
							Id = "Setting_Animations",

							Description = {"Enable or disable interface animations","Abilita o disabilita le animazioni dell'interfaccia","Bật hoặc tắt hoạt ảnh giao diện","Habilitar o deshabilitar las animaciones de la interfaz","Aktifkan atau nonaktifkan animasi antarmuka","Включить или отключить анимации интерфейса","Aktivieren oder deaktivieren Sie die Schnittstellenanimationen","Ativar ou desativar animações da interface","Activer ou désactiver les animations de l'interface","启用或禁用界面动画","インターフェースアニメーションを有効または無効にする","تمكين أو تعطيل الرسوم المتحركة للواجهة","इंटरफ़ेस एनिमेशन सक्षम या अक्षम करें","เปิดหรือปิดการทำงานของแอนิเมชันอินเทอร์เฟซ"},
							Title = {"Animations","Animazioni","Hoạt ảnh","Animaciones","Animasi","Анимации","Animationen","Animações","Animations","动画","アニメーション","الرسوم المتحركة","एनिमेशन","แอนิเมชัน"},
							Enabled = true,

							Position = UDim2.fromScale(LEFT, y(5)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 5,

							Callback = framework.protected:GCProtect(function(state: boolean)
								print("Animations setting:", state)
							end)
						}),]]
						
						-- Generali
						ui:AddComponent("SettingToggle", {
							Id = "Setting_Afk",

							Description = {"Bypass being kicked for AFK","Aggira l'espulsione per AFK","Vượt qua việc bị đá vì AFK","Evitar ser expulsado por AFK","Lewati tendangan karena AFK","Обойти кик за AFK","Kick wegen AFK umgehen","Evitar ser expulso por AFK","Contourner l’expulsion pour AFK","绕过因AFK被踢出","AFKによるキックを回避","تجاوز الطرد بسبب AFK","AFK होने पर किक से बचें","ข้ามการถูกเตะเพราะ AFK"},
							Title = {"Anti AFK","Anti AFK","Chống AFK","Anti AFK","Anti AFK","Анти AFK","Anti-AFK","Anti AFK","Anti AFK","防AFK","アンチAFK","مضاد AFK","एंटी AFK","ป้องกัน AFK"},
							Enabled = function()
								return framework.settings:GetSetting("Settings_Afk")
							end,

							Position = UDim2.fromScale(LEFT, y(5)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 5,

							Callback = framework.protected:GCProtect(function(state: boolean)
								framework.settings:SetSetting("Settings_Afk", state)
								
								if framework.env.WHWKIWIOSU then
									framework.env.WHWKIWIOSU(state)
									
								elseif state then
									framework.dependencies.shared.antiAfk()
								end
							end)
						}),
						
						ui:AddComponent("SettingDropdown", {
							Id = "Setting_Links",

							Description = {"Choose where to go","Scegli dove andare","Chọn nơi để đi","Elige adónde ir","Pilih ke mana harus pergi","Выберите, куда перейти","Wählen Sie, wohin Sie gehen möchten","Escolha para onde ir","Choisissez où aller","选择要去的地方","行き先を選んでください","اختر مكان الانتقال","कहाँ जाना है चुनें","เลือกว่าจะไปที่ไหน"},
							Title = {"Links","Collegamenti","Liên kết","Enlaces","Tautan","Ссылки","Links","Links","Liens","链接","リンク","الروابط","लिंक","ลิงก์"},

							Position = UDim2.fromScale(LEFT, y(6)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 6,

							Options = {
								{ Name = {"Website","Sito web","Trang web","Sitio web","Situs web","Веб-сайт","Webseite","Website","Site web","网站","ウェブサイト","موقع إلكتروني","वेबसाइट","เว็บไซต์"}, Value = "https://spdmteam.com" },
								{ Name = {"Shop","Negozio","Cửa hàng","Tienda","Toko","Магазин","Geschäft","Loja","Magasin","商店","ショップ","متجر","दुकान","ร้านค้า"}, Value = "https://shop.spdmteam.com" },
								{ Name = {"Discord","Discord","Discord","Discord","Discord","Дискорд","Discord","Discord","Discord","Discord","ディスコード","ديسكورد","डिस्कॉर्ड","ดิสคอร์ด"}, Value = "https://discord.spdmteam.com" }
							},

							Callback = framework.protected:GCProtect(function(value: string)
								framework.utils.http:OpenUrl(value)
							end)
						}),

						--[[ui:AddComponent("SettingToggle", {
							Id = "Setting_ConfirmationPopup",
							
							Description = {"Ask for confirmation before actions","Chiedi conferma prima delle azioni","Hỏi xác nhận trước khi thực hiện hành động","Pedir confirmación antes de las acciones","Minta konfirmasi sebelum melakukan tindakan","Спросить подтверждение перед действиями","Vor Aktionen um Bestätigung bitten","Pedir confirmação antes das ações","Demander une confirmation avant les actions","操作前请求确认","操作の前に確認を求める","اطلب التأكيد قبل الإجراءات","क्रियाओं से पहले पुष्टि माँगें","ขอการยืนยันก่อนดำเนินการ"},
							Title = {"Confirmation Popup","Finestra di conferma","Cửa sổ xác nhận","Ventana de confirmación","Popup konfirmasi","Всплывающее окно подтверждения","Bestätigungs-Popup","Popup de confirmação","Fenêtre de confirmation","确认弹窗","確認ポップアップ","نافذة تأكيد منبثقة","पुष्टिकरण पॉपअप","หน้าต่างยืนยัน"},
							Enabled = not not framework.settings:GetSetting("Popups_Confirmation"),
							
							Position = UDim2.fromScale(LEFT, y(4)),
							Size = UDim2.fromScale(WIDTH, BLOCK_H),
							LayoutOrder = 4,
							
							Callback = framework.protected:GCProtect(function(state: boolean)
								framework.settings:SetSetting("Popups_Confirmation", state)
							end)
						}),]]
					}
				end))))
			}
		}

		ui.navbarOffset = .25
		utils.pages = framework.protected:ProtectTable(pages)
	end

	local showPage do
		local lastPage
		showPage = framework.protected:GCProtect(function(id: string, posy: number)
			local nextPage = ui:Get(id)
			if utils.currentPage == nextPage then return end

			for _, page in ipairs(pages) do
				local content = page.Content.instance
				content.Visible = lastPage == content or nextPage.instance == content
			end

			lastPage = nextPage.instance
			ui:Get("MainPages").instance:JumpTo(nextPage.instance)

			local indicator = ui:Get("Indicator")
			indicator:Tween(tweens.default, {
				Position = UDim2.fromScale(.05, posy)
			})

			utils.currentPage = nextPage
			if id == "Page_ScriptHub" and not ui.CloudLoaded then
				ui.CloudLoaded = true

				ui:Get("GridFilter"):Refresh()
				ui:Get("BarFilter"):Refresh()
			end

			utils:AnimateCascade(nextPage, {
 				ExcludeNames = { "BarFilter", "GridFilter", "CloudBestScriptsBar", "AIPlayerBackgroundOverlay", "CategoryBtn_Files", "CategoryBtn_Auto", "CategoryBtn_Favs"}--, BestScriptsBar, MagicNicknameContainer", Slider_Gravity_Bar", "Slider_Jump_Bar", "Slider_Speed_Bar"
			})
		end)

		ui.showPage = showPage
	end

	local showNavbar do
		local size1, size2
		showNavbar = framework.protected:GCProtect(function(visible: boolean?)
			local content, sidebar, btn = ui:Get("ContentFrame"), ui:Get("Sidebar"), ui:Get("SideNavButton")
			local vis = visible == true or not sidebar.instance.Visible
			if vis then sidebar.instance.Visible = true end

			if not size1 then
				size1 = -sidebar.instance.Size.X.Scale
				size2 = content.instance.Size.X.Scale +size1

				size1 = UDim2.fromScale(size1, 0)
				size2 = UDim2.fromScale(size2, 1)
			end

			utils:AnimateCascade(btn.instance, {
				SkipTransparency  = true
			})

			sidebar:Tween(tweens.default, { Position = vis and UDim2.fromScale(0, 0) or size1, Visible = vis })
			content:Tween(tweens.default, { Size = vis and size2 or UDim2.fromScale(1, 1) })
			btn:Tween(tweens.default, { Rotation = vis and 180 or 0  })

			if vis then
				utils:AnimateCascade(sidebar, {
					ExcludeNames = {"Indicator"}
				})
			end
		end)

		ui.showNavbar = showNavbar
	end

	-- UI Here
	ui:AddInstance("ImageLabel", {
		Id = "StartingScreen",

		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		ZIndex = 500,
		Visible = false
	}, ui:AddInstance("ImageLabel", {
		Id = "UserPFP2",

		AnchorPoint = Vector2.new(0, .5),
		Position = UDim2.fromScale(.0775, .2),
		Size = UDim2.fromScale(.05, .05),
		BackgroundTransparency = .5

	}, ui:AddInstance("ImageLabel", {
		Id = "PFPOverlay2",

		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1

	}, ui:AddInstance("UICorner", {
		CornerRadius = UDim.new(1, 0)

	})), ui:AddInstance("UICorner", {
		CornerRadius = UDim.new(1, 0)

	}), ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 1

	})), ui:AddComponent("MovingText", {
		Id = "StartingNickname",

		Position = UDim2.fromScale(.115, .2),
		AnchorPoint = Vector2.new(0, .5),
		Size = UDim2.fromScale(.3, .0375),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Text = framework.protected:GetService("Players").LocalPlayer.displayName

	}), ui:AddInstance("TextLabel", {
		Id = "StartingWelcome",

		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromScale(.125, .3),
		Size = UDim2.fromScale(.1, .065),
		BackgroundTransparency = 1,
		TextTransparency = .5,
		TextScaled = true,

		Tags = {"Country_Code", "Fonts_Heading", "Colors_Text_Primary"},
		Country_Code = {"Welcome to","Benvenuto ad","Chào mừng đến","Bem-vindo a","Selamat datang di","Добро пожаловать в","Willkommen bei","Bienvenido a","Bienvenue à","欢迎来到","へようこそ","مرحبًا بك في","में आपका स्वागत है","ยินดีต้อนรับสู่"},
		Colors_Text_Primary = {"TextColor3"}

	}), ui:AddInstance("TextLabel", {
		Id = "StartingTitle",

		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromScale(.125, .35),
		Size = UDim2.fromScale(.26, .085),
		BackgroundTransparency = 1,
		Text = "Arceus X v5",
		TextScaled = true,

		Tags = {"Fonts_Title", "Colors_Text_Primary"},
		Colors_Text_Primary = {"TextColor3"},

	}), ui:AddInstance("TextLabel", {
		Id = "StartingText",

		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromScale(.125, .45),
		Size = UDim2.fromScale(.35, .215),
		BackgroundTransparency = 1,
		TextTransparency = .25,
		TextScaled = true,

		Country_Code = {"Explore new possibilities,\ntake control, and unlock the\npower to dominate.","Esplora nuove possibilità,\nottieni il controllo, sblocca il\npotere per dominare.","Khám phá những khả năng mới,\nkiểm soát và mở khóa\nsức mạnh để thống trị.","Explore novas possibilidades,\nassuma o controle e desbloqueie\no poder de dominar.","Jelajahi kemungkinan baru,\nambil kendali dan buka\nkekuatan untuk mendominasi.","Исследуйте новые возможности,\nвозьмите контроль и разблокируйте\nсилу, чтобы доминировать.","Erkunde neue Möglichkeiten,\nübernimm die Kontrolle und schalte\ndie Macht zur Beherrschung frei.","Explora nuevas posibilidades,\ntoma el control y desbloquea\nel poder para dominar.","Explorez de nouvelles possibilités,\nprenez le contrôle et débloquez\nle pouvoir de dominer.","探索新的可能性，\n掌握控制权，\n并解锁主宰的力量。","新たな可能性を探り、\nコントロールを手に入れ、\n支配する力を解き放つ。","استكشف إمكانيات جديدة،\nتولى السيطرة وافتح\nقوة الهيمنة.","नई संभावनाओं का अन्वेषण करें,\nनियंत्रण सँभालें और शक्ति को\nप्रभुत्व के लिए मुक्त करें।","สำรวจความเป็นไปได้ใหม่ๆ,\nควบคุมและปลดล็อก\nพลังเพื่อครอบงำ"},
		Tags = {"Country_Code", "Fonts_Description", "Colors_Text_Primary"},
		Colors_Text_Primary = {"TextColor3"}

	}), ui:AddInstance("TextBox", {
		Id = LPH_ENCSTR("EmailBox"),

		PlaceholderColor3 = Color3.fromHex("#808080"),
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundColor3 = Color3.fromHex("#FFF"),
		TextTruncate = Enum.TextTruncate.AtEnd,
		Position = UDim2.fromScale(.125, .675),
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.fromScale(.35, .075),
		BackgroundTransparency = .5,
		PlaceholderText = "Email",
		TextSize = padding * 3.5,
		TextWrapped = false,
		Text = "",

		FocusLost = framework.protected:GCProtect(function()
			local email = ui:Get(LPH_ENCSTR("EmailBox")).instance.Text
			if framework.utils.strings.match(email, LPH_ENCSTR("^[%w_%+%.%-]+@[%w%-%.]+%.%a%a+$")) then
				framework.settings:SetSetting(LPH_ENCSTR("User_EMail"), email)
			end
		end),

		Tags = {"Colors_Text_Primary", "Fonts_Editor", "No_Focus"},
		Colors_Text_Primary = {"TextColor3"}

	}, ui:AddInstance("UICorner", {
		CornerRadius = UDim.new(.35, 0)

	}), ui:AddInstance("UIPadding", {
		PaddingBottom = UDim.new(0, padding),
		PaddingRight = UDim.new(0, padding*2),
		PaddingLeft = UDim.new(0, padding*2),
		PaddingTop = UDim.new(0, padding)

	})), ui:AddInstance("ImageButton", {
		Id = "StartButton",

		Image = "rbxassetid://87886886705009",
		Position = UDim2.fromScale(.09, .75),
		Size = UDim2.fromScale(.25, .3),
		BackgroundTransparency = 1

	}, ui:AddInstance("TextLabel", {
		TextColor3 = Color3.fromHex("#FFF"),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(1, .15),
		BackgroundTransparency = 1,
		TextScaled = true,

		Country_Code = {"START","AVVIA","BẮT ĐẦU","INICIAR","MULAI","НАЧАТЬ","STARTEN","INICIAR","DÉMARRER","开始","開始","ابدأ","प्रारंभ","เริ่ม"},
		Tags = {"Country_Code", "Fonts_Title", "Colors_Text_Primary"},
		Colors_Text_Primary = {"TextColor3"}

	}), ui:AddInstance("UICorner", {
		CornerRadius = UDim.new(.5, 0)

	}), ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 2.35

	})), ui:AddInstance("ImageButton", {
		Id = "SubscribeButton",

		Image = "rbxassetid://87886886705009",
		Position = UDim2.fromScale(.29, .75),
		Size = UDim2.fromScale(.25, .3),
		ImageColor3 = Color3.new(0,0,0),
		BackgroundTransparency = 1,
		
		MouseButton1Click = framework.protected:GCProtect(function()
			framework.utils.http:OpenUrl("https://spdmteam.com/resellers")
		end)

	}, ui:AddInstance("TextLabel", {
		TextColor3 = Color3.fromHex("#FFF"),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(1, .15),
		BackgroundTransparency = 1,
		TextScaled = true,

		Country_Code = {"SUBSCRIBE","ISCRIVITI","ĐĂNG KÝ","INSCREVER-SE","BERLANGGAN","ПОДПИСАТЬСЯ","ABONNIEREN","SUSCRIBIRSE","S'ABONNER","订阅","購読","اشترك","सदस्यता लें","สมัครสมาชิก"},
		Tags = {"Country_Code", "Fonts_Title", "Colors_Text_Primary"},
		Colors_Text_Primary = {"TextColor3"}

	}), ui:AddInstance("UICorner", {
		CornerRadius = UDim.new(.5, 0)

	}), ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 2.35

	})), ui:AddInstance("ImageLabel", {
		Id = "StartingLogo",

		Image = "rbxassetid://81343346318525",
		Position = UDim2.fromScale(.5, 1),
		AnchorPoint = Vector2.new(0, .65),
		Size = UDim2.fromScale(.55, 1.5),
		ScaleType = Enum.ScaleType.Fit,
		BackgroundTransparency = 1
	}))

	ui:AddInstance("ImageButton", {
		Id = "Background",	

		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		AutoButtonColor = false,

	}, ui:AddInstance("ImageLabel", {
		Id = "BackgroundOverlay",

		AnchorPoint = Vector2.new(.5, .5),
		Position = UDim2.fromScale(.5, .5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageTransparency = 1,

	}, ui:AddComponent("Shade", {
		Id = "BottomShadeLeft",
		Size = UDim2.fromScale(.5, .5),
		Position = UDim2.fromScale(0, .5),
		Rotation = 80,

		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1, 0),
			NumberSequenceKeypoint.new(.2, 1, 0),
			NumberSequenceKeypoint.new(1, .35, 0)
		})

	}), ui:AddComponent("Shade", {
		Id = "BottomShadeRight",
		Size = UDim2.fromScale(.5, .5),
		Position = UDim2.fromScale(.5, .5),
		Rotation = 100,

		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1, 0),
			NumberSequenceKeypoint.new(.2, 1, 0),
			NumberSequenceKeypoint.new(1, .35, 0)
		})

	}), ui:AddInstance("TextLabel", {
		Id = "ShadeTitle",

		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Position = UDim2.fromScale(.5, .85),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(.25, .075),
		BackgroundTransparency = 1,
		TextTransparency = 1,
		TextScaled = true,
		Text = "Arceus X"

	}), ui:AddInstance("TextLabel", {
		Id = "ShadeText",

		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
		TextColor3 = Color3.fromRGB(220, 220, 220),
		Position = UDim2.fromScale(.5, .915),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(.25, .035),
		BackgroundTransparency = 1,
		TextTransparency = 1,
		TextScaled = true,
		RichText = true,
		Text = ""
	})))

	ui:AddInstance("CanvasGroup", {
		Id = "MainFrame",

		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(.5, .5),
		BackgroundTransparency = 1,
		Visible = false

	}, ui:AddInstance("ImageLabel", {
		Id = "BackgroundGlow",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageColor3 = Color3.fromHex("#000")

	}, ui:AddInstance("ImageLabel", {
		Id = "AnimatedWallpaper",

		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	})), ui:AddInstance("ImageButton", { -- CLOSE BUTTON
		Id = "CloseButton",

		ImageColor3 = Color3.fromHex("#F00"),
		ZIndex = 500,
		Position = UDim2.fromScale(.9625, .065),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(.125, .125),
		BackgroundTransparency = 1,
		AutoButtonColor = false,

		MouseButton1Click = ui.close,
		--MouseButton1Click = ui.nextSize
		Colors_Primary = {"ImageColor3"},
		Tags = {"Colors_Primary"}

	}, ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 1

	})), ui:AddInstance("ImageButton", { -- MAXIMIZE BUTTON
		Id = "MaximizeButton",

		ImageColor3 = Color3.fromHex("#58B2FF"),
		ZIndex = 500,
		Position = UDim2.fromScale(.91, .065),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(.125, .125),
		BackgroundTransparency = 1,
		AutoButtonColor = false,

		MouseButton1Click = ui.nextSize

	}, ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 1

	})), ui:AddInstance("TextButton", {
		Id = "SideNavButton",

		Position = UDim2.fromScale(.0375, .065),
		Size = UDim2.fromScale(.125, .11),
		AnchorPoint = Vector2.new(.5,.5),
		MouseButton1Click = showNavbar,
		BackgroundTransparency = 1,
		Rotation = 180,
		ZIndex = 100,
		Text = "",

		Tags = {"UI_WindowState"}

	}, ui:AddInstance("ImageLabel", {
		Image = "rbxassetid://92411285882466",
		Position = UDim2.fromScale(.5,.5),
		AnchorPoint = Vector2.new(.5,.5),
		Size = UDim2.fromScale(.45,.45),
		BackgroundTransparency = 1,

		Colors_Primary = {"ImageColor3"},
		Tags = {"Colors_Primary"}
		
	}), ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 1

	})), ui:AddInstance("Frame", {
		BackgroundColor3 = Color3.fromHex("#FFFFFF"),
		Size = UDim2.new(.075, 0, 1, 0),
		BackgroundTransparency = 0

	}, ui:AddInstance("UIGradient", {
		Rotation = 0,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new()),
			ColorSequenceKeypoint.new(1, Color3.new())
		}),

		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, .5),
			NumberSequenceKeypoint.new(1, 1)
		})

	})), ui:AddInstance("Frame", {
		Id = "InnerMain",

		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1

	}, ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = utils:GetSafeScreenRatio(),	
		Id = "SafeRatio"

	}), ui:AddInstance("ImageLabel", {
		Id = "MainLogo",

		Position = UDim2.fromScale(.5, .03),
		AnchorPoint = Vector2.new(.5, 0),
		Size = UDim2.fromScale(.3, .08),
		BackgroundTransparency = 1,
		ScaleType = Enum.ScaleType.Fit,
		Image = "rbxassetid://102982068367172"

	}), ui:AddInstance("Frame", {
		Id = "Sidebar",

		BackgroundColor3 = Color3.fromHex("#FFFFFF"),
		Size = UDim2.new(.075, 0, 1, 0),
		BackgroundTransparency = 1

	}, framework.protected:GCProtect(function()
		local btns = {}
		for i, page in ipairs(pages) do
			local idx = ui.navbarOffset +(i-1)/8.1
			page.Indicator = idx

			local pos = UDim2.fromScale(.5, idx)
			local btn = ui:AddComponent("SideBtn", {
				Id = `SideBtn_{page.Name}`,
				Image = page.Icon,
				LayoutOrder = i,
				Position = pos,

				OnClick = framework.protected:GCProtect(function()
					showPage(`Page_{page.Name}`, idx)

					utils:AnimateCascade(ui:Get(`SideBtn_{page.Name}`).instance, {
						SkipTransparency  = true
					})
				end)
			})

			page.Internal = btn
			framework.utils.tables.insert(btns, btn)
		end
		return btns

	end), ui:AddInstance("ImageLabel", {
		Id = "Indicator",

		Position = UDim2.fromScale(.05, 0),
		AnchorPoint = Vector2.new(.5,.25),
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://71605317317599",
		BackgroundTransparency = 1,

		Colors_Primary = {"ImageColor3"},
		Tags = {"Colors_Primary"}

	}, ui:AddInstance("UIAspectRatioConstraint", {
		AspectRatio = 1

	}))), ui:AddInstance("Frame", {
		Id = "ContentFrame",

		Position = UDim2.fromScale(1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1

	}, ui:AddInstance("UIPageLayout", {
		Id = "MainPages",

		FillDirection = Enum.FillDirection.Vertical,
		EasingDirection = Enum.EasingDirection.Out,
		SortOrder = Enum.SortOrder.LayoutOrder,
		EasingStyle = Enum.EasingStyle.Linear,
		TweenTime = tweens.default.Time,

		ScrollWheelInputEnabled = false,
		GamepadInputEnabled = false,
		TouchInputEnabled = false,
		Circular = false,

	}), framework.protected:GCProtect(function()
		local contents = {}
		for i, page in ipairs(pages) do
			local frame = page.Content
			frame:SetId(`Page_{page.Name}`)

			frame.instance.LayoutOrder = i
			frame.instance.BackgroundTransparency = 1
			frame.instance.Size = UDim2.fromScale(1, 1)
			framework.utils.tables.insert(contents, frame)
		end
		return contents

	end))), ui:AddInstance("UIAspectRatioConstraint", {
		Id = "Ratio169",
		AspectRatio = 1.777

	}), ui:AddInstance("UICorner", {
		Id = "MainCorner",
		CornerRadius = UDim.new(.075, 0)

	})):SetDraggable(true)

	---------------------------------------------------

	utils:AddSlimeEffect(ui:Get("MainFrame"), {
		All = {
			ui:Get("SideBtn_ArceusIntelligence"),
			ui:Get("SideBtn_Extensions"),
			ui:Get("SideBtn_ScriptHub"),
			ui:Get("SideBtn_Executor"),
			ui:Get("SideBtn_Settings"),
			ui:Get("MaximizeButton"),
			ui:Get("SideBtn_Home"),
			ui:Get("CloseButton"),
			ui:Get("MainLogo")
			-- ui:Get("SideNavButton"),
			-- ui:Get("Indicator"),
		},

		[pages[1]] = {
			ui:Get("BestScriptsPanelBackground"),
			ui:Get("SlidersContainerBackground"),
			ui:Get("ProfilePanelBackground"),
			ui:Get("HomeTipBackground"),
			ui:Get("AIPanelBackground")
		},

		[pages[2]] = {
			ui:Get("EditorSSExecuteButtonShadow"),
			ui:Get("EditorConsoleButtonShadow"),
			ui:Get("EditorExecuteButtonShadow"),
			ui:Get("EditorPasteButtonShadow"),
			ui:Get("EditorClearButtonShadow"),
			ui:Get("EditorCopyButtonShadow"),
			ui:Get("EditorSaveButtonShadow"),
			ui:Get("EditorAIButtonShadow"),
			ui:Get("DeleteFileButton"),
			ui:Get("FavouriteButton"),
			ui:Get("CategoryButtons"),
			ui:Get("EditorAIButton"),
			ui:Get("TabsSearchBox"),
			ui:Get("NewFileButton"),
			ui:Get("CategoryTitle"),
			ui:Get("EditorSideBar"),
			ui:Get("TabsList"),
			ui:Get("Editor")
		},

		[pages[3]] = {
			ui:Get("ScriptHubScroll"),
			ui:Get("NewScriptButton"),
			ui:Get("NewFolderButton"),
			ui:Get("CloudSearchBox"),
			ui:Get("ScriptsSwitch")
		},

		[pages[4]] = {
			ui:Get("AITipsPanelBackground"),
			ui:Get("AIChatPanelBackground"),
			ui:Get("AIPanelBackground2"),
			ui:Get("AIResponseTitle"),
			ui:Get("AITipsSubtitle"),
			ui:Get("AITipsButton"),
			ui:Get("AITipsTitle"),
			ui:Get("TrackArtist"),
			ui:Get("TrackSlider"),
			ui:Get("AITipsText"),
			ui:Get("AIResponse"),
			ui:Get("TrackTitle"),
			ui:Get("TrackTime"),
			ui:Get("AIIcon2"),
			ui:Get("AIBox")
		},

		[pages[5]] = {
			ui:Get("ExtensionDetachButton"),
			ui:Get("ExtensionBackButton"),
			ui:Get("ExtensionContent"),
			ui:Get("ExtensionPage"),
			ui:Get("ExtensionHome")
		},
		
		[pages[6]] = {
			ui:Get("SettingsTitle"),
			ui:Get("SettingsSubtitle"),
			ui:Get("Setting_PrimaryColor"),
			--ui:Get("Setting_SecondaryColor"),
			--ui:Get("Setting_Translate"),
			ui:Get("Setting_EditorTextSize"),
			ui:Get("Setting_DisableIntro"),
			ui:Get("Setting_Afk"),
			--ui:Get("Setting_ConfirmationPopup"),
			ui:Get("Setting_FPSCap"),
			ui:Get("Setting_Links")
		}
	})

	task.spawn(function()
		local Players = framework.protected:GetService("Players")
		local img1, img2 = ui:Get("UserPFP"), ui:Get("UserPFP2")
		local player = Players.LocalPlayer

		local userId = player.UserId
		local thumbType = Enum.ThumbnailType.AvatarBust
		local thumbSize = Enum.ThumbnailSize.Size420x420

		local success, content, isReady = pcall(function()
			return Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
		end)

		if success and isReady then
			img1.instance.Image = content
			if not img2 or not img2.instance then
				return
			end
			
			img2.instance.Image = content
		end
	end)

	do -- Floating icon
		local btns = framework.protected:GCProtect({})
		local debounce = false

		local ficon
		ficon = ui:AddInstance("ImageButton", {
			Id = "FloatingIcon",

			Position = UDim2.fromScale(.75, .75),
			AnchorPoint = Vector2.new(.5, .5),
			Size = UDim2.fromScale(.25, .25),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Visible = false

		}, framework.protected:GCProtect(function()
			for i, page in ipairs(pages) do
				local id = `Page_{page.Name}`
				local image = ui:AddInstance("ImageLabel", {
					Position = UDim2.fromScale(.5, .5),
					AnchorPoint = Vector2.new(.5, .5),
					ScaleType = Enum.ScaleType.Fit,
					Size = UDim2.fromScale(.3, .3),
					BackgroundTransparency = 1,
					Image = page.Icon
				})

				local btn = ui:AddInstance("ImageButton", {
					Id = `SubIcon_{page.Name}`,

					BackgroundTransparency = 1,
					ImageTransparency = .5,
					AnchorPoint = Vector2.new(.5, .5),
					Position = UDim2.fromScale(.5, .5),
					Size = UDim2.fromScale(.65, .65),
					AutoButtonColor = false,
					LayoutOrder = i,
					Visible = false,
					ZIndex = i,

					MouseButton1Click = framework.protected:GCProtect(function()
						if debounce then return end
						ficon.toggle(false);
						ui.open(); showPage(id, page.Indicator)
					end)

				}, image, ui:AddInstance("UICorner", {
					CornerRadius = UDim.new(1, 0)

				}), ui:AddInstance("UIAspectRatioConstraint"))

				--btn.ImageLabel = image
				page.External = btn

				framework.utils.tables.insert(btns, btn)
			end

			return btns
		end), ui:AddInstance("UIAspectRatioConstraint", {
			AspectRatio = 1

		}), ui:AddInstance("ImageLabel", {
			Id = "FloatingIconLogo",

			Image = "rbxassetid://102982068367172",
			Size = UDim2.fromScale(.3,.3),
			Position = UDim2.fromScale(.5, .5),
			AnchorPoint = Vector2.new(.5,.5),
			ScaleType = Enum.ScaleType.Fit,
			ImageTransparency = .25,
			BackgroundTransparency = 1
		})):SetDraggable(true)

		-- Animation
		local elapsed, animDuration, spinSpeed = 0, .5, 5
		local lastState = false
		local animation

		local compute = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(i: number, t: number)
			local additional_angle = framework.utils.maths.lerp(0, 1, t)
			local angle = (i *(2 *framework.utils.maths.pi /#btns)) +framework.utils.maths.pi -(additional_angle *spinSpeed %360)

			local floatingIconRadius = ficon.instance.Size.X.Scale /2
			local subIconRadius = btns[1].instance.Size.X.Scale /2
			local distance = framework.utils.maths.lerp(0, floatingIconRadius +3 *subIconRadius/2, t)

			local xScale = .5 +framework.utils.maths.cos(angle) *distance
			local yScale = .5 +framework.utils.maths.sin(angle) *distance
			return UDim2.fromScale(xScale, yScale)
		end))

		animation = framework.renderer:BindToRenderer(ficon.id, nil, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(delta: number)
			elapsed += delta
			if elapsed > animDuration then
				animation:Pause()
				elapsed = 0

				if not lastState then
					for _, icon in ipairs(btns) do
						icon.instance.Visible = false
					end
				end

				debounce = false
				return
			end

			local t = elapsed /animDuration
			local subIconTransparency, imageTransparency
			if lastState then
				subIconTransparency = framework.utils.maths.lerp(1, .5, framework.utils.maths.outExpo(t))
				imageTransparency = 1 -framework.utils.maths.outExpo(t)
			else
				subIconTransparency = framework.utils.maths.lerp(.5, 1, framework.utils.maths.outExpo(t))
				imageTransparency = framework.utils.maths.outExpo(t)
			end

			if not lastState then
				t = 1-t
			end

			for i, icon in ipairs(btns) do
				icon.instance.Position = compute(i, t)
				--icon.ImageLabel.instance.ImageTransparency = imageTransparency
				--icon.instance.BackgroundTransparency = subIconTransparency
			end
		end)))

		-- Interaction
		ficon.toggle = framework.protected:GCProtect(function(status: boolean)
			if debounce then return end
			debounce = true

			if status ~= nil then
				lastState = status
			else
				lastState = not lastState 
			end

			if lastState then
				for _, icon in ipairs(btns) do
					icon.instance.Visible = true
				end
			end

			animation:Render()

			if lastState then
				utils:AnimateCascade(ficon, {
					ScaleCascade     = true,
					ScaleDirection   = "In",
					EnterTweenInfo   = TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
					TweenInfo        = TweenInfo.new(.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
					SkipTransparency = true,
					DelayBetween     = .005
				})
			else
				utils:AnimateCascade(ficon, {
					ScaleCascade     = true,
					ScaleDirection   = "Out",
					EnterTweenInfo   = TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
					TweenInfo        = TweenInfo.new(.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
					SkipTransparency = true,
					DelayBetween     = .005
				})
			end
		end)

		local holdable = framework.utils.inputs.buttons.holdable(ficon, false)
		holdable.OnShortPress:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(elapsed)
			if debounce then return end
			ficon.toggle(false)
			ui.open()
		end)))

		holdable.OnLongPress:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(clickTime: number)
			if clickTime > 1 then return end
			ficon.toggle()
			for _, icon in ipairs(btns) do icon.Visible = false end
		end)))

		-- Init
		local page = pages[1]
		utils.currentPage = page
		showPage(`Page_{page.Name}`, page.Indicator)
		showNavbar(true)		
	end

	do -- Cloud Scripts
		local scriptsgrid, scriptslist, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudBestScriptsBar"), ui:Get("CloudSearchBox")
		local RunService: RunService = framework.protected:GetService("RunService")
		local cloudscripts = framework.dependencies.cloudscripts
		local deb1, deb2 = false, false

		cloudscripts.OnFetched:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results: {any}, refreshed: boolean, scope: string)
			if scope ~= "topbar" or searchbox.mode ~= "cloudscripts" or deb1 then return end
			searchbox.loading = true
			deb1 = true

			if refreshed then
				scriptslist:ClearScripts()
				if #results < 1 then
					scriptslist:AddScript({
						Description = utils:Translate({"No scripts found","Nessuno script trovato","Không tìm thấy kịch bản","Nenhum script encontrado","Tidak ada skrip yang ditemukan","Скрипты не найдены","Keine Skripte gefunden","No se encontraron scripts","Aucun script trouvé","未找到脚本","スクリプトが見つかりません","لم يتم العثور على سكربتات","कोई स्क्रिप्ट नहीं मिली","ไม่พบสคริปต์"}),
						Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
						NoFav = true
					})

					scriptslist:UpdateList() --:Move(1)
					searchbox.loading = false
					deb1 = false
					return
				end
			end

			for _, info in ipairs(results) do
				local img
				img = scriptslist:AddScript({
					OnFavourite = info.setFavourite,
					IsFavourite = info.isFavourite,
					Description = info.game,
					Title = info.title,
					Slug = info.slug,
					Image = info.image,

					Callback = function()
						utils:ShowPopup("CloudScriptInfo", info, {
							component = img
						})
					end

				}):GetObject()
				info.loadImage(img.instance, true)
				RunService.Stepped:Wait()
			end

			scriptslist:UpdateList()
			searchbox.loading = false
			deb1 = false
		end)))

		cloudscripts.OnFetched:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results: {any}, refreshed: boolean, scope: string)
			if scope ~= "grid" or searchbox.mode ~= "cloudscripts" or deb2 then return end
			searchbox.loading = true
			deb2 = true
			
			if refreshed then
				for _, v in ipairs(scriptsgrid.instance:GetChildren()) do
					if not v:IsA("UIGridLayout") then v:Destroy() end
				end

				if #results < 1 then
					ui:AddComponent("ScriptObj", {
						Description = utils:Translate({"No scripts found","Nessuno script trovato","Không tìm thấy kịch bản","Nenhum script encontrado","Tidak ada skrip yang ditemukan","Скрипты не найдены","Keine Skripte gefunden","No se encontraron scripts","Aucun script trouvé","未找到脚本","スクリプトが見つかりません","لم يتم العثور على سكربتات","कोई स्क्रिप्ट नहीं मिली","ไม่พบสคริปต์"}),
						Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
						Parent = scriptsgrid,
						NoFav = true
					})
					
					searchbox.loading = false
					deb2 = false
					return
				end
			end

			for i, info in ipairs(results) do
				local comp
				comp = ui:AddComponent("ScriptObj", {
					OnFavourite = info.setFavourite,
					IsFavourite = info.isFavourite,
					Description = info.game,
					Parent = scriptsgrid,
					Image = info.image,
					Title = info.title,
					Slug = info.slug,
					LayoutOrder = i,

					OnClick = function()
						utils:ShowPopup("CloudScriptInfo", info, {
							component = comp
						})
					end
				})

				info.loadImage(comp.instance, true)
				RunService.Stepped:Wait()
			end
			
			searchbox.loading = false
			deb2 = false
		end)))

		-- Grid cell size
		local scriptslayout = ui:Get("ScriptsGridLayout").instance
		local updateCells = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function()
			local x = scriptsgrid.instance.AbsoluteSize.X /3 -padding *3
			scriptslayout.CellSize = UDim2.fromOffset(x, 9 *x /16)
		end))

		updateCells()
		scriptsgrid.instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateCells)

		-- Load more
		local scripthubscroll: ScrollingFrame = ui:Get("ScriptHubScroll").instance
		scripthubscroll:GetPropertyChangedSignal("CanvasPosition"):Connect(LPH_NO_VIRTUALIZE(function()
			if framework.utils.maths.floor(scripthubscroll.AbsoluteCanvasSize.Y -scripthubscroll.CanvasPosition.Y)
				== framework.utils.maths.floor(scripthubscroll.AbsoluteSize.Y)
			then 
				if searchbox.mode == "serverside" then
					return framework.dependencies.serverside:GetGames()
					
				elseif scriptsgrid.lastQuery then
					scriptsgrid.lastQuery:Fetch()
				end
			end
		end))
	end

	do -- Script Hub
		local scriptsgrid, scriptslist, searchbox = ui:Get("ScriptsGrid"), ui:Get("CloudBestScriptsBar"), ui:Get("CloudSearchBox")
		local scripthub = framework.dependencies.scripthub

		local clearScripts = framework.protected:GCProtect(function()
			scriptslist:ClearScripts()
			for _, v in ipairs(scriptsgrid.instance:GetChildren()) do
				if not v:IsA("UIGridLayout") then v:Destroy() end
			end
		end)

		local noResults = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results)
			if #results < 1 then
				scriptslist:AddScript({
					Description = utils:Translate({"No files found","Nessun file trovato","Không tìm thấy tệp nào","Nenhum arquivo encontrado","Tidak ada file yang ditemukan","Файлы не найдены","Keine Dateien gefunden","No se encontraron archivos","Aucun fichier trouvé","未找到文件","ファイルが見つかりません","لم يتم العثور على ملفات","कोई फ़ाइलें नहीं मिलीं","ไม่พบไฟล์"}),
					Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
					IsLocal = true,
					NoFav = true
				})

				ui:AddComponent("ScriptObj", {
					Description = utils:Translate({"No files found","Nessun file trovato","Không tìm thấy tệp nào","Nenhum arquivo encontrado","Tidak ada file yang ditemukan","Файлы не найдены","Keine Dateien gefunden","No se encontraron archivos","Aucun fichier trouvé","未找到文件","ファイルが見つかりません","لم يتم العثور على ملفات","कोई फ़ाइलें नहीं मिलीं","ไม่พบไฟล์"}),
					Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
					Parent = scriptsgrid,
					IsLocal = true,
					NoFav = true
				})

				scriptslist:UpdateList() --:Move(1)
				return true
			end
		end))

		local runService = framework.protected:GetService("RunService")
		local loadScripts = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results)	
			for i, info in ipairs(results) do
				local popup = {}
				local props = {
					IsFavourite = info:GetProperty("favourite"),
					Description = info.path,
					Parent = scriptsgrid,
					Title = info.name,
					Slug = info.path,
					LayoutOrder = i,
					IsLocal = true,

					OnClick = function()
						utils:ShowPopup("LocalScriptInfo", info, popup)
					end,

					OnDelete = function()
						info:Delete()
						popup.component:Remove()
					end,

					OnFavourite = function()
						local status = not (info:GetProperty("favourite") and true or false)
						info:SetProperty({ favourite = status })
						
						runService.Heartbeat:Wait()
						framework.dependencies.scripthub:Browse(nil, true, "scripthub")
						return status
					end
				}

				props.Callback = props.OnClick
				popup.component = ui:AddComponent("ScriptObj", props)
				local _, content = info:Read()
				content = content or {}

				if info:GetProperty("favourite")
					or framework.utils.tables.find(content.games or {}, game.GameId)
					or framework.utils.tables.find(content.places or {}, game.PlaceId)
				then
					scriptslist:AddScript(props)
				end
			end

			scriptslist:UpdateList()
		end))

		local loadFolders = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results)
			for i, info in ipairs(results) do
				ui:AddComponent("ScriptObj", {
					LayoutOrder = -100000 +i,
					Description = info.path,
					Parent = scriptsgrid,
					IsFavourite = true,
					Title = info.name,
					IsFolder = true,
					IsLocal = true,
					NoFav = true,

					OnClick = function()
						info:Open()
					end
				})
			end
		end))

		scripthub.OnQueried:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results: {any}, scope: string)
			if (scope ~= "scripthub" and scope ~= "any") or searchbox.mode ~= "scripthub" then return end
			clearScripts()

			if noResults(results) then return end
			loadScripts(results)
		end)))

		scripthub.OnBrowsed:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(results: {any}, directories: {any}, scope: string)
			if (scope ~= "scripthub" and scope ~= "any") or searchbox.mode ~= "scripthub" then return end
			ui:Get("PathBar"):SetPath(directories)
			clearScripts()

			loadFolders(results.folders)
			if noResults(results.files) then return end
			loadScripts(results.files)
		end)))
	end
	
	do -- ServerSide games
		local serverside = framework.dependencies.serverside
		local scriptsgrid, scriptslist = ui:Get("ScriptsGrid"), ui:Get("CloudBestScriptsBar")
		local searchbox = ui:Get("CloudSearchBox")
		
		local clearScripts = framework.protected:GCProtect(function()
			scriptslist:ClearScripts()
			for _, v in ipairs(scriptsgrid.instance:GetChildren()) do
				if not v:IsA("UIGridLayout") then v:Destroy() end
			end
		end)
		
		local loadMore = framework.protected:GCProtect(function()
			if searchbox.mode ~= "serverside" then return end
			serverside:GetGames()
		end)
		
		serverside.OnMessage:Connect(framework.protected:GCProtect(function(msg, arg2, ...: any)
			if msg == "Connected" then
				ui:Get("EditorSSExecuteButtonShadow").instance.Visible = true
				return
					
			elseif msg == "CodeError" then
				return utils:ShowToast("ButtonToast", {
					AdditionalText = {tostring(arg2)},
					AdditionalTitle = {"SS Script Error"}
				})
			end
		end))
		
		serverside.OnFetched:Connect(framework.protected:GCProtect(function(games: {any}, more: boolean)
			if searchbox.mode ~= "serverside" then return end
			searchbox.loading = true
			
			if not more then
				clearScripts()
			end
			
			if #games < 1 and not more then
				scriptslist:AddScript({
					Description = utils:Translate({"No games found","Nessun gioco trovato","Không tìm thấy trò chơi","Nenhum jogo encontrado","Tidak ada game yang ditemukan","Игры не найдены","Keine Spiele gefunden","No se encontraron juegos","Aucun jeu trouvé","未找到游戏","ゲームが見つかりません","لم يتم العثور على ألعاب","कोई गेम नहीं मिला","ไม่พบเกม"}),
					Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
					IsLocal = true,
					NoFav = true
				})

				ui:AddComponent("ScriptObj", {
					Description = utils:Translate({"No games found","Nessun gioco trovato","Không tìm thấy trò chơi","Nenhum jogo encontrado","Tidak ada game yang ditemukan","Игры не найдены","Keine Spiele gefunden","No se encontraron juegos","Aucun jeu trouvé","未找到游戏","ゲームが見つかりません","لم يتم العثور على ألعاب","कोई गेम नहीं मिला","ไม่พบเกม"}),
					Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),
					Parent = scriptsgrid,
					IsLocal = true,
					NoFav = true
				})

				scriptslist:UpdateList()
				searchbox.loading = false
				return
			end
			
			for i, info in ipairs(games) do
				local props = {
					Description = "Server-Sided Game",
					Title = `{info.plrs} 👤 Plrs`,
					Parent = scriptsgrid,
					OnLoad = loadMore,
					LayoutOrder = i,
					NoFav = true,

					OnClick = function()
						utils:ShowToast("ButtonToast", {
							AdditionalText = {"Confirm to join the game","Conferma per entrare nel gioco","Xác nhận để tham gia trò chơi","Confirmar para entrar no jogo","Konfirmasi untuk bergabung dalam permainan","Подтвердите, чтобы присоединиться к игре","Bestätigen, um dem Spiel beizutreten","Confirmar para unirse al juego","Confirmer pour rejoindre le jeu","确认加入游戏","ゲームに参加することを確認","تأكيد الانضمام إلى اللعبة","खेल में शामिल होने की पुष्टि करें","ยืนยันการเข้าร่วมเกม"},
							Style = "confirm",

							Callback = function(res: boolean)
								if not res then return end
								serverside:TeleportTo(info.id)
							end
						})
					end
				}

				props.Callback = props.OnClick
				local img = scriptslist:AddScript(props):GetObject()
				info.loadImage(img.instance, true)
				
				img = ui:AddComponent("ScriptObj", props)
				info.loadImage(img.instance, true)
			end
			
			scriptslist:UpdateList()
			searchbox.loading = false
		end))
	end

	do -- Best Scripts
		local cloudscripts = framework.dependencies.cloudscripts
		local bestscripts = ui:Get("BestScriptsBar")

		local query = cloudscripts.newQuery(game.GameId, {
			verify = framework.enums.ScriptBloxVerify.Verified,
			patch = framework.enums.ScriptBloxPatch.Unpatched,
			search = framework.enums.ScriptBloxSearch.None,
			type = framework.enums.ScriptBloxType.Specific,
			sortBy = framework.enums.ScriptBloxSort.Views,
			order = framework.enums.ScriptBloxOrder.Desc,
			auth = framework.enums.ScriptBloxAuth.None,
			mode = framework.enums.ScriptBloxMode.Free
		})

		task.defer(LPH_NO_VIRTUALIZE(function()
			repeat task.wait() until ui.Loaded

			local scripts = query:Fetch()
			if #scripts < 3 then
				scripts = cloudscripts:FetchTrending()
				if #scripts < 3 then
					bestscripts:AddScript({
						Description = utils:Translate({"Try again later.","Riprova più tardi.","Thử lại sau.","Tente novamente mais tarde.","Coba lagi nanti.","Попробуйте позже.","Versuchen Sie es später noch einmal.","Inténtalo de nuevo más tarde.","Réessayez plus tard.","稍后再试。","後でもう一度お試しください。","حاول مرة أخرى لاحقًا.","बाद में पुन: प्रयास करें।","ลองใหม่ภายหลัง"}),
						Title = utils:Translate({"No results","Nessun risultato","Không có kết quả","Sem resultados","Tidak ada hasil","Нет результатов","Keine Ergebnisse","Sin resultados","Aucun résultat","无结果","結果がありません","لا توجد نتائج","कोई परिणाम नहीं","ไม่พบผลลัพธ์"}),

						NoFav = true,
						Callback = function()
							-- Popup, "No results were found, try again later."
						end
					})
					return bestscripts:UpdateList()
				end
			end

			for _, info in ipairs(scripts) do
				local img
				img = bestscripts:AddScript({
					OnFavourite = info.setFavourite,
					IsFavourite = info.isFavourite,
					Description = info.game,
					Title = info.title,
					Slug = info.slug,
					Image = info.image,

					Callback = function()
						utils:ShowPopup("CloudScriptInfo", info, {
							component = img
						})
					end
				}):GetObject()
				info.loadImage(img.instance, true)
			end
			bestscripts:UpdateList()
		end))
	end

	do -- Plugins
		local grid, page, content = ui:Get("ExtensionHome"), ui:Get("ExtensionPage"), ui:Get("ExtensionContent")
		local backButton, detachButton = ui:Get("ExtensionBackButton"), ui:Get("ExtensionDetachButton")
		local plugins = framework.dependencies.plugins
		--local parent = ui:Get("Plugins").instance

		plugins.OnPluginAtached:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(plug: {any})
			backButton.instance.Visible = true
			detachButton.instance.Visible = true
			content.instance.Visible = true
			page.instance.Visible = false
		end)))

		plugins.OnPluginDetached:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(plug: {any})
			backButton.instance.Visible = false
			detachButton.instance.Visible = false
			content.instance.Visible = false
			page.instance.Visible = true
		end)))

		plugins.OnPluginAdded:Connect(framework.protected:GCProtect(function(data: {any})
			local title = data.title or "Extension"

			local component
			component = ui:AddComponent("ExtensionObj", {
				Image = data.icon or "",
				Parent = grid,
				Title = title,

				OnClick = function()
					plugins:Open(data.id, content)
				end,

				OnDelete = data.url and function()
					utils:ShowToast("ButtonToast", {
						AdditionalText = {`Uninstall {title}?`,`Disinstallare {title}?`,`Gỡ cài đặt {title}?`,`Desinstalar {title}?`,`Copot pemasangan {title}?`,`Удалить {title}?`,`Deinstalliere {title}?`,`¿Desinstalar {title}?`,`Désinstaller {title}?`,`卸载 {title}？`,`{title} をアンインストールしますか？`,`إلغاء تثبيت {title}؟`,`{title} अनइंस्टॉल करें?`,`ถอนการติดตั้ง {title}?`},
						AdditionalTitle = {"Uninstall","Disinstalla","Gỡ cài đặt","Desinstalar","Copot pemasangan","Удалить","Deinstallieren","Desinstalar","Désinstaller","卸载","アンインストール","إلغاء التثبيت","अनइंस्टॉल","ถอนการติดตั้ง"},
						Style = "confirm",

						Callback = function(res: boolean)
							if not res then return end
							plugins:Remove(data.id)
							component:Remove()
						end
					})
				end
			})
		end))

		plugins.OnPluginLoaded:Connect(framework.protected:GCProtect(function(plug: {any}, id: string, ...: any)
			local infos = plugins:Setup(id, plug)
			plug:SetEnabled(false)

			infos:Attach(content)
			plug.OnClosed:Connect(framework.protected:GCProtect(function()
				infos:Attach(content)
			end))
			
			plug.hide(true)
			--task.defer(plug.SetEnabled, plug, false)
		end))
	end

	do -- Editor
		local editor = framework.utils.inputs.editors:Get("Main_Editor")
		local scripthub = framework.dependencies.scripthub
		local tabs = framework.dependencies.editortabs

		local UIS = framework.protected:GetService("UserInputService")
		local savedtabsoffset = 10000 -- slots for unsaved tabs
		local maxnamelength = 15

		local background = ui:Get("BackgroundGlow")
		framework.execution.OnExecuted:Connect(framework.protected:GCProtect(function() 
			background:Tween(tweens.default, {
				ImageColor3 = Color3.fromHex("#707070")
			})

			task.delay(3, function()
				background:Tween(tweens.slow_default, {  
					ImageColor3 = Color3.fromHex("#000"),
				})
			end)
		end))

		do -- Editor Saved Tabs
			local savedtabs = framework.protected:GCProtect({})
			local formatName = framework.protected:GCProtect(function(name: string, unsaved: boolean?)
				if #name > maxnamelength then
					name = `{framework.utils.strings.sub(name, 1, maxnamelength)}..`
				end

				name ..= unsaved and " *" or ""
				return name
			end)

			local list, layout = ui:Get("TabsList"), ui:Get("TabsLayout")
			layout.instance:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(framework.protected:GCProtect(function()
				list.instance.CanvasSize = UDim2.fromOffset(0, layout.instance.AbsoluteContentSize.Y)
			end))

			local leastOne = framework.protected:GCProtect(function()
				local res = #tabs:GetTabs() < 1
				if res then editor:AddTab() end
				return res
			end)

			local addtab = framework.protected:GCProtect(function(idx: number, name: string, saved: boolean, src: string, meta: {any}?)
				local component = ui:AddComponent("ScriptTab", {
					LayoutOrder = idx,
					Parent = list,
					Title = name
				})

				local textlbl = component.instance:FindFirstChildWhichIsA("TextLabel")
				local textbox = component.instance:FindFirstChildWhichIsA("TextBox")

				local tab, updated
				local actions = {
					[framework.enums.TabUpdate.Unselected] = function()
						local tb = UIS:GetFocusedTextBox()
						if tb then tb.FocusLost:Wait() end
						component:Unselect()
					end,

					[framework.enums.TabUpdate.Selected] = function()
						updated(framework.enums.TabUpdate.Source)
						component:Select()

						local data = tab:GetData() -- metti gli id delle immagini qui sure dw
						ui:Get("EditorSaveButton").instance.Image = data.isFile and framework.protected:ProtectAsset("rbxassetid://102895040094534") or framework.protected:ProtectAsset("rbxassetid://80105268646831")
						ui:Get("FavouriteButtonImage").instance.Image = tab:GetProperty("favourite")
							and framework.protected:ProtectAsset("rbxassetid://137934368112423") or "rbxassetid://80350699155696"
					end,

					[framework.enums.TabUpdate.Removed] = function()
						local found = framework.utils.tables.find(savedtabs, tab)
						if found then framework.utils.tables.remove(savedtabs, found) end
						component:Remove()
						leastOne()
					end,

					[framework.enums.TabUpdate.Source] = function()
						if tabs:GetSelection() == tab then
							editor:SetText(tab:GetSource())
						end
					end,

					[framework.enums.TabUpdate.Name] = function()
						local name = tab:GetName()
						textlbl.Text = formatName(name, not tab:GetData().isFile)
						textbox.Text = name
					end
				}

				updated = function(updateType: number, ...)
					local action = actions[updateType]
					if action then action(...) end
				end

				tab = tabs:AddTab(name, src, component, updated, saved, meta)
				tab:GetData().instance = component

				updated(framework.enums.TabUpdate.Name)
				if saved then framework.utils.tables.insert(savedtabs, tab) end
				return tab
			end)

			local loadsaved = framework.protected:GCProtect(LPH_JIT_MAX(function(res: {any})
				for _, tab in ipairs(framework.utils.tables.listCopy(savedtabs)) do tab:Remove() end
				for i, file in ipairs(res) do addtab(savedtabsoffset +i, file.name, true, file:Read()) end
			end))

			function editor:AddTab(name: string?, src: string?, content: {any}?)
				local tab = addtab(#tabs:GetTabs() +1, name, false, src or "", content)
				tab:Select()
				return tab
			end

			tabs:LoadTabs(framework.protected:GCProtect(function(idx: number, name: string, source: string)
				return addtab(idx, name, false, source)
			end))

			-- For saved tab files
			scripthub.OnQueried:Connect(framework.protected:GCProtect(function(res: {any}, scope: string)
				if scope ~= "tabs" and scope ~= "any" then return end
				loadsaved(res)
			end))

			scripthub.OnBrowsed:Connect(framework.protected:GCProtect(function(res: {any}, dirs: {any}, scope: string)
				if scope ~= "tabs" and scope ~= "any" then return end
				loadsaved(res.files)
			end))

			tabs:GetSaved("tabs")
			if not leastOne() then
				local all = tabs:GetTabs()
				all[#all]:Select()
			end
		end

		do -- Highlighter colors update
			--[[
			ui.highColors = { -- vscode
				local_property  = Color3.fromRGB(86, 156, 214),  -- keywords: #569CD6
				function_color  = Color3.fromRGB(220, 220, 170), -- functions: #DCDCAA
				local_color     = Color3.fromRGB(220, 220, 170), -- same as functions
				self_color      = Color3.fromRGB(86, 156, 214),  -- keywords variant
				self_call       = Color3.fromRGB(86, 156, 214),  -- same
				operator        = Color3.fromRGB(214, 157, 133), -- operators
				comment         = Color3.fromRGB(106, 153, 85),  -- comments: #6A9955
				boolean         = Color3.fromRGB(214, 157, 133), -- booleans
				numbers         = Color3.fromRGB(181, 206, 168), -- numbers: #B5CEA8
				call            = Color3.fromRGB(86, 156, 214),  -- calls: same as keywords
				rbx             = Color3.fromRGB(86, 156, 214),  -- "rbx" library calls
				lua             = Color3.fromRGB(78, 201, 176),  -- maybe types: #4EC9B0
				str             = Color3.fromRGB(206, 145, 120), -- strings: #CE9178
				null            = Color3.fromRGB(79, 79, 79)     -- literals
			}]]

			ui.highColors = {
				local_property  = Color3.fromRGB(255, 98, 138),   -- rosa/rosso AI (proprietà locali, parole chiave)
				function_color  = Color3.fromRGB(255, 198, 91),   -- oro caldo per funzioni
				local_color     = Color3.fromRGB(223, 141, 255),  -- lavanda neon (variabili locali)
				self_color      = Color3.fromRGB(255, 105, 180),  -- rosa shocking (self)
				self_call       = Color3.fromRGB(255, 120, 150),  -- rosso AI soft per :call
				operator        = Color3.fromRGB(255, 92, 92),    -- rosso vivo Arceus per simboli `=`, `+`, ecc.
				comment         = Color3.fromRGB(149, 157, 185),  -- grigio violaceo AI-style per commenti
				boolean         = Color3.fromRGB(255, 128, 64),   -- arancio vibrante per `true` / `false`
				numbers         = Color3.fromRGB(122, 255, 180),  -- verde acqua (contrasto neon leggibile)
				call            = Color3.fromRGB(120, 185, 255),  -- azzurro brillante per chiamate funzione
				rbx             = Color3.fromRGB(185, 130, 255),  -- viola Arceus/Roblox
				lua             = Color3.fromRGB(140, 255, 230),  -- turchese AI (per `Instance`, tipi, ecc.)
				str             = Color3.fromRGB(255, 105, 140),  -- rosa caldo per stringhe `"text"`
				null            = Color3.fromRGB(90, 90, 90)      -- grigio neutro scuro per `nil`
			}

			framework.settings:GetSettingChangedSignal("Colors_Primary"):Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(value: string, default: string)
				local succ, err = pcall(Color3.fromHex, value)
				value = succ and err or Color3.fromHex(default)

				-- set

				editor:SetHighlighterColors(ui.highColors)
			end)))
		end
	end

	do -- track player
		local trackplayer = framework.dependencies.track
		local timing = ui:Get("TrackTime").instance
		local audio = ui:AddInstance("Sound", {
			Id = "SoundTrack"
		})

		trackplayer:Connect(audio)
		local slider = framework.utils.inputs.sliders.horizontal({ui:Get("TrackSlider")}, 0)
		slider.OnPercentageChanged:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(percent: number)
			trackplayer:SetTime(trackplayer:GetLenght() *percent)
		end)))

		trackplayer.OnTimeUpdated:Connect(framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function()
			local text, percent = trackplayer:GetTiming()
			slider:SetPercentage(percent, true)
			timing.Text = text
		end)))

		task.spawn(function()
			trackplayer:Play(102518604969857)
			trackplayer:Stop()
		end)
	end
	
	framework.utils.http.OnUrlOpened:Connect(framework.protected:GCProtect(function(url)
		framework.utils.clipboard:Set(url)
		
		utils:ShowToast("ButtonToast", {
			AdditionalText = {"Link copied to clipboard","Link copiato negli appunti","Liên kết đã sao chép vào khay nhớ tạm","Link copiado para a área de transferência","Tautan disalin ke clipboard","Ссылка скопирована в буфер обмена","Link in die Zwischenablage kopiert","Enlace copiado al portapapeles","Lien copié dans le presse-papiers","链接已复制到剪贴板","リンクがクリップボードにコピーされました","تم نسخ الرابط إلى الحافظة","लिंक क्लिपबोर्ड में कॉपी किया गया","ลิงก์ถูกคัดลอกไปยังคลิปบอร์ด"},
			AdditionalTitle = {"Link copied","Link copiato","Liên kết đã sao chép","Enlace copiado","Tautan disalin","Ссылка скопирована","Link kopiert","Link copiado","Lien copié","链接已复制","リンクをコピーしました","تم نسخ الرابط","लिंक कॉपी किया गया","คัดลอกลิงก์แล้ว"}
		})
	end))

	---------------------------------------------------

	local animator = framework.animator
	local aiColors = {
		{255, 0, 0},
		{255, 56, 105},
		{244, 115, 236},
		{21, 166, 254},
		{255, 56, 105},
		{255, 0, 0},
	}

	local getScaleFactor = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(resolution)
		return framework.utils.maths.min(resolution.X, resolution.Y) /utils:GetAnimationResolution("High").X
	end))

	local smoothstep = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(edge0, edge1, x)
		local t = framework.utils.maths.clamp((x -edge0) /(edge1 -edge0), 0, 1)
		return t *t *(3 -2 *t)
	end))

	local function sdRounded(px, py, L, T, R, B, cr)
		local dx = math.max(L+cr - px, 0, px - (R-cr))
		local dy = math.max(T+cr - py, 0, py - (B-cr))
		local outd = math.sqrt(dx*dx + dy*dy) - cr
		if dx==0 and dy==0 then
			return -math.min(px - L, R - px, py - T, B - py)
		end
		return outd
	end

	local getPaletteColor = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(p)
		local n = #aiColors
		local seg = p *n
		local i1 = framework.utils.maths.floor(seg) %n
		local i2 = (i1 +1) %n
		local frac = seg -framework.utils.maths.floor(seg)
		local c1 = aiColors[i1 +1]
		local c2 = aiColors[i2 +1]
		local r = c1[1] * (1 -frac) +c2[1] *frac
		local g = c1[2] * (1 -frac) +c2[2] *frac
		local b = c1[3] * (1 -frac) +c2[3] *frac
		return r, g, b
	end))

	local sdfRoundedRect = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(px, py, w, h, cornerRadius)
		local cx = (px +.5) -w/2
		local cy = (py +.5) -h/2
		local rx = w/2 - cornerRadius
		local ry = h/2 - cornerRadius
		if rx < 0 then rx = 0 end
		if ry < 0 then ry = 0 end
		local dx = framework.utils.maths.abs(cx) -rx
		local dy = framework.utils.maths.abs(cy) -ry
		local outsideDist = framework.utils.maths.sqrt(framework.utils.maths.max(dx, 0)^2 + framework.utils.maths.max(dy, 0)^2)
		local insideDist  = framework.utils.maths.min(framework.utils.maths.max(dx, dy), 0)
		return outsideDist + insideDist - cornerRadius
	end))

	-- TOAST BACKGROUND GLOW ANIMATION (COMMENTED)
	do
		--	local image = ui:Get("ToastGlow")

		--	-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		--	local settings = {
		--		CornerRadiusRatio = .035,  -- Percentuale del lato più corto
		--		InnerGlowRadius = 150,       -- In "pixel base" (a 128)
		--		GlowSoftnessExponent = 30,
		--		GlowExtraAlpha = 10,
		--		GlowColor = { r = 255, g = 255, b = 255 },
		--		BackgroundAlpha = .15*255,
		--		UseMultiColorGlow = false,
		--		SwirlSpeed = 1,
		--		GlowPulseAmplitude = .5,
		--		GlowPulseFrequency = .5,
		--		LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		--	}

		--	-- Aggiungiamo l'animazione tramite il framework
		--	utils:AddAnimation(image.id, {
		--		Outputs = { image.instance },
		--		Duration = 2.5,
		--		Resolution = Vector2.new(128, 72),

		--		RenderOnLoad = true,

		--	}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
		--		local w, h = resolution.X, resolution.Y
		--		local TWO_PI = framework.utils.maths.pi *2
		--		local t = (frameIndex / totalFrames) *TWO_PI

		--		local scaleFactor = getScaleFactor(resolution)
		--		local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

		--		animator.computePixels(resolution, function(idx, x, y)
		--			-- Calcola la distanza dal bordo del rettangolo arrotondato
		--			local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
		--			local d = framework.utils.maths.abs(shapeDist)

		--			-- Applica la scala ai parametri in pixel
		--			local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

		--			-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
		--			local effectiveInnerGlowRadius = scaledInnerGlow
		--			if x < (w / 2) and settings.LeftGlowBoost>0 then
		--				local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
		--				effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
		--			end

		--			-- Calcola il fattore di glow in modo adattivo
		--			local factor = 0
		--			if d < effectiveInnerGlowRadius then
		--				factor = 1 - (d / effectiveInnerGlowRadius)
		--			end

		--			local baseFade = factor ^ settings.GlowSoftnessExponent
		--			local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
		--			local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

		--			local r, g, b
		--			if settings.UseMultiColorGlow then
		--				local cx = (x + .5) - (w / 2)
		--				local cy = (y + .5) - (h / 2)
		--				local angle = framework.utils.maths.atan2(cy, cx)
		--				local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
		--				swirl = swirl - framework.utils.maths.floor(swirl)
		--				local rr, gg, bb = getPaletteColor(swirl)
		--				r = rr * finalFade
		--				g = gg * finalFade
		--				b = bb * finalFade
		--			else
		--				r = settings.GlowColor.r * finalFade
		--				g = settings.GlowColor.g * finalFade
		--				b = settings.GlowColor.b * finalFade
		--			end

		--			local baseAlpha = settings.BackgroundAlpha
		--			local glowAlpha = finalFade * settings.GlowExtraAlpha
		--			local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

		--			writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
		--				framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
		--		end)
		--	end)))
	end


	-- UI STARTING SCREEN BACKGROUND ANIMATION (COM)
	do
		local image = ui:Get("StartingScreen")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .035,  -- Percentuale del lato più corto
			InnerGlowRadius = 3555,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 150,
			GlowExtraAlpha = 20,
			GlowColor = { r = 255, g = 0, b = 0 },
			BackgroundAlpha = .75*255,
			UseMultiColorGlow = true,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .5,
			GlowPulseFrequency = .5,
			LeftGlowBoost = 5, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance },
			Duration = 4,
			Resolution = Vector2.new(128, 72),

			RenderOnLoad = true

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	-- INIT BACKGROUND ANIMATION
	if not framework.protected:IsStudio() then
		local image = ui:Get("BackgroundOverlay")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .035,  -- Percentuale del lato più corto
			InnerGlowRadius = 255,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 30,
			GlowExtraAlpha = 33,
			GlowColor = { r = 255, g = 0, b = 0 },
			BackgroundAlpha = .5*255,
			UseMultiColorGlow = true,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .5,
			GlowPulseFrequency = 1,
			LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance },
			Duration = 2.5,
			Resolution = Vector2.new(128, 72),
			--RenderOnLoad = true,

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	-- UI BACKGROUND ANIMATION
	do
		local image = ui:Get("BackgroundGlow")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .1,  -- Percentuale del lato più corto
			InnerGlowRadius = 255,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 30,
			GlowExtraAlpha = 33,
			GlowColor = { r = 255, g = 255, b = 255 },
			BackgroundAlpha = .75*255,
			UseMultiColorGlow = true,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .5,
			GlowPulseFrequency = 1,
			LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance },
			Duration = 2.5,
			Resolution = Vector2.new(128, 72),

			--RenderOnLoad = true,
			Tags = {"MainFrame"}

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	if framework.protected:IsStudio() then
		local image = ui:Get("AnimatedWallpaper")

		-- Single-color mode: una sola tonalità per un look ultra-clean
		local color = {0, 0, 0}  -- puoi cambiare qui il colore [R,G,B]

		-- Loop e noise
		local durationSeconds = 14
		local noiseScale      = 1.5
		local offsetScale     = 1.2
		local alphaMax        = 90
		local gamma           = 1.0

		-- Funzione smoothstep
		local function smoothstep(x)
			return x*x*(3 - 2*x)
		end

		utils:AddAnimation(image.id, {
			Outputs    = { image.instance },
			Duration   = durationSeconds,
			Tags       = { "MainFrame" },
			Resolution = Vector2.new(128, 72)
		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, res, frameIndex, totalFrames)
			local w, h   = res.X, res.Y
			local tNorm  = (frameIndex % totalFrames) / totalFrames
			local angle  = 2 * math.pi * tNorm
			local ox     = math.cos(angle) * offsetScale
			local oy     = math.sin(angle) * offsetScale

			-- 2×2 antialiasing offsets
			local offs = {0.25, 0.75}

			animator.computePixels(res, function(idx, x, y)
				if idx < 0 or idx+3 >= w*h*4 then return end

				-- media di 4 campioni per pixel (supersampling)
				local acc = 0
				for _, sx in ipairs(offs) do
					for _, sy in ipairs(offs) do
						local nx = (x + sx) / w * noiseScale + ox
						local ny = (y + sy) / h * noiseScale + oy
						acc = acc + ((math.noise(nx, ny, 0) * 0.5) + 0.5)
					end
				end
				local v = acc * 0.25       -- valore medio [0,1]
				-- gamma + smoothstep per un contrasto molto dolce
				local s = smoothstep(v^gamma)

				-- alpha e colore
				local a = math.floor(s * alphaMax + 0.5)
				if a == 0 then return end  -- risparmio calcolo

				local r = math.floor(color[1] * 255 + 0.5)
				local g = math.floor(color[2] * 255 + 0.5)
				local b = math.floor(color[3] * 255 + 0.5)

				writePixel(idx, r, g, b, a)
			end)
		end)))
	end

	-- SLIDERS CONTAINER, PROFILE PANEL AND BEST SCRIPTS PANEL ANIMATION
	do
		local image, image2, image3, image4, image5, image6 = ui:Get("SlidersContainerBackground"), ui:Get("ProfilePanelBackground"), ui:Get("HomeTipBackground"), ui:Get("BestScriptsPanelBackground"), ui:Get("AITipsPanelBackground"), ui:Get("AIChatPanelBackgroundOverlay")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .11,  -- Percentuale del lato più corto
			InnerGlowRadius = 255,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 30,
			GlowExtraAlpha = 50,
			GlowColor = { r = 0, g = 0, b = 0 },
			BackgroundAlpha = .45*255,
			UseMultiColorGlow = false,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .2,
			GlowPulseFrequency = 1,
			LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance, image2.instance, image3.instance, image4.instance, image5.instance, image6.instance },
			Duration = 2.5,

			--RenderOnLoad = true,
			Tags = {"MainFrame"}

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	--[[ ANIMAZIONE SLIDER VERTICALE CON PULSING GLOW, PADDING SEPARATO & DROP/INNER SHADOW (0→100%)
	do
		local animator = framework.animator
		local image, image2, image3 = ui:Get("Slider_Gravity"), ui:Get("Slider_Jump"), ui:Get("Slider_Speed")

		local settings = {
			-- colore e smussatura
			baseColor           = {1, 1, 1},
			cornerRadius        = .7,
			paddingLeftPx       = 8.5,
			paddingRightPx      = 9.5,
			paddingTopPx        = 15.5,
			paddingBottomPx     = 16.5,
			shadowOffsetPx      = { x = 0, y = 0 },
			shadowRadiusPx      = 8,
			shadowColor         = {1, 1, 1},
			shadowOpacity       = .4,
			glowFrequency       = 0,
			glowIntensity       = .5,
			innerShadowRadiusPx = 12.5,
			innerShadowColor    = {0, 0, 0},
			innerShadowOpacity  = .35,
			bodyAlpha           = 255,
		}

		local resW, resH = 54, 169

		-- helper per hit-test su rounded rect
		local pointInRounded = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(px, py, L, T, R, B, cr)
			if px >= L+cr and px <= R-cr and py >= T and py <= B then return true end
			if py >= T+cr and py <= B-cr and px >= L and px <= R then return true end
			local corners = {{x=L+cr,y=T+cr},{x=R-cr,y=T+cr},{x=L+cr,y=B-cr},{x=R-cr,y=B-cr}}
			for _,c in ipairs(corners) do
				local dx, dy = px-c.x, py-c.y
				if dx*dx+dy*dy <= cr*cr then return true end
			end
			return false
		end))

		local frameGen = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local tNorm = (frameIndex-1)/(totalFrames-1)

			-- container bounds e raggio
			local L, R  = settings.paddingLeftPx,  w - settings.paddingRightPx
			local T0, B0 = settings.paddingTopPx,  h - settings.paddingBottomPx
			local effCr  = settings.cornerRadius * framework.utils.maths.min(R-L, B0-T0) * .5

			-- fill height
			local fillTop = B0 - tNorm * (B0 - T0)
			local regionH = B0 - fillTop

			-- parametri glow/shadow
			local shOffX, shOffY = settings.shadowOffsetPx.x, settings.shadowOffsetPx.y
			local shR            = settings.shadowRadiusPx
			local scR,scG,scB    = settings.shadowColor[1]*255, settings.shadowColor[2]*255, settings.shadowColor[3]*255
			local glow           = (framework.utils.maths.sin(2 *framework.utils.maths.pi *settings.glowFrequency *tNorm)+1)*.5 *settings.glowIntensity
			local baseShadowOp   = settings.shadowOpacity

			-- parametri inner shadow
			local inR            = settings.innerShadowRadiusPx
			local iscR,iscG,iscB = settings.innerShadowColor[1]*255, settings.innerShadowColor[2]*255, settings.innerShadowColor[3]*255

			animator.computePixels(resolution, function(idx, px, py)
				local Rf, Gf, Bf, Af = 0,0,0,0

				-- DROP SHADOW + GLOW: bordo del container ma visibile solo nella regione di fill
				if regionH > 0 and py >= fillTop - settings.shadowRadiusPx then
					local shOpEff = baseShadowOp + glow
					-- distance to container rounded rect edge
					local dx, dy = 0, 0
					local offL = L + effCr + shOffX
					local offR = R - effCr + shOffX
					local offT = T0 + effCr + shOffY
					local offB = B0 - effCr + shOffY
					if px < offL then dx = offL - px elseif px > offR then dx = px - offR end
					if py < offT then dy = offT - py elseif py > offB then dy = py - offB end
					local dRect = (dx>0 and dy>0) and framework.utils.maths.sqrt(dx*dx+dy*dy) or framework.utils.maths.max(dx,dy)
					local distToContainer = dRect - effCr
					if distToContainer > 0 and distToContainer < shR then
						-- clipping all'esterno del container extended by shadowRadius
						if pointInRounded(px,py, L-shR, T0-shR, R+shR, B0+shR, effCr+shR) then
							local alpha = shOpEff * (1 - distToContainer/shR)
							Rf = Rf + scR * alpha; Gf = Gf + scG * alpha; Bf = Bf + scB * alpha
							Af = framework.utils.maths.max(Af, framework.utils.maths.floor(alpha*255))
						end
					end
				end

				-- FILL principale (solo se c’è realmente fill)
				if regionH > 0 and py >= fillTop - settings.shadowRadiusPx and pointInRounded(px,py, L, T0, R, B0, effCr) then
					local dC = sdRounded(px, py, L, T0, R, B0, effCr)
					-- cov=1 per tutti i pixel interiori, fade su ~1px al bordo
					local covF = smoothstep(1*.5, -1*.5, dC)
					if covF > 0 then
						Rf = settings.baseColor[1]*255
						Gf = settings.baseColor[2]*255
						Bf = settings.baseColor[3]*255
						Af = framework.utils.maths.max(Af, framework.utils.maths.floor(settings.bodyAlpha * covF + .5))
					end
				end

				-- INNER SHADOW sul fill
				if regionH > 0 and py >= fillTop - settings.shadowRadiusPx and pointInRounded(px,py, L, T0, R, B0, effCr) then
					local dmin = framework.utils.maths.min(px-L, R-px, py-fillTop, B0-py)
					local dC2 = sdRounded(px, py, L, fillTop, R, B0, effCr)
					if dC2 > -inR and dmin < inR then
						local distInside = -framework.utils.maths.min(dC2, 0)
						local alpha = settings.innerShadowOpacity * (1 - distInside/inR)
						Rf = Rf*(1 - alpha) + iscR*alpha
						Gf = Gf*(1 - alpha) + iscG*alpha
						Bf = Bf*(1 - alpha) + iscB*alpha
						Af = framework.utils.maths.max(Af, framework.utils.maths.floor(alpha*255))
					end
				end

				writePixel(idx,
					framework.utils.maths.clamp(framework.utils.maths.floor(Rf+.5),0,255),
					framework.utils.maths.clamp(framework.utils.maths.floor(Gf+.5),0,255),
					framework.utils.maths.clamp(framework.utils.maths.floor(Bf+.5),0,255),
					framework.utils.maths.clamp(framework.utils.maths.floor(Af+.5),0,255))
			end)
		end))

		local a = utils:AddAnimation(image.id, {
			Resolution = Vector2.new(resW, resH),
			Outputs = {image.instance},
			Duration = 2.5
		}, frameGen)--:Generate()

		utils:AddAnimation(image2.id, {
			Resolution = Vector2.new(resW, resH),
			Outputs = {image2.instance},
			Duration = 2.5,
		}, frameGen)

		utils:AddAnimation(image3.id, {
			Resolution = Vector2.new(resW, resH),
			Outputs = {image3.instance},
			Duration = 2.5
		}, frameGen)
	end]]

	-- PROFILE OVERLAY ANIMATION
	do
		local animator = framework.animator
		local image, image2= ui:Get("PFPOverlay"), ui:Get("PFPOverlay2")

		-- Parametri di personalizzazione (unità base per una risoluzione di riferimento 128×128)
		local settings = {
			-- Impostazioni per l'inner glow (rosso)
			GlowColor = { r = 255, g = 255, b = 255 },
			BackgroundAlpha = 0,            -- nessun background solido
			GlowExtraAlpha = 100,
			GlowSoftnessExponent = 5,
			InnerGlowRadius = 150,          -- valore base in pixel (per risoluzione base 128)
			Margin = 0,                  

			-- Corner radius personalizzati (in pixel base; verranno scalati)
			CornerRadius = {
				topLeft = 50,
				topRight = 50,
				bottomRight = 50,
				bottomLeft = 50,
			},

			-- Parametri di pulsazione
			GlowPulseAmplitude = .3,
			GlowPulseFrequency = 1,
		}

		-- SDF per un rettangolo con corner radii differenti
		local sdfRoundedRectMulti = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(px, py, w, h, radii)
			local cx = px - w/2
			local cy = py - h/2
			local r = 0

			if cx < 0 and cy < 0 then
				r = radii.topLeft
			elseif cx >= 0 and cy < 0 then
				r = radii.topRight
			elseif cx >= 0 and cy >= 0 then
				r = radii.bottomRight
			else
				r = radii.bottomLeft
			end

			local qx = framework.utils.maths.abs(cx) - (w/2 - r)
			local qy = framework.utils.maths.abs(cy) - (h/2 - r)
			local outside = framework.utils.maths.sqrt(framework.utils.maths.max(qx, 0)^2 + framework.utils.maths.max(qy, 0)^2)
			local inside = framework.utils.maths.min(framework.utils.maths.max(qx, qy), 0)
			return outside + inside - r
		end))

		-- Helper: distanza da un punto a un segmento (con proiezione clamped)
		local segmentDistance = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(p, v1, v2)
			local vx = v2.x - v1.x
			local vy = v2.y - v1.y
			local wx = p.x - v1.x
			local wy = p.y - v1.y
			local dot = vx * wx + vy * wy
			local lenSq = vx * vx + vy * vy
			local t = framework.utils.maths.clamp(dot / lenSq, 0, 1)
			local proj = { x = v1.x + t * vx, y = v1.y + t * vy }
			local dx = p.x - proj.x
			local dy = p.y - proj.y
			return framework.utils.maths.sqrt(dx * dx + dy * dy)
		end))

		-- Registra l'animazione per il SideNavButton
		utils:AddAnimation(image.id, {
			Outputs = { image.instance, image2.instance },
			Duration = 2.5,

			--RenderOnLoad = true,
			Tags = {"MainFrame"}

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi * 2
			local t = (frameIndex / totalFrames) * TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local inset = (settings.Margin or .05) * framework.utils.maths.min(w, h)
			local containerX = inset
			local containerY = inset
			local containerW = w -2 *inset
			local containerH = h -2 *inset

			local scaledRadii = {
				topLeft = settings.CornerRadius.topLeft *scaleFactor,
				topRight = settings.CornerRadius.topRight *scaleFactor,
				bottomRight = settings.CornerRadius.bottomRight *scaleFactor,
				bottomLeft = settings.CornerRadius.bottomLeft *scaleFactor,
			}

			local scaledInnerGlow = settings.InnerGlowRadius *scaleFactor
			local centerX = containerX +containerW /2
			local centerY = containerY +containerH /2

			-- Funzione per calcolare il fade del background (inner glow) nel container
			local function getBackgroundFade(x, y)
				local px = x + .5 - containerX
				local py = y + .5 - containerY
				local sdf = sdfRoundedRectMulti(px, py, containerW, containerH, scaledRadii)
				local d = framework.utils.maths.abs(sdf)
				local f = 0
				if d < scaledInnerGlow then
					f = 1 - (d / scaledInnerGlow)
				end
				local baseFade = f ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				return framework.utils.maths.clamp(baseFade * pulse, 0, 1)
			end

			animator.computePixels(resolution, function(idx, x, y)
				local fade = getBackgroundFade(x, y)
				local r_bg = (settings.GlowColor.r or 0) / 255 * fade
				local g_bg = (settings.GlowColor.g or 0) / 255 * fade
				local b_bg = (settings.GlowColor.b or 0) / 255 * fade
				local alpha_bg = framework.utils.maths.clamp(settings.BackgroundAlpha + fade * settings.GlowExtraAlpha, 0, 255)
				local finalR, finalG, finalB, finalA = r_bg, g_bg, b_bg, alpha_bg

				writePixel(idx,
					framework.utils.maths.clamp(framework.utils.maths.floor(finalR * 255 + .5), 0, 255),
					framework.utils.maths.clamp(framework.utils.maths.floor(finalG * 255 + .5), 0, 255),
					framework.utils.maths.clamp(framework.utils.maths.floor(finalB * 255 + .5), 0, 255),
					finalA)
			end)
		end)))
	end

	-- AI PANEL ANIMATION
	do
		local image = ui:Get("AIPanelBackgroundOverlay")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .3,  -- Percentuale del lato più corto
			InnerGlowRadius = 255,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 20,
			GlowExtraAlpha = 50,
			GlowColor = { r = 255, g = 0, b = 0 },
			BackgroundAlpha = .35*255,
			UseMultiColorGlow = true,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .2,
			GlowPulseFrequency = 1,
			LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance },
			Duration = 4,
			Resolution = Vector2.new(128, 28),

			--RenderOnLoad = true,
			Tags = {"MainFrame"}

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	-- AI PLAYER ANIMATION
	do
		local image = ui:Get("AIPlayerBackgroundOverlay")

		-- Parametri di personalizzazione (in unità per la risoluzione base, ad es. 128)
		local settings = {
			CornerRadiusRatio = .155,  -- Percentuale del lato più corto
			InnerGlowRadius = 255,       -- In "pixel base" (a 128)
			GlowSoftnessExponent = 30,
			GlowExtraAlpha = 50,
			GlowColor = { r = 255, g = 255, b = 255 },
			BackgroundAlpha = .45*255,
			UseMultiColorGlow = false,
			SwirlSpeed = 1,
			GlowPulseAmplitude = .5,
			GlowPulseFrequency = 1,
			LeftGlowBoost = 1, -- Moltiplicatore per il glow a sinistra (1 = nessun boost)
		}

		-- Aggiungiamo l'animazione tramite il framework
		utils:AddAnimation(image.id, {
			Outputs = { image.instance },
			Duration = 2.5,

			--RenderOnLoad = true,
			Tags = {"MainFrame"}

		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			local TWO_PI = framework.utils.maths.pi *2
			local t = (frameIndex / totalFrames) *TWO_PI

			local scaleFactor = getScaleFactor(resolution)
			local effectiveCornerRadius = framework.utils.maths.min(w, h) * settings.CornerRadiusRatio

			animator.computePixels(resolution, function(idx, x, y)
				-- Calcola la distanza dal bordo del rettangolo arrotondato
				local shapeDist = sdfRoundedRect(x, y, w, h, effectiveCornerRadius)
				local d = framework.utils.maths.abs(shapeDist)

				-- Applica la scala ai parametri in pixel
				local scaledInnerGlow = settings.InnerGlowRadius * scaleFactor

				-- Se il pixel è nella metà sinistra, applica un boost (sempre scalato)
				local effectiveInnerGlowRadius = scaledInnerGlow
				if x < (w / 2) and settings.LeftGlowBoost>0 then
					local leftMultiplier = 1 + (settings.LeftGlowBoost - 1) * (1 - (x / (w / 2)))
					effectiveInnerGlowRadius = scaledInnerGlow * leftMultiplier
				end

				-- Calcola il fattore di glow in modo adattivo
				local factor = 0
				if d < effectiveInnerGlowRadius then
					factor = 1 - (d / effectiveInnerGlowRadius)
				end

				local baseFade = factor ^ settings.GlowSoftnessExponent
				local pulse = 1 + settings.GlowPulseAmplitude * framework.utils.maths.sin(settings.GlowPulseFrequency * t)
				local finalFade = framework.utils.maths.clamp(baseFade * pulse, 0, 1)

				local r, g, b
				if settings.UseMultiColorGlow then
					local cx = (x + .5) - (w / 2)
					local cy = (y + .5) - (h / 2)
					local angle = framework.utils.maths.atan2(cy, cx)
					local swirl = (angle / TWO_PI) + (settings.SwirlSpeed * t / TWO_PI)
					swirl = swirl - framework.utils.maths.floor(swirl)
					local rr, gg, bb = getPaletteColor(swirl)
					r = rr * finalFade
					g = gg * finalFade
					b = bb * finalFade
				else
					r = settings.GlowColor.r * finalFade
					g = settings.GlowColor.g * finalFade
					b = settings.GlowColor.b * finalFade
				end

				local baseAlpha = settings.BackgroundAlpha
				local glowAlpha = finalFade * settings.GlowExtraAlpha
				local alpha = framework.utils.maths.clamp(baseAlpha + glowAlpha, 0, 255)

				writePixel(idx, framework.utils.maths.floor(r + .5), framework.utils.maths.floor(g + .5),
					framework.utils.maths.floor(b + .5), framework.utils.maths.floor(alpha + .5))
			end)
		end)))
	end

	-- ANIMAZIONE AIIcon CON GLOW GRADUALE E SMOOTH LOOP
	do
		local animator      = framework.animator
		local image, image2 = ui:Get("AIIcon"), ui:Get("AIIcon2")

		local aiColors = {
			{1,   0,   0},
			{1, 0.22,0.41},
			{0.96,0.45,0.93},
			{0.08,0.65,1},
			{1, 0.22,0.41},
		}

		local settings = {
			coordScale           = 1.3,
			colorMode            = "freeform",
			freeformColors       = {
				{x=-.6,y=-.3,color={1,0,0}},
				{x= .6,y=-.2,color={1,0.22,0.41}},
				{x=-.4,y=.6, color={0.96,0.45,0.93}},
				{x= .4,y=.7, color={0.08,0.65,1}},
			},
			-- pulsazioni e rotazioni cicliche
			colorPulse           = 2,    -- 2 pulsazioni in 2.5s
			colorRotationSpeed   = 1,    -- 1 rotazione in 2.5s

			waveBase             = .9,
			waveRange            = .02,
			freq1                = 2,
			freq2                = 1,
			freq3                = 3,

			glowRange            = .35,
			secondaryGlowFactor  = 1,
			glowMaxAlpha         = .5,
			bodyMaxAlpha         = 200,

			innerShadowWidth     = .5,
			blurSigma            = .7,
		}

		local AA = 1 / settings.coordScale
		local function fract(x)     return x - math.floor(x) end
		local function clamp(x,a,b) return x<a and a or (x>b and b or x) end
		local function smoothstep(e0,e1,x)
			local t = clamp((x-e0)/(e1-e0),0,1)
			return t*t*(3-2*t)
		end

		-- colore freeform con rotazione e blur
		local getFreeformColor = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(tNorm, nx, ny)
			local tAngle = tNorm * 2*math.pi
			local ang     = tAngle * settings.colorRotationSpeed
			local cosA, sinA = framework.utils.maths.cos(ang), framework.utils.maths.sin(ang)
			local sumW,sumR,sumG,sumB=0,0,0,0
			for _, a in ipairs(settings.freeformColors) do
				local ax = a.x * cosA - a.y * sinA
				local ay = a.x * sinA + a.y * cosA
				local dx, dy = nx-ax, ny-ay
				local wght = math.exp(-(dx*dx+dy*dy)/(2*settings.blurSigma^2))
				sumW = sumW + wght
				sumR = sumR + a.color[1]*wght
				sumG = sumG + a.color[2]*wght
				sumB = sumB + a.color[3]*wght
			end
			local r,g,b = sumR/sumW, sumG/sumW, sumB/sumW
			-- leggera pulsazione di saturazione
			local pulse = 0.5 + 0.5*framework.utils.maths.sin(tAngle*settings.colorPulse/2)  -- due volte più lenta
			local mix   = 0.8 + 0.2*pulse
			return clamp(r*mix,0,1), clamp(g*mix,0,1), clamp(b*mix,0,1)
		end))

		utils:AddAnimation(image.id .. "_SmoothGlowAI", {
			Outputs      = { image.instance, image2.instance },
			RenderOnLoad = true,
			Duration     = 2.5,
			Tags         = {"MainFrame"},
		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w,h    = resolution.X, resolution.Y
			local tNorm  = (frameIndex-1)/totalFrames
			local tAngle = tNorm * 2*math.pi

			animator.computePixels(resolution, function(idx, px, py)
				local nx = (((px+.5)/w)*2-1)*settings.coordScale
				local ny = (((py+.5)/h)*2-1)*settings.coordScale
				local dist = framework.utils.maths.sqrt(nx^2+ny^2)
				local angD = framework.utils.maths.atan2(ny,nx)

				-- raggio ondulato
				local waveR = settings.waveBase
					+ settings.waveRange*.5 * framework.utils.maths.sin(tAngle*settings.freq1 + angD*3)
					+ settings.waveRange*.3 * framework.utils.maths.sin(tAngle*settings.freq2 - angD*2)
					+ settings.waveRange*.2 * framework.utils.maths.sin(tAngle*settings.freq3 + angD*5)
				waveR = framework.utils.maths.clamp(waveR, .1, 1.1)

				local R,G,B,A = 0,0,0,0
				if dist < waveR + settings.glowRange then
					-- colore
					R,G,B = getFreeformColor(tNorm, nx, ny)

					if dist < waveR then
						-- corpo pieno
						A = settings.bodyMaxAlpha
					else
						-- **pulsazione glow graduale**: uso una sin modulata per rendere il fade dolce
						local glowFrac = (dist - waveR) / settings.glowRange
						local baseAlpha = (1 - glowFrac) * settings.glowMaxAlpha
						local pulseGlow = 0.5 + 0.5 * framework.utils.maths.sin(tAngle * 0.5)  -- mezza velocità
						local alphaF = baseAlpha * pulseGlow
						A = framework.utils.maths.floor(alphaF * 255 + 0.5)
					end
				end

				writePixel(idx,
					framework.utils.maths.clamp(math.floor(R*255+.5),0,255),
					framework.utils.maths.clamp(math.floor(G*255+.5),0,255),
					framework.utils.maths.clamp(math.floor(B*255+.5),0,255),
					A
				)
			end)
		end)))
	end

	-- CLOSE/MAXIMIZE BUTTON ORB LOOP INFINITO E SMOOTH
	do
		local animator = framework.animator
		local image, image2 = ui:Get("CloseButton"), ui:Get("MaximizeButton")

		local settings = {
			coordScale   = 2,
			baseColor    = {1, 1, 1},
			waveBase     = .9,
			waveRange    = .035,
			-- Frequenze in cicli interi per un loop seamless
			freq1        = 2,     -- 2 oscillazioni complete
			freq2        = 1,     -- 1 oscillazione completa
			freq3        = 4,     -- 4 oscillazioni complete
			glowRange    = .4,
			glowMaxAlpha = .5,
			bodyMaxAlpha = 200,
		}

		local AA = 1 / settings.coordScale

		local function sdCircle(nx, ny, r)
			return math.sqrt(nx*nx + ny*ny) - r
		end

		local function smoothstep(e0, e1, x)
			local t = math.clamp((x - e0) / (e1 - e0), 0, 1)
			return t * t * (3 - 2*t)
		end

		utils:AddAnimation(image.id .. "_LoopOrb", {
			Outputs      = { image.instance, image2.instance },
			RenderOnLoad = true,
			Duration     = 2.5,
		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h   = resolution.X, resolution.Y
			-- tNorm ∈ [0,1), tAngle ∈ [0,2π)
			local tNorm  = (frameIndex - 1) / totalFrames
			local tAngle = tNorm * (2 * math.pi)

			animator.computePixels(resolution, function(idx, px, py)
				-- coords normalize [-1,1]
				local nx = (((px + .5) / w) * 2 - 1) * settings.coordScale
				local ny = (((py + .5) / h) * 2 - 1) * settings.coordScale

				-- dynamic radius with integer-cycle sine
				local angle = framework.utils.maths.atan2(ny, nx)
				local waveR = settings.waveBase
					+ settings.waveRange * .5 * framework.utils.maths.sin(tAngle * settings.freq1 + angle * 3)
					+ settings.waveRange * .3 * framework.utils.maths.sin(tAngle * settings.freq2 - angle * 2)
					+ settings.waveRange * .2 * framework.utils.maths.sin(tAngle * settings.freq3 + angle * 5)
				waveR = framework.utils.maths.clamp(waveR, .1, 1.1)

				local d = sdCircle(nx, ny, waveR)

				-- colore fisso bianco
				local r, g, b = settings.baseColor[1], settings.baseColor[2], settings.baseColor[3]

				-- body coverage
				local covBody = smoothstep(AA * .5, -AA * .5, d)
				local alphaBody = covBody * (settings.bodyMaxAlpha / 255)

				-- glow coverage & pulsazione
				local covGlow = 0
				if d > 0 and d < settings.glowRange then
					covGlow = smoothstep(settings.glowRange + AA * .5, -AA * .5, d)
				end
				local pulseGlow = .5 + .5 * framework.utils.maths.sin(tAngle * 1)  -- 1 ciclo
				local alphaGlow = covGlow * settings.glowMaxAlpha * (.7 + .3 * pulseGlow)

				-- alpha finale = max(body, glow)
				local a = math.floor(framework.utils.maths.clamp(
					math.max(alphaBody, alphaGlow) * 255, 0, 255) + .5)

				writePixel(idx,
					framework.utils.maths.clamp(math.floor(r*255 + .5), 0, 255),
					framework.utils.maths.clamp(math.floor(g*255 + .5), 0, 255),
					framework.utils.maths.clamp(math.floor(b*255 + .5), 0, 255),
					a
				)
			end)
		end)))
	end

	-- ORB CONTRASTATO E LOOP INFINITO SEAMLESS
	if not framework.protected:IsStudio() then
		local animator = framework.animator
		local image, image2, image3, image4, image5, image6 =
			ui:Get("FloatingIcon"),
			ui:Get("SubIcon_Home"),
			ui:Get("SubIcon_Executor"),
			ui:Get("SubIcon_ScriptHub"),
			ui:Get("SubIcon_ArceusIntelligence"),
			ui:Get("SubIcon_Extensions")

		-- Palette AI normalizzata
		local aiColors = {
			{1,   0,   0},
			{1, 0.22, 0.41},
			{0.96, 0.45, 0.93},
			{0.08, 0.65, 1},
			{1, 0.22, 0.41},
		}

		local settings = {
			coordScale    = 1.0,
			-- adesso ogni oscillazione è 1 ciclo completo in 1 loop
			ringCount     = 3,
			ringWidth     = {0.03, 0.045, 0.06},
			ringSpeed     = {1,    2,     3    },  -- interi
			ringWaveAmp   = {0.03, 0.04,  0.05 },
			ringWaveFreq  = {2,    3,     4    },  -- interi
			glowRange     = 0.35,
			glowAlphaMax  = 0.65,
			bodyAlphaMax  = 255,
			particleCount = 80,
			particleSpeed = 0.8,
			particleSize  = 0.01,
			shadowWidth   = 0.15,
			vignetteAmp   = 0.6,
		}

		local AA = 1 / settings.coordScale
		local function fract(x) return x - math.floor(x) end
		local function clamp(x,a,b) return x<a and a or (x>b and b or x) end
		local function smoothstep(e0,e1,x)
			local t = clamp((x-e0)/(e1-e0),0,1)
			return t*t*(3-2*t)
		end
		local function hsv2rgb(h,s,v)
			local i = math.floor(h*6); local f = h*6 - i
			local p, q, t = v*(1-s), v*(1-s*f), v*(1-s*(1-f))
			i = i % 6
			if i==0 then return v,t,p
			elseif i==1 then return q,v,p
			elseif i==2 then return p,v,t
			elseif i==3 then return p,q,v
			elseif i==4 then return t,p,v
			else          return v,p,q end
		end

		utils:AddAnimation(image.id .. "_SeamlessOrb", {
			Outputs      = {
				image.instance,
				image2.instance,
				image3.instance,
				image4.instance,
				image5.instance,
				image6.instance
			},
			RenderOnLoad = true,
			Duration     = 5.0,   -- rimane 5s, ma tutto è sincronizzato
		}, framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function(writePixel, resolution, frameIndex, totalFrames)
			local w, h = resolution.X, resolution.Y
			-- tNorm [0,1), tAngle [0,2π)
			local tNorm  = (frameIndex-1) / totalFrames
			local tAngle = tNorm * (2 * math.pi)

			-- particelle frame-specifiche
			local particles = {}
			for i=1,settings.particleCount do
				local a = math.random() * 2 * math.pi
				local s = settings.particleSpeed * (0.5 + math.random() * 0.5)
				particles[i] = { vx = math.cos(a)*s, vy = math.sin(a)*s, life = math.random() }
			end

			animator.computePixels(resolution, function(idx, px, py)
				local ux = (px + .5)/w*2 - 1
				local uy = (py + .5)/h*2 - 1
				local nx, ny = ux * settings.coordScale, uy * settings.coordScale
				local r = math.sqrt(nx*nx + ny*ny)
				local angle = math.atan2(ny, nx)

				-- colore orb
				-- mf varia da 0→1→0 in un ciclo esatto
				local mf = 0.5 + 0.5 * math.sin(tAngle * 1)  -- 1 ciclo
				local ci = math.floor(mf * (#aiColors-1)) + 1
				local c0, c1 = aiColors[ci], aiColors[ci+1] or aiColors[1]
				local lerp = fract(mf * (#aiColors-1))
				local br = c0[1] + (c1[1]-c0[1])*lerp
				local bg = c0[2] + (c1[2]-c0[2])*lerp
				local bb = c0[3] + (c1[3]-c0[3])*lerp

				-- pulsazione: 1 ciclo perfetto in tNorm
				local pulse = 1 + 0.1 * math.sin(tAngle * 1)

				-- corpo
				local bodyCov = smoothstep(settings.ringWidth[1]*pulse,
					settings.ringWidth[1]*pulse - AA, r)
				local aBody = bodyCov * (settings.bodyAlphaMax/255)

				-- glow
				local glowCov = 0
				if r > settings.ringWidth[#settings.ringWidth]*pulse
					and r < settings.ringWidth[#settings.ringWidth]*pulse + settings.glowRange then
					glowCov = smoothstep(
						settings.ringWidth[#settings.ringWidth]*pulse + settings.glowRange,
						settings.ringWidth[#settings.ringWidth]*pulse,
						r
					)
				end
				local aGlow = glowCov * settings.glowAlphaMax

				-- anelli fluidi: ognuno completa N cicli in tNorm
				local aRings = 0
				for i=1,settings.ringCount do
					local w0    = settings.ringWidth[i]*pulse
					local phase = tAngle * settings.ringSpeed[i]
					local waveR = w0 + settings.ringWaveAmp[i] *
						math.sin( phase + r * settings.ringWaveFreq[i] )
					local cov = smoothstep(waveR + AA, waveR - AA, r)
					aRings = math.max(aRings, cov)
				end

				-- particelle
				local aPart = 0
				for _,p in ipairs(particles) do
					local pxn = p.vx * p.life * pulse
					local pyn = p.vy * p.life * pulse
					local dist = math.sqrt((nx-pxn)^2 + (ny-pyn)^2)
					if dist < settings.particleSize then
						aPart = math.max(aPart, (1-p.life)*p.life*5)
					end
				end

				-- ombra interna
				local shadow = smoothstep(settings.shadowWidth + AA,
					settings.shadowWidth - AA, r)
				local vign   = 1 - smoothstep(0.7,1.0,r) * settings.vignetteAmp

				-- composizione finale
				local alpha = math.max(aBody, aGlow, aRings, aPart)
				local cr    = br * vign * (1 - shadow*0.5)
				local cg    = bg * vign * (1 - shadow*0.5)
				local cb    = bb * vign * (1 - shadow*0.5)
				local a     = math.floor(clamp(alpha * 255,0,255)+0.5)

				writePixel(idx,
					clamp(math.floor(cr*255+.5),0,255),
					clamp(math.floor(cg*255+.5),0,255),
					clamp(math.floor(cb*255+.5),0,255),
					a
				)
			end)
		end)))
	end

	utils:EndSetup()
	ui.nextSize(framework.enums.WindowState.Base)

	ui.Loaded = true
	return ui
end

	framework.dependencies:Add("gui", framework.protected:ProtectTable(this))
end

do -- arceus intelligence
	local axintelligence, customCmds = {}, framework.protected:GCProtect({})
	local arcyTable = framework.protected:GCProtect({})
	local lastPrompt, gameInfos = "", "; The following are information about the current game's place the user is playing:"
		..`- Place Id: {game.PlaceId}, use this to determinate the place's id`
		..`- Game Id: {game.GameId}, use this to determinate the game's id`
	
	task.spawn(function()
		local market = framework.protected:GetService("MarketplaceService")
		local succ, err = pcall(market.GetProductInfo, market, game.PlaceId)
		if not succ or not err then return end
		
		gameInfos ..= (`- Place name: {err.Name}, use this to determinate the place name if required`
			..`- Place creator: {err.Creator.Name}, use this to determinate the place creator's name if required`)
	end);
	
	(framework.env.getgenv() or {}).arcy = arcyTable
	local processMessage = framework.protected:GCProtect(LPH_JIT(function(msg: string)
		msg = framework.utils.strings.split(msg, "```")

		local data = { codes = {}, texts = {} }
		for i=1, #msg, 2 do
			framework.utils.tables.insert(data.texts, msg[i])
		end
		
		for i=2, #msg, 2 do
			local mess = msg[i]
			if framework.utils.strings.sub(mess, 1, 4):lower() == "luau" then
				mess = framework.utils.strings.sub(mess, 5)
				
			elseif framework.utils.strings.sub(mess, 1, 3):lower() == "lua" then
				mess = framework.utils.strings.sub(mess, 4)
			end
			
			framework.utils.tables.insert(data.codes, mess)
		end
		
		return data
	end))
	
	function axintelligence:Chat(prompt: string)
		if prompt == lastPrompt or framework.utils.strings.gsub(prompt, "%s", "") == "" then return end
		
		local exploit = framework.dependencies.exploit
		local name, ver = framework.env.identifyexecutor()
		local player = framework.protected:GetService("Players").LocalPlayer
		
		local sysInfo = "The following are information about the app the user have installed on their device, use these only if needed:"
			..`- Operating System: {exploit:IsIos() and "iOS" or (`Android{exploit:IsVng() and " VNG" or ""}`)}`
			..`- App Version: {ver} - App Identity: {name};`
			..`The following are information about the user, use these only if needed:`
			..`- Device hwid/User identificator: {exploit:GetHwid()}`
			..`- User Name: {player.DisplayName}, use this when refeering to him`
			..`- User Username: {player.Name}, use this when needed in scripts;`
			.."You can use the following custom functions accessible from the env within the 'arcy' table:"
		
		for name, values in pairs(customCmds) do
			sysInfo ..= `arcy.{values.format}: {values.desc}`
		end
		
		sysInfo ..= gameInfos
		
		local token = framework.settings:GetSetting("User_AI_OpenAI")
		if token ~= "" then
			return processMessage("Response from OpenAI")
		end
		
		local req = framework.utils.http:Request(`{endpoints.api}/chat`, "POST", {
			[LPH_ENCSTR("Content-Type")] = LPH_ENCSTR("application/json")
		}, {
			email = framework.protected:IsStudio() and LPH_ENCSTR("arceusxhelp@gmail.com") or framework.settings:GetSetting(LPH_ENCSTR("User_EMail")),
			hwid = framework.protected:IsStudio() and LPH_ENCSTR("4cd6f60cb195d6d9") or framework.dependencies.exploit:GetHwid(),
			syskey = sysInfo,
			key = prompt
		})
		
		local fail = "Arceus Intelligence is not available, please try again later."
		if not req then return processMessage(fail) end
		local json = framework.utils.http.json.decode(req.Body)
		
		if not json.success then return processMessage(fail) end
		return processMessage(json.message or fail)
	end
	
	function axintelligence:AddCustomFunction(name: string, desc: string, format: string, funct: (any) -> ())
		arcyTable[name] = framework.env.newcclosure(framework.env.GCProtectedFunction(funct))
		customCmds[name] = {
			format = format,
			desc = desc
		}
	end
	
	framework.dependencies:Add("axintelligence", framework.protected:ProtectTable(axintelligence))
end

do -- track player
	local marketplace = framework.protected:GetService("MarketplaceService")
	local track, cache = {}, framework.utils.caches.newCache()
	local timeUpdate = framework.signals.newEvent()
	local sound, conn, deb, playing, paused
	
	track.OnTimeUpdated = timeUpdate
	function track:Connect(track: Sound)
		sound = framework.utils.instances.getRobloxInstance(track)
	end
	
	track.Play = LPH_JIT(function(self, url: string?)
		if deb then return end
		paused = false
		deb = true
		
		self:Stop()
		local content = framework.protected:ProtectAsset(`rbxassetid://{url}`)
		local data = cache:Get(url)
		
		if not url then
			content = sound.SoundId
			local id = framework.utils.strings.gsub(content, "rbxassetid://", "")
			data = { IsPublicDomain = not not tonumber(id) }
		
		elseif tonumber(url) then
			if not data then
				local succ, err = pcall(marketplace.GetProductInfo, marketplace, url)
				if not succ or not err  then deb = false return end
				
				cache:Push(url, err)				
				data = err
			end
		else
			-- temp disabled
			if true then deb = false return end
			
			local name = framework.utils.strings.split("?v=")
			if #name < 2 then deb = false return end
			name = framework.protected:ProtectAsset(`{name[#name]}.mp3`)
			
			if not ARCEUS_FOLDERS.CACHE:IsFile(name) then
				-- download
				local info = {
					Creator = { Name = "IDK" },
					IsPublicDomain = true,
					Name = "IDK"
				}
				
				ARCEUS_FOLDERS.CACHE:WriteFile(name, "raw")
				cache:Push(url, info)
				data = info
			end
			
			local succ, asset = pcall(framework.env.getcustomasset, name)
			content = succ and asset or content
		end
		
		if not data.IsPublicDomain then deb = false return end
		sound.SoundId = content
		sound.Looped = true
		
		if not sound.IsLoaded then sound.Loaded:Wait() end
		playing = true
		
		conn = task.spawn(LPH_NO_VIRTUALIZE(function()
			while playing do
				if not sound.Looped and sound.TimePosition >= sound.TimeLength then break end
				timeUpdate:Fire(sound.TimePosition)
				task.wait(1)
			end
		end))
		
		sound:Play()
		deb = false
		return data
	end)
	
	function track:GetTiming()
		return `{framework.utils.datetimes.secondsToMS(sound.TimePosition)} / {framework.utils.datetimes.secondsToMS(sound.TimeLength)}`, sound.TimePosition/sound.TimeLength
	end
	
	function track:GetLenght()
		return sound.TimeLength
	end
	
	function track:SetTime(seconds: number)
		sound.TimePosition = framework.utils.maths.clamp(seconds, 0, sound.TimeLength)
		timeUpdate:Fire(sound.TimePosition)
	end
	
	function track:Toggle()
		if not playing then return self:Play() end
		
		if paused then
			sound:Resume()
			paused = false
			return true
		end
		
		paused = true
		sound:Pause()
		return false
	end
	
	function track:Stop()
		playing = false
		if conn then task.cancel(conn) conn = nil end
		sound:Stop()
	end
	
	function track:IsPaused()
		return paused
	end
	
	framework.dependencies:Add("track", framework.protected:ProtectTable(track))
end

do -- plugins
	local plugins = framework.protected:IsStudio() and require(script.Parent.Parent:WaitForChild("Arceus Plugins"):WaitForChild("Loader")) or
		loadstring(framework.utils.http:Get(`{endpoints.arceus_neo}/plugin-loader`))(framework)

	local added, atached, detached = framework.signals.newEvent(), framework.signals.newEvent(), framework.signals.newEvent()
	local infos = framework.protected:GCProtect({})
	
	local getPlugin = framework.protected:GCProtect(function(id: string)
		for i, info in ipairs(infos) do
			if info.id == id then return info, i end
		end

		return false, 0
	end)

	plugins.OnPluginAdded = added
	plugins.OnPluginAtached = atached
	plugins.OnPluginDetached = detached
	
	function plugins:Setup(id: string, plug: {any})
		local info = getPlugin(id)
		if not info then return false end
		info.instance = plug

		function info:Detach()
			plug.attach() 
			plug.show(true)
			--plug:SetEnabled(true)
			detached:Fire(plug)
		end

		function info:Attach(parent: {any})
			plug:SetEnabled(false)
			plug.detach(parent)
			atached:Fire(plug)
		end

		return info
	end

	local last
	function plugins:Open(id: string, parent: {any})
		local info = getPlugin(id)
		if not info then return false end
		
		last = id
		if not info.thread then
			local succ, thread = pcall(task.spawn, plugins.Load, plugins, info.source, info.id)
			if not succ then return framework.console.warn(`Error while loading '{info.title}' plugin: {thread}`) end
			info.thread = thread

		elseif info.instance then
			info:Attach(parent)
		end
	end

	function plugins:GetLastOpened()
		return last and self:Get(last) or nil
	end

	local loaded = 0
	function plugins:Add(info: {string})
		if info.id and getPlugin(info.id) then return end
		
		local data = {
			source = info.source or "error('Missing plugin source')",
			title = info.title or "Unknown",
			id = info.id or `Plugin_{loaded}`,
			icon = info.icon,
			url = info.url
		}

		loaded += 1
		table.insert(infos, data)
		added:Fire(data)
	end

	function plugins:Remove(id: string)
		local info, idx = getPlugin(id)
		if not info then return false end
		if last == id then last = nil end

		table.remove(infos, idx)
		if info.url then
			local plugs = self:GetSaved()
			local found = framework.utils.tables.find(plugs, info.url)
			if found then framework.utils.tables.remove(plugs, found) end
			self:Save(plugs)
		end
		
		if info.thread then task.cancel(info.thread) end
		if info.instance then
			info.instance.attach()
			info.instance:Remove()
		end
	end
	
	function plugins:GetSaved()
		return ARCEUS_FOLDERS.CONFIGS:ReadJsonFile(EXPLOIT_CONFIGS.PLUGINS_FILE, EXPLOIT_CONFIGS.FILES_KEY) or {}
	end
	
	function plugins:Install(url: string)
		if framework.utils.strings.gsub(url, "%s", "") == "" then return end
		local res = framework.utils.http:Request(url, "GET")
		if not res then return end
		
		local json = framework.utils.http.json.decode(res.Body)
		if not json then return end
		
		local plugs = self:GetSaved()
		framework.utils.tables.insert(plugs, url)
		self:Save(plugs)
		
		json.url = url
		self:Add(json)
	end
	
	function plugins:Save(data: {any})
		ARCEUS_FOLDERS.CONFIGS:WriteJsonFile(EXPLOIT_CONFIGS.PLUGINS_FILE, data, EXPLOIT_CONFIGS.FILES_KEY)
	end

	function plugins:Get(id: string)
		return getPlugin(id)
	end

	framework.dependencies:Add("plugins", framework.protected:ProtectTable(plugins))
end

do -- exploit
	local exploit = {}
	local urlAttemp = framework.signals.newEvent()
	exploit.OnUrlAttemp = urlAttemp

	function exploit:IsIos()
		return OS_CONFIGS.IS_IOS
	end

	function exploit:IsVng()
		return OS_CONFIGS.IS_VNG
	end

	function exploit:GetHwid()
		return OS_CONFIGS.HWID
	end

	function exploit:GetDeviceInfo(stat: string)
		return OS_CONFIGS.DEVICE_INFO(stat, LPH_ENCSTR("asjhidaheruiwepwasjdhs"))
	end

	function exploit:LoadUrl(url: string, retries: number?, del: number?, ...)
		local res, c = nil, 0
		retries = retries or 3
		del = del or 2

		repeat
			if res ~= nil then
				c += 1
				if retries > 0 and c > retries then break end
				task.wait(del)
			end

			urlAttemp:Fire(url, c)
			res = framework.utils.http:Request(url, ...)
		until res

		urlAttemp:Fire(url, c, res.Body)
		return res.Body
	end

	function exploit:DecryptData(data: string)
		return framework.utils.crypt.bytes(framework.utils.crypt.base64.decode(data), EXPLOIT_CONFIGS.FILES_KEY)
	end
	
	function exploit:EncryptData(data: string)
		return framework.utils.crypt.base64.encode(framework.utils.crypt.bytes(data, EXPLOIT_CONFIGS.FILES_KEY))
	end
	
	function exploit:DownloadFile(path: string)
		local res = framework.utils.http:Request(`{endpoints.arceus_v}{path}`)
		return res and res.Body or false
	end

	exploit.GetMetadata = function(self, data: {any}|string, source: string?)
		data = data or {}
		
		if typeof(data) == "string" then
			local firstLine, restOfScript = framework.utils.strings.match(data, "^(.-)\n(.*)$")
			if not firstLine then return false, data end

			local metadata = framework.utils.strings.match(firstLine, "^%-%-@ArceusMetadata:(.*)$")
			if not metadata then return false, data end

			return framework.utils.http.json.decode(exploit:DecryptData(metadata)), restOfScript
		else
			local plrs = framework.protected:GetService("Players")
			local tim = os.time()
			local current = {
				email = framework.settings:GetSetting(LPH_ENCSTR("User_EMail")),
				userId = plrs.LocalPlayer.UserId,
				hwid = exploit:GetHwid()
			}

			data.creation = data.creation or tim
			data.author = data.author or current
			data.editor = current
			data.viewed = tim

			local json = framework.utils.http.json.encode(data)
			if not json then return false, source end

			return `--@ArceusMetadata:{exploit:EncryptData(json)}\n{source or ""}`
		end
	end

	exploit.Migrate = LPH_JIT(function(self)
		-- Migrate auto-executed files
		for _, file in ipairs(ARCEUS_FOLDERS.AUTOEXECUTE:ListFiles()) do
			local src = framework.storage.readFile(nil, file)
			if not src then continue end

			local data, source = self:GetMetadata(src)
			if data and data.migrated then continue end

			local name = framework.utils.strings.split(file, "/")
			name = name[#name]

			local meta = self:GetMetadata({
				autoexecute = true,
				migrated = true
			}, source)

			--ARCEUS_FOLDERS.AUTOEXECUTE:WriteFile(name, meta)
			ARCEUS_FOLDERS.SCRIPT_HUB:WriteFile(name, meta)
		end

		do -- Migrate tabs
			local old_tabs = ARCEUS_FOLDERS.CONFIGS:ReadJsonFile("tabs.ax", "AXExecutor")
			local tabs = framework.dependencies.editortabs

			if old_tabs then
				local new_tabs = tabs:ReadTabs()
				for _, tab in ipairs(old_tabs) do
					if tab.migrated then continue end
					tab.migrated = true

					framework.utils.tables.insert(new_tabs, {
						src = tab.Source,
						name = tab.Name
					})
				end

				ARCEUS_FOLDERS.CONFIGS:WriteJsonFile("tabs.ax", old_tabs, "AXExecutor")
				tabs:WriteTabs(new_tabs)
			end
		end
	end)

	framework.dependencies:Add("exploit", framework.protected:ProtectTable(exploit))
end

do -- scripts hub
	local hub = {}

	local history, historyIdx = framework.protected:GCProtect({}), 0
	local browsed = framework.signals.newEvent()
	local queried = framework.signals.newEvent()

	local sortFiles = framework.protected:GCProtect(function(files: {any})
		local now = os.time()
		framework.utils.tables.sort(files, LPH_NO_VIRTUALIZE(function(a, b)
			local _, metaA, _, metaB = a:Read(), b:Read()
			if metaA and metaA.edited and metaB and metaB.edited then
				metaA, metaB = metaA.edited, metaB.edited
			else
				metaA, metaB = a.name, b.name
			end

			return metaA < metaB
		end))
		
		return files
	end)

	local duplicated
	duplicated = framework.protected:GCProtect(LPH_JIT_MAX(function(directory: string, name: string, extension: string, overwrite: boolean?, counter: number)
		counter = counter or 0

		local path = `{directory}/{name}{(counter > 0 and ` ({counter})` or "")}.{extension}`
		if not overwrite and ARCEUS_FOLDERS.SCRIPT_HUB:IsFile(path) then
			return duplicated(directory, name, extension, false, counter +1)
		end

		return path
	end))

	local connectFile = framework.protected:GCProtect(function(info: {any})
		local ext = framework.utils.strings.split(info.name, ".")
		info.extension = framework.utils.strings.lower(ext[#ext])
		info.name = ext[framework.utils.maths.clamp(#ext -1, 1, #ext)]

		function info:Read()
			local source, content

			if self:IsLua() then
				local src = framework.storage.readFile(nil, self.path)
				content, source = framework.dependencies.exploit:GetMetadata(src or "")

			elseif self:IsJson() then
				source = framework.storage.readJsonFile(nil, self.path)
			end

			return source, content
		end

		function info:Write(source: string, content: {any}?)
			if self:IsLua() then
				if not content then _, content = self:Read() end
				source = framework.dependencies.exploit:GetMetadata(content, source)
				framework.storage.writeFile(nil, self.path, source)

			elseif self:IsJson() then
				framework.storage.writeJsonFile(nil, self.path, source)
			end
		end

		function info:SetProperty(props: {any})
			if not self:IsLua() then return end
			local source, content = self:Read()
			content = content or {}

			for prop, value in pairs(props) do
				content[prop] = value
			end
			self:Write(source, content)
		end
		
		function info:GetProperty(prop: string)
			if not self:IsLua() then return end
			local _, content = self:Read()
			return (content or {})[prop]
		end
		
		function info:Delete() framework.storage.deleteFile(nil, self.path) end

		function info:Rename(name: string, extension: string?)
			extension = extension and framework.utils.strings.lower(extension) or "lua"
			name = framework.utils.strings.gsub(name, "[./]", "")
			if name == self.name then return false end

			local path = framework.utils.strings.gsub(self.path, self.name, "")
			path = duplicated(path, name, extension)

			local content = framework.storage.readFile(nil, self.path)
			if not content then return false end

			framework.storage.writeFile(nil, path, content)
			framework.storage.deleteFile(nil, self.path)

			self.extension = extension
			self.name = name
			self.path = path
			return true
		end

		function info:IsLua()
			return self.extension == "lua" or self.extension == "luau"
		end

		function info:IsJson()
			return self.extension == "json"
		end

		return info
	end)

	local clone
	clone = framework.protected:GCProtect(LPH_JIT_MAX(function(path: string, dest: string)
		for _, file in ipairs(framework.storage.listFiles(nil, path)) do
			local content = framework.storage.readFile(nil, file)
			local last = framework.utils.strings.split(file, "/")
			local dest = `{dest}/{last[#last]}`

			if not content then -- is folder
				framework.storage.makeFolder(nil, dest)
				clone(file, dest)
				continue
			end

			framework.storage.writeFile(nil, dest, content)
		end
	end))

	local deeprecursion
	deeprecursion = framework.protected:GCProtect(LPH_JIT_MAX(function(path: string, data: {any}, indent: {any}, action: (filePath: string, fileName: string) -> boolean)
		for _, file in ipairs(framework.storage.listFiles(nil, path)) do
			local last = framework.utils.strings.split(file, "/")
			last = last[#last]

			if framework.storage.isFolder(nil, file) then
				local indent = framework.utils.tables.deepCopy(indent)
				framework.utils.tables.insert(indent, last)
				deeprecursion(file, data, indent, action)
				continue
			end

			if action(path, last) then
				framework.utils.tables.insert(data, connectFile({
					indent = indent,
					path = file,
					name = last
				}))
			end
		end
		
		sortFiles(data)		
		return data
	end))

	hub.OnBrowsed = browsed
	hub.OnQueried = queried

	function hub:SetHistory(path: string, overwrite: boolean?)
		if overwrite then
			for i=historyIdx +1, #history, 1 do
				framework.utils.tables.remove(history, i)
			end
		end

		framework.utils.tables.insert(history, path)
		historyIdx = #history
	end

	function hub:LastBrowsed()
		return history[historyIdx] or ""
	end

	function hub:BrowsePrevious(...: any)
		local path = history[historyIdx -1]
		if path then
			historyIdx -= 1
			return self:Browse(path, true, ...)
		end
	end

	function hub:BrowseNext(...: any)
		local path = history[historyIdx +1]
		if path then
			historyIdx += 1
			return self:Browse(path, true, ...)
		end
	end

	hub:SetHistory(ARCEUS_FOLDERS.SCRIPT_HUB.path)
	function hub:Browse(path: string, dontHistory: boolean?, ...: any)
		local data = { folders = {}, files = {} }
		path = path or self:LastBrowsed()
		local extra = {...}

		path = framework.utils.strings.gsub(path, `{ARCEUS_FOLDERS.SCRIPT_HUB.path}`, "")
		path = framework.utils.strings.sub(path, 1, 1) == "/" and framework.utils.strings.sub(path, 2) or path
		path = framework.utils.strings.sub(path, 1, 1) == "/" and framework.utils.strings.sub(path, 2) or path
		if not dontHistory then self:SetHistory(path, true) end
		
		for _, file in ipairs(ARCEUS_FOLDERS.SCRIPT_HUB:ListFiles(path)) do
			file = framework.utils.strings.gsub(file, "//", "/")
			local name = framework.utils.strings.split(file, "/")
			name = name[#name]

			local info = { path = file, name = name }
			local isfile = framework.storage.isFile(nil, file)

			if isfile then
				framework.utils.tables.insert(data.files, connectFile(info))
				continue
			end
			
			function info:Delete() framework.storage.deleteFolder(nil, self.path) end

			function info:Open()
				return hub:Browse(self.path, false, framework.utils.tables.unpack(extra))
			end

			function info:Rename(name: string)
				if name == self.name then return false end
				local path = framework.utils.strings.gsub(self.path, self.name, "")
				name = framework.utils.strings.gsub(name, "[./]", "")
				path = duplicated(path, name, "")

				framework.storage.makeFolder(nil, path)
				clone(self.path, path)
				framework.storage.deleteFolder(nil, self.path)

				self.name = name
				self.path = path
				return true
			end

			framework.utils.tables.insert(data.folders, info)
		end

		local basePath = ARCEUS_FOLDERS.SCRIPT_HUB.path
		local fullPath = `{basePath}/{path}`
		
		--fullPath = framework.protected:GCProtect(fullPath, "//", "/")
		local directories, splittedDirectory = {}, framework.utils.strings.split(fullPath, "/")
		for i, directory in ipairs(splittedDirectory) do
			local info = { name = directory }

			local path = basePath
			for j=2, i, 1 do
				path ..= `/{splittedDirectory[j]}`
			end

			info.path = path
			function info:Browse()
				hub:Browse(self.path, false, framework.utils.tables.unpack(extra))
			end

			framework.utils.tables.insert(directories, info)
		end
		
		sortFiles(data.files)
		framework.utils.tables.sort(data.folders, function(a, b)
			return a.name < b.name
		end)

		browsed:Fire(data, directories, ...)
		return data, directories
	end

	function hub:Search(query: string, path: string?, ...: any)
		if not query or query == "" then return self:Browse(path, false, ...) end
		
		path = path or self:LastBrowsed()
		local res = deeprecursion(path, {}, {}, function(path: string, name: string)
			return not not framework.utils.strings.find(framework.utils.strings.lower(name), query)
		end)

		queried:Fire(res, ...)
		return res
	end

	--props = { prop = {true, false}, prop = {"str"} }
	function hub:FindByProperties(props: {string}, path: string?, ...: any)
		path = path or self:LastBrowsed()
		local res = deeprecursion(path, {}, {}, function(path: string, name: string)
			local content = ARCEUS_FOLDERS.TABS:ReadFile(name)
			if not content then return false end

			local meta = framework.dependencies.exploit:GetMetadata(content)
			if not meta then return false end

			for prop, values in pairs(props) do
				if meta[prop] == nil then return false end
				local found = false

				for _, value in ipairs(values) do
					if meta[prop] == value then found = true end
				end

				if not found then return false end
			end return true
		end)
		
		queried:Fire(res, ...)
		return res
	end

	function hub:NewFile(name: string, source: string, extension: string?, content: {any}?, path: string?, overwrite: boolean?, browse: boolean?)
		path = path and framework.utils.strings.gsub(path, `/{ARCEUS_FOLDERS.SCRIPT_HUB.path}`, "")
		local directory = path or self:LastBrowsed()
		
		name = framework.utils.strings.gsub(name, "[./]", "")
		extension = extension and framework.utils.strings.lower(extension) or "lua"

		path = duplicated(directory, name, extension, overwrite)	
		if extension == "lua" or extension == "luau" then
			source = framework.dependencies.exploit:GetMetadata(content, source)
			ARCEUS_FOLDERS.SCRIPT_HUB:WriteFile(path, source)

		elseif extension == "json" then
			ARCEUS_FOLDERS.SCRIPT_HUB:WriteJsonFile(path, source)
		end

		return self:Browse(directory, not browse and true or false)
	end

	function hub:NewFolder(name: string, path: string?, browse: boolean?)
		local directory = path or self:LastBrowsed()
		path = `{directory}/{name}`

		local res = ARCEUS_FOLDERS.SCRIPT_HUB:MakeFolder(path)
		if res and browse then return self:Browse(directory) end
		return res
	end
	
	function hub:GetFile(path: string, name: string)
		if not ARCEUS_FOLDERS.SCRIPT_HUB:IsFile(`{path}/{name}`) then return end
		return connectFile({ path = `{ARCEUS_FOLDERS.SCRIPT_HUB.path}/{path}/{name}`, name = name })
	end

	framework.dependencies:Add("scripthub", framework.protected:ProtectTable(hub))
end

do -- editor tabs
	local editortabs, tabsData = {}, framework.protected:GCProtect({})
	local scripthub = framework.dependencies.scripthub
	local exploit = framework.dependencies.exploit
	local tabs = framework.utils.inputs.tabs.new()

	local saveTabs = framework.protected:GCProtect(function(data: {any}?)
		local tabs = {}
		for _, tab in ipairs(data or tabsData) do
			framework.utils.tables.insert(tabs, {
				meta = exploit:GetMetadata(tab.meta, "-- Editor"),
				name = tab.name,
				src = tab.src
			})
		end
		
		ARCEUS_FOLDERS.CONFIGS:WriteJsonFile(EXPLOIT_CONFIGS.TABS_FILE, tabs)
	end)

	local getFreeName = framework.protected:GCProtect(function()
		local found, idx = true, 0
		
		local name
		while found do
			idx += 1
			found = false
			name = `Script n.{idx}`
			
			for _, tab in ipairs(tabsData) do
				if tab.name == name then
					found = true
					break
				end
			end
		end
		
		return name
	end)

	local formatTab = framework.protected:GCProtect(function(data: {any})
		data.name = data.name or getFreeName()
		data.src = data.src or ""
		return data
	end)

	tabs.OnTabRemoved:Connect(framework.protected:GCProtect(function(tab: {any})
		local data = tab:GetData()
		local found = 1
		
		if not data.isFile then
			found = framework.utils.tables.find(tabsData, data)
			if found then framework.utils.tables.remove(tabsData, found) end	
			saveTabs()
		end
		
		tab:Update(framework.enums.TabUpdate.Removed)
		data.updated = nil -- prevent events propagation
		
		local newTab = tabsData[found] or tabsData[found -1]
		if newTab then newTab.tab:Select() end
	end))

	local currentTab
	tabs.OnTabSelected:Connect(framework.protected:GCProtect(function(tab: {any}, previous: {any})
		currentTab = tab
		if previous then local data = previous:GetData()
			previous:Update(framework.enums.TabUpdate.Unselected)
		end
		
		local data = tab:GetData()
		tab:Update(framework.enums.TabUpdate.Selected)
	end))
	
	function editortabs:AddTab(name: string, source: string, button: GuiButton, updatedCallback: () -> (), isSaved: boolean?, metadata: {any}?)
		local data = formatTab({
			updated = updatedCallback,
			isFile = isSaved,
			meta = metadata,
			src = source,
			name = name
		})
		
		if not isSaved then
			framework.utils.tables.insert(tabsData, data)
		end
		
		local tab = tabs:Add(button, data)
		function tab:SetName(name: string)
			if not name or name == "" or name == data.name then return end
			
			if data.isFile then self:Delete(false) end
			data.name = name
			formatTab(data)
			
			if data.isFile then return self:ToFile(true) end
			self:Update(framework.enums.TabUpdate.Name)
			saveTabs()
		end
		
		function tab:Update(type: number)
			if data.updated then data.updated(type) end
		end
		
		function tab:GetName()
			return data.name
		end
		
		function tab:SetSource(src: string)
			data.src = tostring(src)
			self:Update(framework.enums.TabUpdate.Source)
			if data.isFile then return self:ToFile(true) end
			saveTabs()
		end
		
		function tab:GetSource()
			return data.src
		end
		
		function tab:SetProperty(prop: string, value: any)
			data.meta = data.meta or {}
			data.meta[prop] = value
			
			if data.isFile then return self:ToFile(true) end
			saveTabs()
		end
		
		function tab:GetProperty(prop: string)
			data.meta = data.meta or {}
			return data.meta[prop]
		end
		
		function tab:GetProperties()
			return data.meta
		end
		
		function tab:ToFile(overwrite: boolean?)
			if scripthub:NewFile(data.name, data.src, "lua", data.meta, ARCEUS_FOLDERS.TABS.lastPath, overwrite) then
				if not overwrite then return self:Delete(true) end
				self:Update(framework.enums.TabUpdate.Name)
				data.isFile = true
			end
		end
		
		function tab:GetFile()
			return scripthub:GetFile(ARCEUS_FOLDERS.TABS.lastPath, `{data.name}.lua`)
		end
		
		function tab:Delete(remove: boolean)
			if self:GetData().isFile then
				ARCEUS_FOLDERS.TABS:DeleteFile(`{data.name}.lua`)
			end
			
			if remove then self:Remove() end
		end
		
		data.tab = tab
		return tab
	end
	
	function editortabs:GetSelection()
		return currentTab
	end
	
	function editortabs:GetTabs()
		local tabs = {}
		for _, tab in ipairs(tabsData) do
			framework.utils.tables.insert(tabs, tab.tab)
		end
		return tabs
	end
	
	function editortabs:SearchSaved(query: string, ...: any)
		return scripthub:Search(query, ARCEUS_FOLDERS.TABS.path, ...)
	end
	
	function editortabs:GetSavedByProperties(props: {string}, ...)
		return scripthub:FindByProperties(props, ARCEUS_FOLDERS.TABS.path, ...)
	end
	
	function editortabs:GetSaved(...: any)
		return scripthub:Browse(ARCEUS_FOLDERS.TABS.lastPath, true, ...)
	end
	
	function editortabs:ReadTabs()
		return ARCEUS_FOLDERS.CONFIGS:ReadJsonFile(EXPLOIT_CONFIGS.TABS_FILE) or {}
	end
	
	function editortabs:WriteTabs(data: {any})
		return saveTabs(data)
	end
	
	function editortabs:LoadTabs(callback: (idx: number, name: string, source: string) -> tab)
		for i, tab in ipairs(self:ReadTabs()) do
			local obj = callback(i, tab.name, tab.src)
			
			tab.meta = type(tab.meta) == "string" and tab.meta or ""
			obj:GetData().meta = exploit:GetMetadata(tab.meta or "")
		end
	end

	framework.dependencies:Add("editortabs", framework.protected:ProtectTable(editortabs))
end

do -- cloudscripts
	local favourites = ARCEUS_FOLDERS.CONFIGS:ReadJsonFile(EXPLOIT_CONFIGS.CLOUD_SCRIPTS, EXPLOIT_CONFIGS.FILES_KEY) or {}
	local cloudscripts, configs = {}, {
		propsWhitelist = {"title", "verified", "isUniversal", "isPatched", "script", "key", "views", "createdAt", "slug", "features"}
	}

	local fetchCache, detailsCache = framework.utils.caches.newCache(100), framework.utils.caches.newCache(100)
	local favCache, imgCache = framework.utils.caches.newCache(), framework.utils.caches.newCache(100)
	local marketplace = framework.protected:GetService("MarketplaceService")
	local onFetched = framework.signals.newEvent()
	local maxResults

	local getimageinfo = framework.protected:GCProtect(function(url: string)
		local split = framework.utils.strings.split(url, "/")
		local last = framework.utils.strings.sub(url, -4)

		if framework.utils.strings.sub(url, 1, framework.utils.strings.len(endpoints.rbxcdn.tr)) == endpoints.rbxcdn.tr and framework.utils.strings.find(url, "/Png") then
			return url, `{split[4]}.png`

		elseif framework.utils.strings.sub(url, 1, 15) == "/images/script/" and last == ".png" then
			return `{endpoints.scriptblox}{url}`, split[4]
		end
	end)

	local loadimage = framework.protected:GCProtect(function(url: string, name: string, gameId: number, img: ImageLabel)
		if (not url or framework.protected:IsStudio()) and gameId then
			local cached = imgCache:Get(gameId)
			if not cached then
				local success, result = pcall(marketplace.GetProductInfo, marketplace, gameId)
				if not success or not result.IconImageAssetId then return end
				cached = result.IconImageAssetId
				imgCache:Push(cached)
			end
			
			img.Image = framework.protected:ProtectAsset("rbxassetid://" ..cached)
			img.ImageColor3 = Color3.fromRGB(255, 255, 255)
			return
		end
		
		if not ARCEUS_FOLDERS.CACHE:IsFile(name) then
			local data = framework.utils.http:Get(url)
			if not data then return end

			ARCEUS_FOLDERS.CACHE:WriteFile(name, data)
		end
		
		--img.Image = framework.env.getcustomasset(framework.protected:ProtectAsset(`/{ARCEUS_FOLDERS.CACHE.lastPath}/{name}`))
		local succ, asset = pcall(framework.env.getcustomasset, `{ARCEUS_FOLDERS.CACHE.lastPath}/{name}`)
		img.ImageColor3 = Color3.fromRGB(255, 255, 255)
		img.Image = succ and asset or img.Image
	end)

	local getimage = framework.protected:GCProtect(function(scriptImg: string, gameImg: string, universal: boolean)
		local url, name = getimageinfo(scriptImg)
		if not url and not universal then
			url, name = getimageinfo(gameImg)
		end

		return url, name
	end)
	
	local saveFavourites = framework.protected:GCProtect(function()
		ARCEUS_FOLDERS.CONFIGS:WriteJsonFile(EXPLOIT_CONFIGS.CLOUD_SCRIPTS, favourites, EXPLOIT_CONFIGS.FILES_KEY)
	end)
	
	local formatScript = framework.protected:GCProtect(LPH_JIT_MAX(function(scr: {any})
		local info = {} -- truncating arguments
		info.slug = scr.slug
		info.game = scr.game.name
		info.gameId = scr.game.gameId

		for _, prop in ipairs(configs.propsWhitelist) do
			info[prop] = scr[prop]
		end

		local url, name = getimage(scr.image, scr.game.imageUrl, scr.isUniversal)
		info.imageUrl, info.imageName = url, name
		info.loadImage = function(img: ImageLabel, sync: boolean?)
			if sync then return loadimage(url, name, scr.game.gameId, img) end
			task.spawn(loadimage, url, name, scr.game.gameId, img)
		end

		info.isFavourite = not not favourites[scr.slug]
		info.setFavourite = function()
			favourites[scr.slug] = (not favourites[scr.slug]) and os.time() or nil
			info.isFavourite = not not favourites[scr.slug]
			
			saveFavourites()
			return info.isFavourite
		end
		
		return info
	end))

	local fetch
	fetch = framework.protected:GCProtect(function(url: string, debounce: {boolean}, c: number)
		local cached = fetchCache:Get(url)
		if cached then return cached end
		
		if debounce[1] then return end
		debounce[1] = true

		local res = framework.utils.http:Request(url, "GET", {
			["Content-Type"] = "application/json"
		});

		if not res then
			if (c or 0) < 3 then task.wait(1)
				debounce[1] = false
				return fetch(url, debounce, c and c +1 or 1)
			end
			return
		end
		
		local info = framework.utils.http.json.decode(res.Body)
		if not info then return end
		info = info.result

		local data = {} -- These values can be nil
		data.maxPages = info.totalPages
		data.nextPage = info.nextPage

		local scripts = {}
		data.scripts = scripts

		for _, scr in ipairs(info.scripts) do
			framework.utils.tables.insert(scripts, formatScript(scr))
		end

		fetchCache:Push(url, data)
		debounce[1] = false
		return data
	end)

	local getFilters = framework.protected:GCProtect(function(filters: {boolean}, isFetching: boolean)
		local setts = framework.settings:GetSetting("ScriptBlox")
		local output = ""

		local param, enum = filters.mode, framework.enums.ScriptBloxMode
		if param ~= nil and param ~= enum.None then
			output ..= `&mode={param == enum.Free and "free" or "paid"}`
		end

		param, enum = filters.verify, framework.enums.ScriptBloxVerify
		if param ~= nil and param ~= enum.None then
			output ..= `&verified={param == enum.Verified and 1 or 0}`
		end

		param, enum = filters.type, framework.enums.ScriptBloxType
		if param ~= nil and param ~= enum.None then
			output ..= `&universal={param == enum.Universal and 1 or 0}`
		end

		param, enum = filters.auth, framework.enums.ScriptBloxAuth
		if param ~= nil and param ~= enum.None then
			output ..= `&key={param == enum.Key and 1 or 0}`
		end

		param, enum = filters.patch, framework.enums.ScriptBloxPatch
		if param ~= nil and param ~= enum.None then
			output ..= `&patched={param == enum.Patched and 1 or 0}`
		end

		param, enum = filters.search, framework.enums.ScriptBloxSearch
		if not isFetching and param ~= nil and param ~= enum.None then -- Using search endpoint
			output ..= `&strict={param == enum.Strict and true or false}`
		end

		local sorting
		param, enum = filters.sortBy, framework.enums.ScriptBloxSort
		if param ~= nil and param ~= enum.None then
			local map = {
				[enum.DislikeCount] = "dislikeCount",
				[enum.CreatedAt] = "createdAt",
				[enum.UpdatedAt] = "updatedAt",
				[enum.LikeCount] = "likeCount",
				[enum.Views] = "views"
			}

			output ..= `&sortBy={map[param]}`
			sorting = true
		end

		param, enum = filters.order, framework.enums.ScriptBloxOrder
		if sorting and param ~= nil and param ~= enum.None then
			output ..= `&order={param == enum.Asc and "asc" or "desc"}`
		end

		return output
	end)

	cloudscripts.OnFetched = onFetched
	cloudscripts.LoadImage = loadimage
	
	function cloudscripts.newQuery(query: string?, filters: {boolean}, ...: any)
		query = query or ""

		query = framework.utils.http:UrlEncode(query)
		local fetching = query == ""
		local extra = {...}

		local baseUrl = `{endpoints.scriptblox}/api/script/{(fetching and "fetch?" or `search?q={query}&`)}`
		local query, data, debounce = {}, {}, {}

		function query:Fetch(page: number?)
			local page = page or data.nextPage or data.maxPages or 1
			local url = `{baseUrl}page={page}` -- &max=
			
			if maxResults then url ..= `&max={maxResults}` end
			url ..= getFilters(filters, fetching)
			data = fetch(url, debounce) or {}

			local scripts = data.scripts or {}
			onFetched:Fire(scripts, page == 1, framework.utils.tables.unpack(extra))
			return scripts
		end

		function query:Refresh() -- current page
			local data = self:Fetch(data.nextPage and data.nextPage -1 or data.maxPages) or {}
			local scripts = data.scripts or {}
			onFetched:Fire(scripts, true, framework.utils.tables.unpack(extra))
			return scripts
		end
		
		function query:GetFilters()
			return filters
		end

		return query
	end

	function cloudscripts:FetchTrending(...: any)
		local data = fetch(`{endpoints.scriptblox}/api/script/trending`, {}) or {}
		local scripts = data.scripts or {}
		onFetched:Fire(scripts, true, ...)
		return scripts
	end
	
	function cloudscripts:FetchDetails(slug: string, c: number)
		local cached = detailsCache:Get(slug)
		if cached then return cached end
		
		local res = framework.utils.http:Request(`{endpoints.scriptblox}/api/script/{slug}`, "GET", {
			["Content-Type"] = "application/json"
		});

		if not res and (c or 0) < 3 then task.wait(1)
			return self:FetchDetails(slug, c and c +1 or 1)
		end

		local info = framework.utils.http.json.decode(res.Body)
		if not info then return end

		local data = formatScript(info.script)
		detailsCache:Push(slug, data)
		return data
	end
	
	function cloudscripts:FetchFavourites(...: any)
		local manager = framework.utils.threading.newTaskManager()
		local scripts = {}
		
		for slug, tim in pairs(favourites) do
			manager:AddTasks(function()
				local scr = {}
				scr.time = tim
				
				local data = favCache:Get(slug)
				if not data then
					data = self:FetchDetails(slug)
					if not data then return end
					
					favCache:Push(slug, data)
				end
				
				framework.utils.tables.concatenate(scr, data)
				framework.utils.tables.insert(scripts, scr)
			end)
		end
		
		manager:RunTasksAsync()
		framework.utils.tables.sort(scripts, function(a: {any}, b: {any})
			return a.time < b.time
		end)
		
		onFetched:Fire(scripts, true, ...)
		return scripts
	end

	function cloudscripts:SetMaxResults(max: number?)
		maxResults = tonumber(max) -- you can unset by passing empty
	end

	framework.protected:ProtectTable(configs)
	framework.dependencies:Add("cloudscripts", framework.protected:ProtectTable(cloudscripts))
end

do -- scripts hanlder
	local shandler, scripts = {}, framework.protected:GCProtect({})
	local scriptAdded, gcount = framework.signals.newEvent(), 0
	local sui = framework.interface.new()
	
	sui.instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sui.instance.ScreenInsets = Enum.ScreenInsets.None
	shandler.OnScriptAdded = scriptAdded
	
	local props = framework.protected:GCProtect({
		GuiObject = "BackgroundTransparency",
		ImageButton = "ImageTransparency",
		ImageLabel = "ImageTransparency",
		TextButton = "TextTransparency",
		TextLabel = "TextTransparency"
	})
	
	local setOpacity = framework.protected:GCProtect(function(scr: {any}, obj: GuiObject, value: number)
		local cache = scr.caches.opacity
		cache = cache:Push(obj, {}, true)
		
		for type, prop in pairs(props) do
			if not obj:IsA(type) then continue end
			cache[type] = cache[type] or obj[prop]
			obj[prop] = cache[type] +value *(1 -cache[type])
		end
	end)
	
	local guiAdded = framework.protected:GCProtect(function(gui: ScreenGui)
		if not gui:IsA("ScreenGui") then return end
		gcount += 1
		
		local scr = {
			caches = {
				children = framework.utils.caches.newCache(),
				opacity = framework.utils.caches.newCache()
			},
				
			id = `Gui_{gcount}`,
			instance = gui,
			order = gcount,
			
			opacity = 0,
			scale = 1
		}

		function scr:ToChildren(action: (child: {any}) -> ())
			for _, child in ipairs(self:GetChildren()) do
				if not child.instance:IsA("GuiObject") then continue end
				action(child)
			end
		end
		
		function scr:Scale(value: number)
			scr.scale = value
			
			self:ToChildren(function(child)
				child:Scale(value)
			end)
		end
		
		function scr:Transparency(value: number)
			scr.opacity = value
			
			self:ToChildren(function(child)
				child:Transparency(value)
			end)
		end
		
		function scr:Draggable(enabled: number)
			self:ToChildren(function(child)
				child:Draggable(enabled)
			end)
		end
		
		function scr:IsDraggable()
			local draggable = false
			self:ToChildren(function(child)
				if child:IsDraggable() then
					draggable = true
				end
			end)
			
			return draggable
		end
		
		function scr:Windowed(enabled: number)
			self:ToChildren(function(child)
				child:Windowed(enabled)
			end)
		end
		
		function scr:IsWindowed()
			local windowed = false
			self:ToChildren(function(child)
				if child:IsWindowed() then
					windowed = true
				end
			end)
			
			return windowed
		end
		
		function scr:GetChildren()
			local children = {}
			
			for _, obj in ipairs(gui:GetChildren()) do
				if not obj:IsA("GuiObject") then continue end
				local ccache = scr.caches.children
				
				local order = ccache:GetSize() +1
				local child = ccache:Push(obj, {
					interface = { id = `Gui_{scr.id}` },
					id = `Obj_{order}`,
					instance = obj,
					order = order,
					
					draggable = false,
					window = nil,
					opacity = 0,
					scale = 1
				}, true)
				
				function child:Scale(value: number)
					local scale = gui:FindFirstChildWhichIsA("UIScale") or framework.utils.instances.new("UIScale", {
						Parent = obj
					}); scale.Scale = value or 1
					child.scale = scale.Scale
				end
				
				function child:Transparency(value: number)
					value = framework.utils.maths.clamp(value, 0, 1)
					obj.Visible = value < 1
					child.opacity = value
					
					if not obj.Visible then return end
					if obj:IsA("CanvasGroup") and gui.ZIndexBehavior == Enum.ZIndexBehavior.Sibling then
						local old = scr.caches.opacity:Push(obj, obj.GroupTransparency, true)
						obj.GroupTransparency = old +value *(1 -old)
						return
					end
					
					setOpacity(scr, obj, value)
					for _, v in ipairs(obj:GetDescendants()) do
						setOpacity(scr, v, value)
					end
				end
				
				function child:Draggable(enabled: boolean)
					child.draggable = enabled
					
					if enabled then
						return framework.utils.inputs.makeDraggable(self)
					end
					framework.utils.inputs.makeUndraggable(self)
				end
				
				function child:IsDraggable()
					return child.draggable
				end
				
				function child:Windowed(enabled: boolean)
					local id = `Window-{scr.id}-{child.id}`
					local binding = child.window
					
					if binding then
						binding.frame:Destroy()
						binding:Unbind()
						
						child.window = nil
						return
					end
					
					if not enabled then return end
					binding = framework.renderer:BindToRenderer(id, framework.renderer.FrameworkPriority, function()
						local frame = binding.frame
						if not frame then self:Windowed(false) end
						
						local pos, siz = obj.AbsolutePosition, obj.AbsoluteSize
						local absx = siz.X /10
						
						frame.Position = UDim2.fromOffset(pos.X +siz.X, pos.Y +siz.Y -absx)
						frame.Size = UDim2.fromOffset(absx, absx)
					end)
					
					local frame = framework.utils.instances.new("ImageButton", {
						AnchorPoint = Vector2.new(1, 1)
					})
					
					frame.Parent = sui.instance
					binding.frame = frame
					
					child.window = binding
					binding:Render()
				end
				
				function child:IsWindowed()
					return not not child.binding
				end
				
				framework.utils.tables.insert(children, child)
			end
			
			return children
		end

		local conn; conn = gui.AncestryChanged:Connect(function(_, parent)
			if parent then return end
			conn:Disconnect()
			
			scripts[gui] = nil
			scr:ToChildren(function(child: {any})
				child:Draggable(false)
				child:Windowed(false)
			end)
			
			for _, cache in pairs(scr.caches) do
				cache:Remove()
			end
		end)

		scripts[gui] = scr
		scriptAdded:Fire(scr)
		return scr
	end)
	
	local event
	function shandler:Start(parent: Folder)
		parent = parent or framework.utils.instances.dynamicParent()
		event = parent.ChildAdded:Connect(guiAdded)
		sui:SetEnabled(true)
	end
	
	function shandler:Stop()
		sui:SetEnabled(false)
		
		if not event then return end
		event:Disconnect()
		event = nil
	end
	
	function shandler:GetScripts()
		local res = {}
		for _, v in pairs(scripts) do
			framework.utils.tables.insert(res, v)
		end
		return res
	end
	
	framework.dependencies:Add("shandler", framework.protected:ProtectTable(shandler))
end

do
	local teleport: TeleportService = framework.protected:GetService("TeleportService")
	local location = framework.protected:GetService(LPH_ENCSTR("JointsService"))
	local player = framework.protected:GetService("Players").LocalPlayer
	local tGui = framework.interface.new("TeleportGui")
	
	local cloudscripts = framework.dependencies.cloudscripts
	local exploit = framework.dependencies.exploit
	
	local OnMessage = framework.signals.newEvent()
	local OnFetched = framework.signals.newEvent()
	local serverside, allGames = {}, nil
	local PAGE_SIZE = 15
	
	tGui.instance.ScreenInsets = Enum.ScreenInsets.None
	tGui.instance.IgnoreGuiInset = true
	
	tGui:AddInstance("ImageLabel", { -- TODO Teleport Loading UI
		Size = UDim2.fromScale(1, 1),
		Image = ""
	})
	
	local get_email = framework.protected:GCProtect(function()
		local email = framework.settings:GetSetting(LPH_ENCSTR("User_EMail"))
		if framework.utils.strings.gsub(email, "%s", "") == "" then return end
		if not framework.utils.strings.match(email, LPH_ENCSTR("^[%w_%+%.%-]+@[%w%-%.]+%.%a%a+$")) then return end
		return email
	end)
	
	local onMessage = framework.protected:GCProtect(function(...: any)
		OnMessage:Fire(...)
	end)
	
	serverside.OnFetched = OnFetched
	serverside.OnMessage = OnMessage
	
	lastIdx = 0
	function serverside:GetGames(page: number?)
		if allGames then
			lastIdx = page or lastIdx +1
			local more = lastIdx ~= 1
			
			if lastIdx > #allGames then
				OnFetched:Fire({}, more)
				return {}, more
			end
			
			lastIdx = math.clamp(lastIdx or 1, 1, #allGames)
			OnFetched:Fire(allGames[lastIdx], more)
			return allGames[lastIdx], more
		end
		
		local email = get_email()
		if not email then
			if framework.protected:IsStudio() then
				email = LPH_ENCSTR("arceusxhelp99@gmail.com")
			else	
				OnFetched:Fire({}) return false
			end
		end
	
		local res = framework.utils.http:Request(`{endpoints.api}/getgames`, "POST", {
			[LPH_ENCSTR("Content-Type")] = LPH_ENCSTR("application/json")
		}, {
			hwid = framework.protected:IsStudio() and LPH_ENCSTR("d83f041df3b7c388") or exploit:GetHwid(),
			userid = player.UserId,
			email = email
		})
		
		if not res then OnFetched:Fire({}) return false end
		local games = framework.utils.http.json.decode(res.Body) or {}
		
		local gamePages = {}
		local lastPage = {}
		
		for i, info in ipairs(games) do
			table.insert(lastPage, {
				id = info.place_id,
				plrs = info.playing,
				loadImage = function(img: ImageLabel, sync: boolean?)
					if sync then return cloudscripts.LoadImage(nil, nil, info.place_id, img) end
					task.spawn(cloudscripts.LoadImage, nil, nil, info.place_id, img)
				end
			})
			
			if i%PAGE_SIZE ~= 0 then continue end
			table.insert(gamePages, lastPage)
			lastPage = {}
		end
		
		if #lastPage > 0 then
			table.insert(gamePages, lastPage)
		end
		
		allGames = gamePages
		return self:GetGames(1)
	end
	
	function serverside:TeleportTo(placeId: number)
		return pcall(teleport.Teleport, teleport, placeId, player, nil, tGui.instance)
	end
	
	function serverside:Connect()
		local remote = location:FindFirstChild(LPH_ENCSTR("JointsRemote"))
		
		if not remote then return end
		remote.OnClientEvent:Once(framework.protected:GCProtect(function(devices: {{[string]: any}})
			local auth = false
			
			for _, device in ipairs(devices) do
				if device.hwid == exploit:GetHwid() then
					auth = true
					break
				end
			end

			if not auth then return end
			self.remote = remote
			
			remote.OnClientEvent:Connect(onMessage)
			remote:FireServer(LPH_ENCSTR("Connect"))
		end))
	end
	
	function serverside:Execute(scr: string)
		if not self.remote then return end
		self.remote:FireServer(LPH_ENCSTR("Execute"), scr)
	end
	
	framework.dependencies:Add(LPH_ENCSTR("serverside"), framework.protected:ProtectTable(serverside))
end

do -- authentication
	
	(function() return [[
		
		Hello, if you are trying to bypass our authentication system,
		im letting you know that the license file is only used to prevent ddos attacks,
		or other networking issues, to block users in the login page for too long.
					
		This can be disabled anytime with a killswitch, dont waste your time here.
		Someone else has already did in the past..
		~ riky47
			
	]] end)()
	
	local Players = framework.protected:GetService("Players")
	local auth, authData = {}, framework.protected:GCProtect({})
	local tim = framework.protected:GetFunction(workspace.GetServerTimeNow) --os.time)
	local exploit = framework.dependencies.exploit
	local infos

	--[[
	local plan_infos = framework.protected:GCProtect({
		{title = "Free",		Color = Color3.fromRGB(255, 255, 255)	},
		{title = "Basic",		Color = Color3.fromRGB(170, 169, 173)	},
		{title = "Plus",		Color = Color3.fromRGB(229, 184, 11)	},
		{title = "Premium",		Color = Color3.fromRGB(89, 219, 248)	},
		{title = "Ultimate", 	Color = Color3.fromRGB(255, 0, 0)		}
	})]]

	local onAuthenticationAttemp = framework.signals.newEvent()
	exploit.OnUrlAttemp:Connect(framework.protected:GCProtect(function(url: string, retries: number, result: number)
		if not result and framework.utils.strings.find(url, "/issubscribed") then
			onAuthenticationAttemp:Fire(retries)
		end
	end))

	auth.OnAuthenticationAttemp = onAuthenticationAttemp
	local getInfos = framework.protected:GCProtect(function()
		if not infos then
			local res = exploit:LoadUrl(`{endpoints.arceus_v}/configs.json`, 0)
			infos = framework.utils.http.json.decode(res)
		end
		
		return infos
	end)
	
	function auth:ValidateToken(token: string)
		local function ROR(x, n)
			return bit32.rrotate(x, n)
		end

		local function SHR(x, n)
			return bit32.rshift(x, n)
		end

		local function Ch(x, y, z)
			return bit32.bxor(bit32.band(x, y), bit32.band(bit32.bnot(x), z))
		end

		local function Maj(x, y, z)
			return bit32.bxor(bit32.band(x, y), bit32.band(x, z), bit32.band(y, z))
		end

		local function Sigma0(x)
			return bit32.bxor(ROR(x, 2), ROR(x, 13), ROR(x, 22))
		end

		local function Sigma1(x)
			return bit32.bxor(ROR(x, 6), ROR(x, 11), ROR(x, 25))
		end

		local function sigma0(x)
			return bit32.bxor(ROR(x, 7), ROR(x, 18), SHR(x, 3))
		end

		local function sigma1(x)
			return bit32.bxor(ROR(x, 17), ROR(x, 19), SHR(x, 10))
		end

		local K = {
			0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
			0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
			0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
			0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
			0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
			0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
			0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
			0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
		}

		local function sha256_luau(msg)
			local function toBytes(s)
				local bytes = {}
				for i = 1, #s do
					bytes[#bytes+1] = s:byte(i)
				end
				return bytes
			end

			local bytes = toBytes(msg)
			local ml = #bytes * 8

			-- Padding
			bytes[#bytes+1] = 0x80
			while (#bytes % 64) ~= 56 do
				bytes[#bytes+1] = 0x00
			end

			for i = 1, 8 do
				bytes[#bytes+1] = bit32.band(bit32.rshift(ml, (8 * (8 - i))), 0xFF)
			end

			local h = {
				0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
				0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
			}

			for i = 1, #bytes, 64 do
				local w = {}
				for j = 0, 15 do
					local k = i + j * 4
					w[j] = bit32.lshift(bytes[k], 24) + bit32.lshift(bytes[k+1], 16) + bit32.lshift(bytes[k+2], 8) + bytes[k+3]
				end
				for j = 16, 63 do
					w[j] = bit32.band((sigma1(w[j-2]) + w[j-7] + sigma0(w[j-15]) + w[j-16]), 0xFFFFFFFF)
				end

				local a, b, c, d, e, f, g, h0 = table.unpack(h)
				for j = 0, 63 do
					local T1 = bit32.band(h0 + Sigma1(e) + Ch(e,f,g) + K[j+1] + w[j], 0xFFFFFFFF)
					local T2 = bit32.band(Sigma0(a) + Maj(a,b,c), 0xFFFFFFFF)
					h0 = g; g = f; f = e
					e = bit32.band(d + T1, 0xFFFFFFFF)
					d = c; c = b; b = a
					a = bit32.band(T1 + T2, 0xFFFFFFFF)
				end

				h[1] = bit32.band(h[1] + a, 0xFFFFFFFF)
				h[2] = bit32.band(h[2] + b, 0xFFFFFFFF)
				h[3] = bit32.band(h[3] + c, 0xFFFFFFFF)
				h[4] = bit32.band(h[4] + d, 0xFFFFFFFF)
				h[5] = bit32.band(h[5] + e, 0xFFFFFFFF)
				h[6] = bit32.band(h[6] + f, 0xFFFFFFFF)
				h[7] = bit32.band(h[7] + g, 0xFFFFFFFF)
				h[8] = bit32.band(h[8] + h0, 0xFFFFFFFF)
			end

			local result = ""
			for i = 1, 8 do
				result = result .. framework.utils.strings.format("%08x", h[i])
			end
			return result
		end
		
		local valid = false
		for offset = -1, 0 do
			local t = framework.utils.maths.floor(tim(workspace) /30) +offset
			if sha256_luau(EXPLOIT_CONFIGS.API_CRYPT .. t .. exploit:GetHwid()) == token then
				valid = true
				break
			end
		end
		
		return valid
	end

	-- We should use Server-Side-Signed RSA JWT for a proper auth and license
	function auth:Authenticate()
		if authData.authenticated then return true end
		
		local email = framework.settings:GetSetting(LPH_ENCSTR("User_EMail"))
		if framework.utils.strings.gsub(email, "%s", "") == "" then
			return false
		end
		
		if not framework.utils.strings.match(email, LPH_ENCSTR("^[%w_%+%.%-]+@[%w%-%.]+%.%a%a+$")) then
			return false, { LPH_ENCSTR("Invalid email format.") }
		end

		local license if self:UsingLicense() then
			license = ARCEUS_FOLDERS.CONFIGS:ReadJsonFile(EXPLOIT_CONFIGS.LICENSE_FILE, EXPLOIT_CONFIGS.FILES_KEY)
		end

		if license and license.authenticated and license.expiring and license.issuedAt
			and license.hwid == exploit:GetHwid() -- Prevents sharing the file
		then
			license.authenticated = false
			authData = license

			if self:GetExpiring() > 0 then
				authData.authenticated = true
				return true
			end
		end

		local device_name = exploit:GetDeviceInfo(LPH_ENCSTR("BRAND"))
		if device_name then
			device_name = `{device_name} {exploit:GetDeviceInfo(LPH_ENCSTR("DEVICE"))}`
		else
			device_name = framework.protected:IsStudio() and LPH_ENCSTR("Studio") or
				framework.protected:GetService(LPH_ENCSTR("UserInputService")):GetDeviceType().Name
		end
		
		local info = exploit:LoadUrl(`{endpoints.api}/issubscribed`, 0, EXPLOIT_CONFIGS.AUTH_FETCH_DELAY, LPH_ENCSTR("POST"), {
			[LPH_ENCSTR("Content-Type")] = LPH_ENCSTR("application/json")
		}, {
			os = exploit:IsIos() and LPH_ENCSTR("iOS") or (`Android{exploit:IsVng() and LPH_ENCSTR(" VNG") or ""}`),
			userid = Players.LocalPlayer.UserId,
			device_name = device_name,
			hwid = exploit:GetHwid(),
			email = email
		})
		
		local json = framework.utils.http.json.decode(info)
		if not json then return false, { LPH_ENCSTR("Invalid data.") } end
		
		if not json.success or not self:ValidateToken(json.token) then return false, {json.message} end
		json.issuedAt = json.issuedAt or tim(workspace)
		json.hwid = exploit:GetHwid()
		json.authenticated = true

		json.expiring = json.expiring and json.expiring /1000 or 24*60*60
		ARCEUS_FOLDERS.CONFIGS:WriteJsonFile(EXPLOIT_CONFIGS.LICENSE_FILE, framework.utils.http.json.encode(json), EXPLOIT_CONFIGS.FILES_KEY)

		authData = json
		return true, json.message
	end

	--[[ function auth:Restore()
		if not exploit:LoadUrl(`{endpoints.api}/deletekey?hwid={exploit:GetHwid()}`, 3) then
			return false
		end

		authData.hwid = exploit:GetHwid()
		authData.authenticated = false
		authData.issuedAt = 0
		authData.expiring = 0

		local data = framework.utils.crypt.bytes(framework.utils.http.json.encode(authData), EXPLOIT_CONFIGS.FILES_KEY)
		ARCEUS_FOLDERS.CONFIGS:WriteFile(EXPLOIT_CONFIGS.LICENSE_FILE, data)
		return true
	end

	function auth:IsPremium()
		return authData.isPremium or (authData.plan or 0) >= 3 -- premium or higher
	end

	function auth:GetPlan()
		if not authData.authenticated then return false end
		local planId = authData.plan or 0

		local info = plan_infos[framework.utils.maths.clamp(planId, 0, #plan_infos) +1]
		info = framework.utils.tables.deepCopy(info)
		info.id = planId

		return info
	end]]

	function auth:GetVersion()
		--[[ local file = exploit:IsIos() and LPH_ENCSTR("ios-version") or (exploit:IsVng() and LPH_ENCSTR("version-vng") or LPH_ENCSTR("version"))
		return exploit:LoadUrl(`{endpoints.arceus_neo}/{file}`, 0) ]]
		
		local vng = exploit:IsVng() and LPH_ENCSTR("_vng") or ""
		local type = exploit:IsIos() and LPH_ENCSTR("ios") or (LPH_ENCSTR("android") ..vng)
		return getInfos()[LPH_ENCSTR("version")][type]
	end

	function auth:IsKeyless()
		return getInfos()[LPH_ENCSTR("keyless")] or false
	end

	function auth:UsingLicense()
		return getInfos()[LPH_ENCSTR("authfile")]
	end

	function auth:GetExpiring()
		return authData.issuedAt and authData.expiring -(tim() -authData.issuedAt) or 0
	end

	framework.dependencies:Add(LPH_ENCSTR("auth"), framework.protected:ProtectTable(auth))
end

do -- Shared methods
	local players = framework.protected:GetService("Players")
	local sh = {}
	
	sh.antiAfk = framework.protected:GCProtect(LPH_NO_VIRTUALIZE(function()
		local GC = framework.env.getconnections
			or framework.env.get_signal_cons
		
		if GC then
			for i,v in pairs(GC(players.LocalPlayer.Idled)) do
				if v["Disable"] then
					v["Disable"](v)
				elseif v["Disconnect"] then
					v["Disconnect"](v)
				end
			end
		else
			local VirtualUser = framework.protected:GetService("VirtualUser")
			players.LocalPlayer.Idled:Connect(function()
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end
	end))
	
	framework.dependencies:Add("shared", framework.protected:ProtectTable(sh))
end

do -- INIT
	local name, ver = framework.env.identifyexecutor()
	local isStudio = framework.protected:IsStudio()

	if not isStudio then -- Check for exploit identity
		if not name or not ver then return end
		local found = name:lower():find(EXPLOIT_CONFIGS.EXPLOIT_IDENTITY:lower())
		if not found then return end
	else -- Check if its authorized to run in studio
		local succ, err = pcall(function()
			return script.Auth.Value == EXPLOIT_CONFIGS.FILES_KEY
		end)

		if not succ or not err then
			return framework.console.error(LPH_ENCSTR("Missing Authorization"))
		end
	end

	do -- On UI updated
		local old = ARCEUS_FOLDERS.CONFIGS:ReadJsonFile(EXPLOIT_CONFIGS.VERSION_FILE, EXPLOIT_CONFIGS.FILES_KEY)
		framework.utils.versioning:SetVersion(EXPLOIT_CONFIGS.UI_VERSION)

		if old and old.version and framework.utils.versioning:Compare(old.version) == framework.enums.versioning.older then -- UI Updated
			for _, file in ipairs(ARCEUS_FOLDERS.RAW:ListFiles()) do -- Reset raw content
				ARCEUS_FOLDERS.RAW:DeleteFile(file)
			end
		end

		ARCEUS_FOLDERS.CONFIGS:WriteJsonFile(EXPLOIT_CONFIGS.VERSION_FILE, {
			version = EXPLOIT_CONFIGS.UI_VERSION
		}, EXPLOIT_CONFIGS.FILES_KEY)
	end
	
	-- Migrate
	framework.dependencies.exploit:Migrate()

	-- Build UI
	local shandler = framework.dependencies.shandler
	local tabs = framework.dependencies.editortabs
	local libgui = framework.dependencies.gui
	
	local ui = libgui:Draw(framework) -- Draw
	framework.settings:LoadSettings() -- Update
	tabs:GetSelection():GetData()
		.instance:Select()
	
	libgui:LoadAnimations()
	ui:SetEnabled(true)
	shandler:Start()
	
	do
		local fps = framework.settings:GetSetting("Setting_Fps")
		if fps ~= 60 then
			framework.env.setfpscap(fps or 60)
		end
		
		local afk = not not framework.settings:GetSetting("Setting_Afk")
		if afk then
			if framework.env.WHWKIWIOSU then
				framework.env.WHWKIWIOSU(afk)
			else
				framework.dependencies.shared.antiAfk()
			end
		end
	end
	
	local loading = ui.getLoading()
	if framework.settings:GetSetting("User_Intro") then
		loading:Advance(3)
	else
		loading:Skip(4)
	end

	if not isStudio then -- Check for exploit versioning
		local auth = framework.dependencies.auth

		local newer = auth:GetVersion()
		framework.utils.versioning:SetVersion(ver or "0.0.0")

		if framework.utils.versioning:Compare(newer) == framework.enums.versioning.newer then
			libgui.utils:ShowToast("ButtonToast", {
				Id = "Update",
				Style = "confirm",
				
				AdditionalText = {"An update is available. Download?", "Un aggiornamento è disponibile. Scaricare?"},
				AdditionalTitle = {"Update", "Aggiornamento"},
				
				Callback = function(res: boolean)
					if not res then return end
					framework.utils.http:OpenUrl("https://spdmteam.com/")
				end
			})
		end

		if not auth:IsKeyless() then
			auth.OnAuthenticationAttemp:Connect(framework.protected:GCProtect(function(retries: number)
				--framework.console.print(`Authenticating.. {(retries > 1) and `({retries})` or ""}`) 
			end))
			
			--[[local waitEvent = framework.signals.newEvent()
			local function waitPhase()
				task.spawn(loading.Skip, loading, 5, function()
					waitEvent:Fire()
				end)
				
				waitEvent:Wait()
			end]]
			
			loading:Skip(4)
			--waitPhase()
			
			local succ, msg = auth:Authenticate()
			while not succ do
				if msg then libgui.utils:ShowToast("ButtonToast", { AdditionalText = msg }) end
				loading:Skip(5, function() end)
				--waitPhase()
				
				succ, msg = auth:Authenticate()
			end
			
			--framework.console.print("Subscription found")
			--waitEvent:Remove()
		end
	else -- Dev Info
		framework.console.print("UI Instances:", #ui.instance:GetDescendants())
	end

	local serverside = framework.dependencies.serverside
	task.spawn(serverside.Connect, serverside)
	loading:Skip(6)
	
	do -- Advanced auto-execution
		local gameId, placeId = game.GameId, game.PlaceId
		local advanceExecute = framework.protected:GCProtect(LPH_JIT(function(source: string, data: {any})
			if data and data.autoexecute then
				if data.whitelist and (data.games or data.places) then
					local whitelisted = (data.games or {})[gameId]

					if not whitelisted then
						if whitelisted == false then return end
						whitelisted = (data.places or {})[placeId]
						if not whitelisted then return end
					end
				end

				framework.execution:Execute(source)
			end
		end))
		
		local recursiveAutoexec
		recursiveAutoexec = framework.protected:GCProtect(LPH_JIT(function(files: {string})
			for _, file in ipairs(files) do
				if framework.storage.isFolder(nil, file) then
					recursiveAutoexec(framework.storage.listFiles(nil, file))
					continue
				end

				local src = framework.storage.readFile(nil, file)
				if not src then continue end

				local data, source = framework.dependencies.exploit:GetMetadata(src)	
				advanceExecute(source, data)
			end
		end))
		
		local tabs = framework.dependencies.editortabs:GetTabs()
		for _, tab in ipairs(tabs) do
			advanceExecute(tab:GetSource(), tab:GetProperties())
		end
		
		task.spawn(recursiveAutoexec, ARCEUS_FOLDERS.SCRIPT_HUB:ListFiles())
	end
	
	do
		local stgui = framework.protected:GetService("StarterGui")
		local axintelligence = framework.dependencies.axintelligence
		local track = framework.dependencies.track
		
		axintelligence:AddCustomFunction("stop", "stops the current playing song", "stop(): nil", function() track:Stop() end)
		axintelligence:AddCustomFunction("close", "closes the UI", "close(): nil", ui.close)
		axintelligence:AddCustomFunction("open", "opens the UI", "open(): nil", ui.open)
		
		axintelligence:AddCustomFunction("learn", "makes you, arcy, learn new functions by providing the required parameters, use this when you are asked to learn new abilities", "learn(functName: string, functDescription: string, functDefinition: string, funct: (any) -> ())", function(...: any)
			axintelligence:AddCustomFunction(...)
		end)
		
		axintelligence:AddCustomFunction("translate", "translates the UI text into the preset languages", "translate(CountryCode: string): nil", function(country_code: string)
			local cc = framework.utils.strings.upper(country_code)
			if not framework.enums.CountryCode[cc] then return end
			framework.settings:SetSetting("Country_Code", cc)
		end)

		axintelligence:AddCustomFunction("size", "resizes the UI with the preset states: Base, Large, Full", "size(state: string): nil", function(state: string)
			state = framework.enums.WindowState[state]
			if not state then return end
			
			ui.open()
			ui.nextSize(state)
		end)
		
		axintelligence:AddCustomFunction("play", "plays or stops music by roblox asset id, if the id is nil it toggles the current song", "play(id: number|nil): nil", function(id: number)
			if id and tonumber(id) then track:Play(id) else
				track:Toggle()
			end
		end)
		
		axintelligence:AddCustomFunction("console", "toggles the roblox console using the on/off status", "console(status: boolean): nil", function(status: boolean)
			stgui:SetCore("DevConsoleVisible", status)
		end)
	end
	
	do -- Plugins
		local plugins = framework.dependencies.plugins
		local loadPlugins = framework.protected:GCProtect(LPH_JIT(function()
			local res = framework.utils.http:Request(`{endpoints.arceus_v}/plugins.json`)
			if res then local default = framework.utils.http.json.decode(res.Body)
				for _, content in ipairs(default or {}) do
					plugins:Add(content)
				end
			end

			for _, url in ipairs(plugins:GetSaved()) do
				local res = framework.utils.http:Request(url, "GET")
				if not res then continue end
				
				local json = framework.utils.http.json.decode(res.Body)
				if not json then continue end
				
				json.url = url
				plugins:Add(json)
			end
			
			if isStudio then
				plugins:Add(require("../Arceus Hub/raw"))
			end
		end))

		task.spawn(loadPlugins)
	end
end