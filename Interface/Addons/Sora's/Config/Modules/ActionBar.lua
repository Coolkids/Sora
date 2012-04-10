-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Sora = LibStub("AceAddon-3.0"):GetAddon("Sora")

-- Init
DB["Modules"]["ActionBar"] = {}
local Module = DB["Modules"]["ActionBar"]

-- LoadSettings
function Module.LoadSettings()
	local Default = {
		["HideHotKey"] = false,
		["HideMacroName"] = false,
		["BarLayout"] = 2,
		["Bar4Layout"] = 1,
		["Bar5Layout"] = 1,
		["ButtonSize"] = 24,
		["ButtonSpacing"] = 1,
		["FontSize"] = 12,
	}
	if not ActionBarDB then ActionBarDB = {} end
	for key, value in pairs(Default) do
		if ActionBarDB[key] == nil then ActionBarDB[key] = value end
	end
	wipe(Default)
end

-- ResetToDefault
function Module.ResetToDefault()
	wipe(ActionBarDB)
end

-- BuildGUI
function Module.BuildGUI()
	if DB["Config"] then
		DB["Config"]["ActionBar"] =  {
			type = "group", order = 1,
			name = "动作条",
			args = {
				group1 = {
						type = "group", order = 1,
						name = " ",guiInline = true,
						args = {
						BarLayout = {
							type = "select", order = 1,
							name = "布局：", desc = "请选择主动作条布局",
							values = {[1] = "12x3布局", [2] = "18x2布局"},
							get = function() return ActionBarDB.BarLayout end,
							set = function(_, value) ActionBarDB.BarLayout = value  Sora:GetModule("ActionBar"):BuildActionBar() end,
						},
						Bar4Layout = {
							type = "select", order = 4,
							name = "bar4布局：", desc = "请选择主动作条布局",
							values = {[1] = "12x1布局", [2] = "6x2布局"},
							get = function() return ActionBarDB.Bar4Layout end,
							set = function(_, value) ActionBarDB.Bar4Layout = value Sora:GetModule("ActionBar"):BuildActionBar() end,
						},
						Bar5Layout = {
							type = "select", order = 5,
							name = "bar5布局：", desc = "请选择主动作条布局",
							values = {[1] = "12x1布局", [2] = "6x2布局"},
							get = function() return ActionBarDB.Bar5Layout end,
							set = function(_, value) ActionBarDB.Bar5Layout = value Sora:GetModule("ActionBar"):BuildActionBar() end,
						},
					}
				},
			group2 = {
				type = "group", order = 2,
				name = " ",guiInline = true,
				args = {
					HideHotKey = {
						type = "toggle", order = 1,
						name = "隐藏快捷键显示",			
						get = function() return ActionBarDB.HideHotKey end,
						set = function(_, value) ActionBarDB.HideHotKey = value end,
					},
					HideMacroName = {
						type = "toggle", order = 2,
						name = "隐藏宏名称显示",		
						get = function() return ActionBarDB.HideMacroName end,
						set = function(_, value) ActionBarDB.HideMacroName = value end,
					},
				}
			},
			group3 = {
				type = "group", order = 3,
				name = " ",guiInline = true,
				args = {
					ButtonSize = {
						type = "range", order = 1,
						name = "动作条按钮大小：", desc = "输入主动作条按钮大小",
						min = 16, max = 64, step = 1,
						get = function() return ActionBarDB.ButtonSize end,
						set = function(_, value) ActionBarDB.ButtonSize = value Sora:GetModule("ActionBar"):BuildActionBar() end,
					},
					ButtonSpacing = {
						type = "range", order = 2,
						name = "动作条间距大小：", desc = "输入主动作条间距大小",
						min = 0, max = 6, step = 1,
						get = function() return ActionBarDB.ButtonSpacing end,
						set = function(_, value) ActionBarDB.ButtonSpacing = value Sora:GetModule("ActionBar"):BuildActionBar() end,
					},
					FontSize = {
						type = "range", order = 3,
						name = "动作条字体大小：", desc = "输入主动作条动作条字体大小",
						min = 1, max = 36, step = 1,
						get = function() return ActionBarDB.FontSize end,
						set = function(_, value) ActionBarDB.FontSize = value end,
					},
				}
			},
		}
	}
	end
end


