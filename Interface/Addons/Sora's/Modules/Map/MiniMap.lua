﻿-- Engines
local S, C, L, DB = unpack(select(2, ...))
local Module = LibStub("AceAddon-3.0"):GetAddon("Sora"):NewModule("MiniMap")

Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")
Minimap:SetFrameStrata("BACKGROUND")
Minimap:ClearAllPoints()
Minimap:SetSize(120, 120)
Minimap.Shadow = S.MakeShadow(Minimap, 4)

function Module:OnInitialize()
	MoveHandle.Minimap = S.MakeMoveHandle(Minimap, "小地图", "Minimap")
end

LFGSearchStatus:SetClampedToScreen(true)
LFGDungeonReadyStatus:SetClampedToScreen(true)
DropDownList1:SetClampedToScreen(false)

local frames = {
	"GameTimeFrame",
	"MinimapBorderTop",
	"MinimapNorthTag",
	"MinimapBorder",
	"MinimapZoneTextButton",
	"MinimapZoomOut",
	"MinimapZoomIn",
	"MiniMapVoiceChatFrame",
	"MiniMapWorldMapButton",
	"MiniMapMailBorder",
	"MiniMapBattlefieldBorder",
}

for i in pairs(frames) do
	_G[frames[i]]:Hide()
	_G[frames[i]].Show = function() end
end
MinimapCluster:EnableMouse(false)

--BG icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, 0, -4)

--LFG icon
MiniMapLFGFrame:ClearAllPoints()
MiniMapLFGFrameBorder:SetAlpha(0)
MiniMapLFGFrame:SetPoint("TOPLEFT", Minimap, 0, 4)

MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, 0, 4)
MiniMapInstanceDifficulty:SetScale(0.8)

GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, 0, 4)
GuildInstanceDifficulty:SetScale(0.8)

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, -4)
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Sora's\\Media\\Mail")
MiniMapMailBorder:Hide()
-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, z)
	local c = Minimap:GetZoom()
	if z > 0 and c < 5 then
		Minimap:SetZoom(c+1)
	elseif z < 0 and c > 0 then
		Minimap:SetZoom(c-1)
	end
end)

local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
	{text = CHARACTER_BUTTON,
	func = function() ToggleCharacter("PaperDollFrame") end},
	{text = SPELLBOOK_ABILITIES_BUTTON,
	func = function() ToggleFrame(SpellBookFrame) end},
	{text = TALENTS_BUTTON,
	func = function() ToggleTalentFrame() end},
	{text = ACHIEVEMENT_BUTTON,
	func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON,
	func = function() ToggleFrame(QuestLogFrame) end},
	{text = GUILD,
	func = function() ToggleGuildFrame(1) end},
	{text = PLAYER_V_PLAYER,
	func = function() ToggleFrame(PVPFrame) end},
	{text = "地下城查找器",
	func = function() ToggleFrame(LFDParentFrame) end},
	{text = "地城手冊",func = function() ToggleEncounterJournal() end},
	{text = "團隊查找器", func = function() ToggleFrame(RaidParentFrame) end},
	{text = HELP_BUTTON,
	func = function() ToggleHelpFrame() end},
	{text = "打开背包",
	func = function() ToggleBackpack() end}, 
	{text = L_LFRAID,
	func = function() ToggleFrame(LFRParentFrame) end},
	{text = "行事歷", func = function() if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle() end},
}

Minimap:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)
