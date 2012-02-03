﻿-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))
local Sora = LibStub("AceAddon-3.0"):GetAddon("Sora")
local Module = Sora:NewModule("BossFrame")

local function BuildMenu(self)
	local unit = self.unit:sub(1, -2)
	local cunit = self.unit:gsub("^%l", string.upper)

	if cunit == "Vehicle" then cunit = "Pet" end

	if unit == "party" or unit == "partypet" then
		ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor", 0, 0)
	elseif _G[cunit.."FrameDropDown"] then
		ToggleDropDownMenu(1, nil, _G[cunit.."FrameDropDown"], "cursor", 0, 0)
	end
end

local function BuildHealthBar(self)
	local Bar = CreateFrame("StatusBar", nil, self)
	Bar:SetStatusBarTexture(DB.Statusbar)
	Bar:SetHeight(24)
	Bar:SetWidth(self:GetWidth())
	Bar:SetPoint("TOP", 0, 0)
	Bar.Shadow = S.MakeShadow(Bar, 3)
	Bar.BG = Bar:CreateTexture(nil, "BACKGROUND")
	Bar.BG:SetTexture(DB.Statusbar)
	Bar.BG:SetAllPoints()
	Bar.BG:SetVertexColor(0.1, 0.1, 0.1)
	Bar.BG.multiplier = 0.2
	
	Bar.frequentUpdates = true
	Bar.colorSmooth = true
	Bar.colorClass = true
	Bar.colorReaction = true
	Bar.Smooth = true
	Bar.colorTapping = true
		
	self.Health = Bar
end

local function BuildPowerBar(self)
	local Bar = CreateFrame("StatusBar", nil, self)
	Bar:SetStatusBarTexture(DB.Statusbar)
	Bar:SetWidth(self:GetWidth())
	Bar:SetHeight(2)
	Bar:SetPoint("BOTTOM", self, "BOTTOM", 0, 0)
	Bar.Shadow = S.MakeShadow(Bar, 3)
	Bar.BG = Bar:CreateTexture(nil, "BACKGROUND")
	Bar.BG:SetTexture(DB.Statusbar)
	Bar.BG:SetAllPoints()
	Bar.BG:SetVertexColor(0.1, 0.1, 0.1)
	Bar.BG.multiplier = 0.2
	
	Bar.frequentUpdates = true
	Bar.Smooth = true
	Bar.colorPower = true
		
	self.Power = Bar
end

local function BuildPortrait(self)
	local Portrait = CreateFrame("PlayerModel", nil, self.Health)
	Portrait:SetAlpha(0.3) 
	Portrait.PostUpdate = function(self) 
		if self:GetModel() and self:GetModel().find and self:GetModel():find("worgenmale") then
			self:SetCamera(1)
		end	
	end
	Portrait:SetAllPoints()
	Portrait:SetFrameLevel(self.Health:GetFrameLevel()+1)
	Portrait:RegisterEvent("PLAYER_REGEN_DISABLED")
	Portrait:RegisterEvent("PLAYER_REGEN_ENABLED")
	Portrait:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(self, 0.5, 0.3, 0)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(self, 0.5, 0, 0.3)
		end
	end)
	
	self.Portrait = Portrait
end

