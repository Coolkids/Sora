﻿local S, _, L, DB = unpack(select(2, ...))

local button = CreateFrame("Button", "ButtonP", ChatFrame1)
		button:SetPoint("TOP", ButtonE, "BOTTOM", 0, -5)
		button:SetSize(20, 20)
		button.text = button:CreateFontString(nil, 'OVERLAY')
		button.text:SetFont(DB.Font, 12, "THINOUTLINE")
		button.text:SetText("P")
		button.text:SetPoint("CENTER", 3, 0)
		button.text:SetTextColor(23/255, 132/255, 209/255)
		button:SetScript("OnMouseUp", function(self)
			local channels = {GetChannelList()}
			local isInCustomChannel = false
			local customChannelName = "大脚世界频道"
			for i =1, #channels do
				if channels[i] == customChannelName then
					isInCustomChannel = true
				end
			end
			 if isInCustomChannel then
				  print("离开大脚世界频道")
				 LeaveChannelByName(customChannelName)
			  else
				 JoinPermanentChannel(customChannelName,nil,1)
				 print("加入大脚世界频道")
				 ChatFrame_AddChannel(ChatFrame1,customChannelName)
				 ChatFrame_RemoveMessageGroup(ChatFrame1,"CHANNEL")
   end
		end)
		button:SetScript("OnEnter",  function(self)
			local channels = {GetChannelList()}
			local customChannelName = "大脚世界频道"
			local inchannel = "关闭"
		for i =1, #channels do
				if channels[i] == customChannelName then
					 inchannel = "开启"
					 else
					 inchannel = "关闭"
				end
			end
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		GameTooltip:AddLine("大脚世界频道开关", 0.75, 0.9, 1)
		GameTooltip:AddLine("点击进入或者离开")
		GameTooltip:AddLine("您现在大脚世界频道处于"..""..inchannel.."".."状态")
		GameTooltip:Show()  end)
		button:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
		S.MakeBG(button, 0)
		S.Reskin(button)