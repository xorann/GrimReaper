local L = AceLibrary("AceLocale-2.2"):new("Grim Reaper")

L:RegisterTranslations("enUS", 
	function()
		return {
			--[[trigger_autohitHit = "^(.+) hits (.+) for ([%d]+).", -- Highlord Mograine hits Grok for 295. (133 blocked) (563 absorbed)
			trigger_autohitCrit = "^(.+) crits (.+) for ([%d]+).", -- Thane Korth'azz crits Grok for 362.
			trigger_spellHit = "^(.+)+[%s's]* ([%w%s:]+) hits ([%w]+) for ([%d]+) ([%w]+) damage.", -- Highlord Mograine's Righteous Fire hits Grok for 1046 Fire damage. (1046 resisted)
			trigger_spellCrit = "^[%w]+[%s's]* ([%w%s:]+) crits ([%w]+) for ([%d]+) ([%w]+) damage.", -- Highlord Mograine's Righteous Fire hits Grok for 1046 Fire damage. (1046 resisted)
			trigger_physHit = "^[%w]+[%s's]* ([%w%s:]+) hits ([%w]+) for ([%d]+).", -- Grok's Revenge hits Thane Korth'azz for 124.
			trigger_physCrit = "^[%w]+[%s's]* ([%w%s:]+) crits ([%w]+) for ([%d]+).", -- Grok's Shield Slam crits Highlord Mograine for 533.
			trigger_dot = "^([%w]+) suffers ([%d]+) ([%w]+) damage from [%w]+[%s's]* ([%w%s:]+).", -- Grok suffers 270 Fire damage from Highlord Mograine's Righteous Fire. (270 resisted)	
			trigger_death = "^([%w]+) dies.", -- Skyly dies.]]
			
			trigger_hit = "^(.+) hits (.+) for ([%d])",
			trigger_crit = "^(.+) crits (.+) for ([%d])",
			trigger_dot = "^([%w]+) suffers ([%d]+) ([%w]+) damage from [%w]+[%s's]* ([%w%s:]+).",
			trigger_death = "^([%w]+) dies.", -- Skyly dies.
		}
	end
)
