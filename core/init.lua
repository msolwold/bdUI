local addonName, ns = ...

local engine = ns
engine[1] = CreateFrame("Frame", nil, UIParent) -- core ui
engine[2] = {} -- config
engine[3] = {} -- locale
bdUI = engine[1]
bdUI.caches = {}
bdUI.name = addonName
bdUI.class = select(2, UnitClass("player"))
bdUI.classColor = RAID_CLASS_COLORS[bdUI.class]
bdUI.colorString = '|cffA02C2Fbd|r'

--===================================================================
-- Basic Config
--===================================================================
bdUI.media = {
	flat = "Interface\\Buttons\\WHITE8x8",
	arial = "fonts\\ARIALN.ttf",
	smooth = "Interface\\Addons\\"..addonName.."\\media\\smooth.tga",
	font = "Interface\\Addons\\"..addonName.."\\media\\PTSansNarrow.ttf",
	myriad = "Interface\\Addons\\"..addonName.."\\media\\Myriad.ttf",
	arrow = "Interface\\Addons\\"..addonName.."\\media\\arrow.tga",
	align = "Interface\\Addons\\"..addonName.."\\media\\align.tga",
	shadow = "Interface\\Addons\\"..addonName.."\\media\\shadow.blp",
	fonts = {},
	backgrounds = {},
	border = {.03, .04, .05, 1},
	backdrop = {.08, .09, .11, 0.9},
	red = {.62, .17, .18, 1},
	blue = {.2, .4, 0.8, 1},
	green = {.1, .7, 0.3, 1},
}

--===================================================================
-- Scale & Alt-UIParent 
--===================================================================
bdParent = CreateFrame("frame", "bdUIParent", UIParent)
bdParent:SetPoint("TOPLEFT", UIParent)
bdParent:SetPoint("BOTTOMRIGHT", UIParent)

function bdUI:calculate_scale()
	-- print(bdUI:get_border_size())
	bdUI.screenheight = select(2, GetPhysicalScreenSize())
	bdUI.scale = 768 / bdUI.screenheight
	bdUI.ui_scale = GetCVar("uiScale") or 1
	bdUI.pixel = bdUI.scale / bdUI.ui_scale
	bdUI.border = bdUI.pixel * 2
	bdParent:SetScale(bdUI.scale)
end
bdUI:calculate_scale()

bdUI.hidden = CreateFrame("frame", nil, nil)
bdUI.hidden:Hide()
bdUI.hidden:SetAlpha(0)
bdUI.hidden:SetScale(0.001)
bdUI.hidden.Show = function() return end

--===================================================================
-- Fonts
--===================================================================
bdUI.font_large = CreateFont("BDUI_LARGE")
bdUI.font_large:SetFont(bdUI.media.font, 15, "THINOUTLINE")
bdUI.font_large:SetShadowColor(0, 0, 0)
bdUI.font_large:SetShadowOffset(0, 0)

bdUI.font_medium = CreateFont("BDUI_MEDIUM")
bdUI.font_medium:SetFont(bdUI.media.font, 13, "THINOUTLINE")
bdUI.font_medium:SetShadowColor(0, 0, 0)
bdUI.font_medium:SetShadowOffset(0, 0)

bdUI.font_medium = CreateFont("BDUI_SMALL")
bdUI.font_medium:SetFont(bdUI.media.font, 11, "THINOUTLINE")
bdUI.font_medium:SetShadowColor(0, 0, 0)
bdUI.font_medium:SetShadowOffset(0, 0)

-- bdUI.font_small = CreateFont("BDUI_MONO")
-- bdUI.font_small:SetFont(bdUI.media.font, 10, "OUTLINE")
-- bdUI.font_small:SetShadowColor(0, 0, 0)
-- bdUI.font_small:SetShadowOffset(0, 0)

--===================================================================
--Return game version, so that we can have cross version compatibility when possible
--===================================================================
local versions = {}
versions[99999] = "shadowlands"
versions[89999] = "bfa"
versions[79999] = "legion"
versions[69999] = "wod"
versions[59999] = "mop"
versions[49999] = "cataclysm"
versions[39999] = "wrath"
versions[29999] = "tbc"
versions[19999] = "vanilla"
function bdUI:get_game_version()
	local version, build, date, tocversion = GetBuildInfo()

	local game = 0
	local version = 1000000

	for k, v in pairs(versions) do
		if (tocversion < k and k < version) then
			version = k
			game = v
		end
	end

	bdUI.version = version
	bdUI.expansion = game 

	return game
end