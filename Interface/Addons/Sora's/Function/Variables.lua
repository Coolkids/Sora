-- Engines
local _, _, _, DB = unpack(select(2, ...))
local Media = "InterFace\\AddOns\\Sora's\\Media\\"
local Launch = CreateFrame("Frame")
Launch:RegisterEvent("PLAYER_ENTERING_WORLD")
Launch:SetScript("OnEvent", function(self, event)
	for i = 1, GetNumAddOns() do
		if IsAddOnLoaded(i) then
			for _, v in pairs({GetAddOnInfo(i)}) do
				if v and type(v) == 'string' and (v:lower():find("BigFoot") or v:lower():find("Duowan") or v:lower():find("163UI") or v:lower():find("FishUI") or v:lower():find("大脚") or v:lower():find("大腳") or v:lower():find("多玩")) then
					print("侦测到您正在使用大脚或者魔盒,为了让您用的舒适所以插件自我关闭掉.如想使用本插件请完全删除大脚或者魔盒")
					DB.Nuke = true else DB.Nuke = false  end
				end
			end
		end
	self:UnregisterEvent("PLAYER_ENTERING_WORLD" )
end)
DB.MyClass = select(2, UnitClass("player"))
DB.MyClassColor = RAID_CLASS_COLORS[DB.MyClass]
DB.Font = ChatFrame1:GetFont()
DB.bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"
DB.Icon = "Interface\\Addons\\Sora's\\Modules\\Chat\\Icon\\"
DB.GlowTex = Media.."GlowTex"
DB.Statusbar = Media.."Statusbar"
DB.ThreatBar = Media.."ThreatBar"
DB.Solid = Media.."Solid"
DB.Button = Media.."Button"
DB.ArrowT = Media.."ArrowT"
DB.Arrow = Media.."Arrow"
DB.Warning = Media.."Warning.mp3"
DB.RaidBuffPos = {"TOPLEFT", Minimap, "BOTTOMLEFT", -5, -25}
DB.ClassBuffPos = {"CENTER", UIParent, -100, 150}
DB.TooltipPos = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -50, 201}
DB.AWStatusbar = Media.."Statusbar"
DB.AWGlowTex = Media.."GlowTex"
DB.AWSolid = Media.."Solid"