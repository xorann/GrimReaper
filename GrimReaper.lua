--[[
    Addon created by Dorann
	
	Shows the last three hits after a player dies.
--]]

------------------------------
-- Initialization      		--
------------------------------
local L = AceLibrary("AceLocale-2.2"):new("Grim Reaper")

GrimReaper = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0")
GrimReaper.revision = 1
GrimReaper:RegisterDB("GrimReaperDB")
GrimReaper.cmdtable = {
	type = "group",
	handler = GrimReaper,
	args = {
	--[[	version = {
			type = "execute",
			name = L["Version Query"],
			desc = L["Runs a version query on GrimReaper."],
			func = function() GrimReaper:QueryVersion() end,
		},]]
	}
}
GrimReaper:RegisterChatCommand({"/grimreaper"}, GrimReaper.cmdtable)

GrimReaper.defaultDB = {
}


function GrimReaper:OnInitialize()
	-- Called when the addon is loaded
end

function GrimReaper:OnEnable()
	-- Called when the addon is enabled	
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
		
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS", "CombatLog")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", "CombatLog")	
	
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
end

function GrimReaper:OnDisable()
	-- Called when the addon is disabled
end


------------------------------
-- Variables     			--
------------------------------
local raid = {}

----------------------
-- Event Handlers  	--
----------------------
function GrimReaper:PLAYER_REGEN_DISABLED()
	raid = {}
	
	for i = 1, GetNumRaidMembers() do
		--local _name, _rank, _subgroup, _level, _class, _fileName, _zone, _online, _isDead, _role, _isML = GetRaidRosterInfo(i)
		local name = GetRaidRosterInfo(i)
		raid[name] = {
			[1] = { t = nil, m = nil },
			[2] = { t = nil, m = nil },
			[3] = { t = nil, m = nil }
		}
	end
end

function GrimReaper:CombatLog(msg)	
	local start, ending, source, target, _ = string.find(msg, L["trigger_hit"])	
	if not start then
		start, ending, source, target = string.find(msg, L["trigger_crit"])
	end
	if not start then
		start, ending, target = string.find(msg, L["trigger_dot"])
	end
	
	if start then
		if target and raid[target] ~= nil then			
			table.insert(raid[target], { t = GetTime(), m = msg })
			table.remove(raid[target], 1)
		end
	end
end

local function getTimeDifference(time1, time2)
    local digits = 1
    local shift = 10 ^ digits
    local result = floor((time2 - time1) * shift + 0.5) / shift
    
    return result
end

local function formatMessage(msg, time) 
	local start, ending, _a, _b, _c = string.find(msg, "(.+) ([%d]+)(.+)");
	local t = getTimeDifference(time, GetTime())
	
	local formatted = "\n|c0000ff00" .. t .. "s|r: " .. _a .. " |cffA60000" .. _b .. "|r" .. _c
	
	return formatted
end

function GrimReaper:CHAT_MSG_COMBAT_FRIENDLY_DEATH(msg)
	local start, ending, name = string.find(msg, L["trigger_death"])
	if name and raid[name] then
		local log = "|cffA60000" .. name .. "|r" .. " died:"
		
		for row, data in pairs(raid[name]) do
			if data["m"] then
				log = log .. formatMessage(data["m"], data["t"])
			end
		end
		
		GrimReaper:Print(log)
	end
end

function GrimReaper:Test()
	GrimReaper:PLAYER_REGEN_DISABLED()
	GrimReaper:CombatLog("Someone hits "..UnitName("player").." for 123.")
	GrimReaper:CombatLog("Someone's Fireball crits "..UnitName("player").." for 456.")
	GrimReaper:CombatLog("Someone hits "..UnitName("player").." for 789. (123 blocked)")
	GrimReaper:CHAT_MSG_COMBAT_FRIENDLY_DEATH(UnitName("player").." dies.")
end