local function BuildTags(self)
	local Name = S.MakeFontString(self.Health, 11)
	Name:SetPoint("LEFT", 5, 0)
	self:Tag(Name, "[Sora:level] [Sora:color][name]")
	Name:SetAlpha(0)
	local HPTag = S.MakeFontString(self.Health, 11)
	HPTag:SetPoint("RIGHT", 0, 0)
	self:Tag(HPTag, "[Sora:color][Sora:hp]")
	HPTag:SetAlpha(0)
	local PPTag = S.MakeFontString(self.Power, 9)
	PPTag:SetPoint("RIGHT", 0, 0)
	self:Tag(PPTag, "[Sora:pp]")
	PPTag:SetAlpha(0)

	local Event = CreateFrame("Frame")
	Event:RegisterEvent("PLAYER_REGEN_DISABLED")
	Event:RegisterEvent("PLAYER_REGEN_ENABLED")
	Event:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_REGEN_DISABLED" then
			UIFrameFadeIn(Name, 0.5, 0, 1)
			UIFrameFadeIn(HPTag, 0.5, 0, 1)
			UIFrameFadeIn(PPTag, 0.5, 0, 1)
		elseif event == "PLAYER_REGEN_ENABLED" then
			UIFrameFadeOut(Name, 0.5, 1, 0)
			UIFrameFadeOut(HPTag, 0.5, 1, 0)
			UIFrameFadeOut(PPTag, 0.5, 1, 0)	
		end
	end)
	self:HookScript("OnEnter", function()
		if not UnitAffectingCombat("player") then
			UIFrameFadeIn(self.Portrait, 0.5, 0.3, 0)
			UIFrameFadeIn(Name, 0.5, 0, 1)
			UIFrameFadeIn(HPTag, 0.5, 0, 1)
			UIFrameFadeIn(PPTag, 0.5, 0, 1)
		end
	end)
	self:HookScript("OnLeave", function()
		if not UnitAffectingCombat("player") then
			UIFrameFadeOut(self.Portrait, 0.5, 0, 0.3)
			UIFrameFadeOut(Name, 0.5, 1, 0)
			UIFrameFadeOut(HPTag, 0.5, 1, 0)
			UIFrameFadeOut(PPTag, 0.5, 1, 0)
		end
	end)
end

local function BuildCastbar(self)
	local Castbar = CreateFrame("StatusBar", nil, self)
	Castbar:SetHeight(10)
	Castbar:SetWidth(self:GetWidth()-70)
	Castbar:SetStatusBarTexture(DB.Statusbar)
	Castbar:SetStatusBarColor(95/255, 182/255, 255/255, 1)
	Castbar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 0, 14)
	
	Castbar.Shadow = S.MakeShadow(Castbar, 3)
	Castbar.Shadow:SetBackdrop({
		bgFile = DB.Statusbar,insets = {left = 3, right = 3, top = 3, bottom = 3}, 
		edgeFile = DB.GlowTex, edgeSize = 3, 
	})
	Castbar.Shadow:SetBackdropColor(0, 0, 0, 0.5)
	Castbar.Shadow:SetBackdropBorderColor(0, 0, 0, 1)
	
	Castbar.CastingColor = {95/255, 182/255, 255/255}
	Castbar.CompleteColor = {20/255, 208/255, 0/255}
	Castbar.FailColor = {255/255, 12/255, 0/255}
	Castbar.ChannelingColor = {95/255, 182/255, 255/255}

	Castbar.Text = S.MakeFontString(Castbar, 10)
	Castbar.Text:SetPoint("LEFT", 2, 0)
	
	Castbar.Time = S.MakeFontString(Castbar, 10)
	Castbar.Time:SetPoint("RIGHT", -2, 0)
	
	Castbar.Icon = Castbar:CreateTexture(nil, "ARTWORK")
	Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Castbar.Icon:SetSize(20, 20)
	Castbar.Icon:SetPoint("TOPLEFT", Castbar, "TOPRIGHT", 8, 0)
	Castbar.Icon.Shadow = S.MakeTexShadow(Castbar, Castbar.Icon, 3)

	Castbar.OnUpdate = S.OnCastbarUpdate
	Castbar.PostCastStart = S.PostCastStart
	Castbar.PostChannelStart = S.PostCastStart
	Castbar.PostCastStop = S.PostCastStop
	Castbar.PostChannelStop = S.PostChannelStop
	Castbar.PostCastFailed = S.PostCastFailed
	Castbar.PostCastInterrupted = S.PostCastFailed

	self.Castbar = Castbar
end

local function PostCreateIcon(self, Button)
	Button.Shadow = S.MakeShadow(Button, 3)
	Button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	Button.icon:SetAllPoints()
	Button.count = S.MakeFontString(Button, 9)
	Button.count:SetPoint("TOPRIGHT", Button, 3, 0)
end
  
local function PostUpdateIcon(self, unit, Button, index, offset, filter, isDebuff)
	local Caster = select(8, UnitAura(unit, index, Button.filter))
	if Button.debuff then
		if Caster == "player" or Caster == "vehicle" then
			Button.icon:SetDesaturated(false)                 
		elseif not UnitPlayerControlled(unit) then -- If Unit is Player Controlled dont desaturate debuffs
			Button:SetBackdropColor(0, 0, 0)
			Button.overlay:SetVertexColor(0.3, 0.3, 0.3)      
			Button.icon:SetDesaturated(true)  
		end
	end
