local L = AceLibrary("AceLocale-2.2"):new("Grim Reaper")

L:RegisterTranslations("deDE", 
	function()
		return {
			trigger_hit = "^(.+) trifft (.+) für ([%d])",
			trigger_crit = "^(.+) trifft (.+) kritisch für ([%d])",
			trigger_dot = "^([%w]+) erleidet ([%d]+) ([%w]+) von (.+) (durch (.+)).",
			trigger_death = "^([%w]+) stirbt."
		}
	end
)