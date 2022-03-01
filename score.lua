--high score logic
function updateHiScore()
	if gameOver then
		if gameMode == 1 and score == hiScoreArcade then
			local data = 0 --store score
			data = hiScoreArcade
			lf.write("savedata_arcade.txt", tostring(data))
		end
		if gameMode == 2 and score == hiScoreEndless then
			local data = 0 --store score
			data = hiScoreEndless
			lf.write("savedata_endless.txt", tostring(data))
		end
		if gameMode == 3 and score == hiScoreExtra then
			local data = 0 --store score
			data = hiScoreExtra
			lf.write("savedata_extra.txt", tostring(data))
		end
	end
end

--manually save high score for arcade mode
function saveHiScore()
	if gameMode == 1 and score == hiScoreArcade then
		local data = 0 --store score
		data = hiScoreArcade
		lf.write("savedata_arcade.txt", tostring(data))
	end
end

function loadHiScore()
	--check if savedata exists, if not, then make it
	if not lf.getInfo("savedata_arcade.txt") then
		local data = 100000 --default high score
		lf.write("savedata_arcade.txt", tostring(data))
	end
	if not lf.getInfo("savedata_endless.txt") then
		local data = 200000 --default high score
		lf.write("savedata_endless.txt", tostring(data))
	end
	if not lf.getInfo("savedata_extra.txt") then
		local data = 300000 --default high score
		lf.write("savedata_extra.txt", tostring(data))
	end
	--load data
	local loadedArcade = lf.read("string", "savedata_arcade.txt")
	local loadedEndless = lf.read("string", "savedata_endless.txt")
	local loadedExtra = lf.read("string", "savedata_extra.txt")
	--copy hi score from data
	hiScoreArcade = tonumber(loadedArcade)
	hiScoreEndless = tonumber(loadedEndless)
	hiScoreExtra = tonumber(loadedExtra)
end