local S, C, L, DB = unpack(select(2, ...))
-- 隐藏小队框体
for i = 1, MAX_PARTY_MEMBERS do
	local PartyMemberFrame = _G["PartyMemberFrame"..i]
	PartyMemberFrame:UnregisterAllEvents()
	PartyMemberFrame:Hide()
	PartyMemberFrame.Show = function() end
end
UIParent:UnregisterEvent("RAID_ROSTER_UPDATE")

-- 隐藏BOSS框体
for i = 1, 4 do
	local BossFrame = _G["Boss"..i.."TargetFrame"]
	BossFrame:UnregisterAllEvents()
	BossFrame.Show = function () end
	BossFrame:Hide()
end

-- 移动任务追踪框体
local wf = WatchFrame
local wfmove = false 

wf:SetMovable(true);
wf:SetClampedToScreen(false); 
wf:ClearAllPoints()
wf:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -35, -200)
wf:SetWidth(250)
wf:SetHeight(500)

wf:SetUserPlaced(true)
wf.SetPoint = function() end
wfg = CreateFrame("Frame")
wfg:SetPoint("TOPLEFT", wf, "TOPLEFT")
wfg:SetPoint("BOTTOMRIGHT", wf, "BOTTOMRIGHT")
wfg.text = S.MakeFontString(wfg, 10)
wfg.text:SetText("点我拖动")
wfg.text:SetPoint("TOP", wfg, "TOP")
S.MakeShadow(wfg, 3)
S.MakeBG(wfg, 0)
wfg:Hide()
local function WATCHFRAMELOCK()
	if wfmove == false then
		wfmove = true
		wfg:Show()
		print("|cffFFD700任务追踪框|r |cff228B22解锁|r")
		wf:EnableMouse(true);
		wf:RegisterForDrag("LeftButton"); 
		wf:SetScript("OnDragStart", wf.StartMoving); 
		wf:SetScript("OnDragStop", wf.StopMovingOrSizing);
	elseif wfmove == true then
		wf:EnableMouse(false);
		wfmove = false
		wfg:Hide()
		print("|cffFFD700任务追踪框|r |cffFF0000锁定|r")
	end
end

SLASH_WATCHFRAMELOCK1 = "/wf"
SlashCmdList["WATCHFRAMELOCK"] = WATCHFRAMELOCK

-- 屏蔽系统红字提示
local Event = CreateFrame("Frame")
UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
Event.UI_ERROR_MESSAGE = function(self, event, error)
	if not stuff[error] then
		UIErrorsFrame:AddMessage(error, 1, .1, .1)
	end
end	
Event:RegisterEvent("UI_ERROR_MESSAGE")

-- 实名好友弹窗位置修正
BNToastFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("BOTTOMLEFT", ChatFrame1Tab, "TOPLEFT", 0, 0)
end)