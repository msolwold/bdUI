local bdUI, c, l = unpack(select(2, ...))
local mod = bdUI:get_module("Nameplates")

function mod:friendly_style(self, event, unit)
	local config = mod._config
	
	if (self.currentStyle and self.currentStyle == "friendly") then return end
	self.currentStyle = "friendly"
end