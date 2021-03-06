﻿-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Sora = LibStub("AceAddon-3.0"):GetAddon("Sora")

-- Init
DB["Modules"]["Skin"] = {}
local Module = DB["Modules"]["Skin"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["EnableDBMSkin"] = true,		-- 启用DBM皮肤
	}
	if not SkinDB then SkinDB = {} end
	for key, value in pairs(Default) do
		if SkinDB[key] == nil then SkinDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(SkinDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["Skin"] =  {
			type = "group", order = 8,
			name = "界面皮肤",
			args = {
				EnableDBMSkin = {
					type = "toggle",
					name = "启用DBM皮肤",
					order = 2,
					get = function() return SkinDB.EnableDBMSkin end,
					set = function(_, value) SkinDB.EnableDBMSkin = value end,
				},
			},
		}
	end
end