end

local function BuildBuff(self)
	Buff = CreateFrame("Frame", nil, self)
	Buff:SetPoint("TOPRIGHT", self, "TOPLEFT", -8, 0)
	Buff.initialAnchor = "TOPRIGHT"
	Buff["growth-x"] = "LEFT"
	Buff["growth-y"] = "DOWN"
	Buff.size = 20
	Buff.num = 18
	Buff.spacing = 5
	Buff:SetWidth((Buff.size+Buff.spacing)*6-Buff.spacing)
	Buff:SetHeight((Buff.size+Buff.spacing)*3)
	Buff.PostCreateIcon = PostCreateIcon
	Buff.PostUpdateIcon = PostUpdateIcon

	self.Buffs = Buff
end

local function BuildDebuff(self)
	Debuff = CreateFrame("Frame", nil, self)
	Debuff.size = 20
	Debuff.num = 23
	Debuff.spacing = 5
	Debuff:SetHeight((Debuff.size+Debuff.spacing)*5)
	Debuff:SetWidth(self:GetWidth())
	Debuff:SetPoint("TOPLEFT", self.Power, "BOTTOMLEFT", 0, -5)
	Debuff.initialAnchor = "TOPLEFT"
	Debuff["growth-x"] = "RIGHT"
	Debuff["growth-y"] = "DOWN"
	Debuff.PostCreateIcon = PostCreateIcon
	Debuff.PostUpdateIcon = PostUpdateIcon

	self.Debuffs = Debuff
end

local function BuildRaidIcon(self)
	local RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(16, 16)
	RaidIcon:SetPoint("CENTER", self.Health, "TOP", 0, 2)
	self.RaidIcon = RaidIcon
end

local function BuildCombatIcon(self)
	local Leader = self.Health:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(16, 16)
	Leader:SetPoint("TOPLEFT", self.Health, -7, 9)
	self.Leader = Leader
	local Assistant = self.Health:CreateTexture(nil, "OVERLAY")
	Assistant:SetAllPoints(Leader)
	self.Assistant = Assistant
	local MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(16, 16)
	MasterLooter:SetPoint("LEFT", Leader, "RIGHT")
	self.MasterLooter = MasterLooter
end

local function BuildBossFrame(self, ...)
	-- RegisterForClicks
	self.menu = BuildMenu
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self:RegisterForClicks("AnyUp")
	
	-- Set Size and Scale
	self:SetSize(220, 30)
	
	-- BuildHealthBar
	BuildHealthBar(self)
	
	-- BuildPowerBar
	BuildPowerBar(self)
	
	-- BuildPortrait
	BuildPortrait(self)
	
	-- BuildTags
	BuildTags(self)
	
	-- BuildCastbar
	if UnitFrameDB.ShowBossCastbar then BuildCastbar(self) end
	
	-- BuildBuff(self)
	if UnitFrameDB.ShowBossBuff then BuildBuff(self) end

	-- BuildDebuff
	if UnitFrameDB.ShowBossDebuff then BuildDebuff(self) end
		
	-- BuildRaidMark
	BuildRaidIcon(self)
	
	-- BuildCombatIcon
	BuildCombatIcon(self)
end

function Module:OnInitialize()
	if not UnitFrameDB.ShowBoss then return end
	oUF:RegisterStyle("SoraBoss", BuildBossFrame)
	oUF:SetActiveStyle("SoraBoss")
	DB.BossFrame = {}
	local BossFramePos = CreateFrame("Frame", nil, UIParent)
	BossFramePos:SetSize(220, 30*MAX_BOSS_FRAMES+60*(MAX_BOSS_FRAMES-1))
	MoveHandle.BossFrame = S.MakeMoveHandle(BossFramePos, "首领框体", "BossFrame")
	for i = 1, MAX_BOSS_FRAMES do
		DB.BossFrame[i] = oUF:Spawn("boss"..i)
		if i == 1 then
			DB.BossFrame[i]:SetPoint("TOP", BossFramePos)
		else
			DB.BossFrame[i]:SetPoint("TOP", DB.BossFrame[i-1], "BOTTOM", 0, -60)
		end
	end
end