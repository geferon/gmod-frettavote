hook.Add( "Initialize", "AutoTTTMapVote", function()
	if GAMEMODE_NAME == "terrortown" then
		-- function CheckForMapSwitch()
		-- 	-- Check for mapswitch
		-- 	local rounds_left = math.max(0, GetGlobalInt("ttt_rounds_left", 6) - 1)
		-- 	SetGlobalInt("ttt_rounds_left", rounds_left)

		-- 	local time_left = math.max(0, (GetConVar("ttt_time_limit_minutes"):GetInt() * 60) - CurTime())
		-- 	local switchmap = false
		-- 	local nextmap = string.upper(game.GetMapNext())

		-- 	if rounds_left <= 0 then
		-- 		LANG.Msg("limit_round", {mapname = nextmap})
		-- 		switchmap = true
		-- 	elseif time_left <= 0 then
		-- 		LANG.Msg("limit_time", {mapname = nextmap})
		-- 		switchmap = true
		-- 	end

		-- 	if switchmap then
		-- 		timer.Stop("end2prep")
		-- 		MapVote.Start()
		-- 	end
		-- end

		// Better solution:
		game.OldLoadNextMap = game.OldLoadNextMap or game.LoadNextMap
		game.LoadNextMap = function()
			MapVote.Start()
		end
	end

	if GAMEMODE_NAME == "deathrun" then
		function RTV.Start()
			MapVote.Start()
		end
	end

	if GAMEMODE_NAME == "zombiesurvival" then
		hook.Add("LoadNextMap", "MAPVOTEZS_LOADMAP", function()
			MapVote.Start()
			return true
		end )
	end

	if GAMEMODE_NAME == "morbusgame" or string.find(GAMEMODE_NAME, "morbusgame") then // Multiple check made because of variations
		hook.Add("Morbus_MapChange", "A_MAPVOTEMB", function()
			MapVote.Start()

			return true // stop other hooks
		end)

		// Remove original mapvote
		hook.Remove("Morbus_MapChange", "SMV_MapHook")
		if (SMV) then
			function RTV(ply)
			end
			function SMV.StartMapVote()
			end
			function SMV.EndMapVote()
			end
		end
	end

end )


