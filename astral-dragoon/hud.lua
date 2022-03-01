function drawHUD()
	if debugMode and not mainMenu and not creditsMenu then
		--top-left
		lg.setColor(255, 255, 255, 255)
		lg.print("FPS:"..lt.getFPS(), 10, 10)
		lg.print(string.format("Time:%03d:%02d:%02d", app.h, app.m, app.s), 10, 30)
		lg.print(string.format("Game:%03d:%02d:%02d", t.h, t.m, t.s), 10, 50)
		lg.print(string.format("Win X:%.0f".." Y:%.0f", win.x, win.y), 10, 70)
		lg.print(string.format("Pla X:%.0f".." Y:%.0f", playerX, playerY), 10, 90)
		lg.print(string.format("Enemy#:%.0f", enemyCount), 10, 110)
		lg.print(string.format("Level Flag:%.0f", levelEnd), 10, 130)
		lg.print(string.format("Boss T:%.0f", bossTimer), 10, 150)
		lg.print(string.format("Score Up:%.0f", scoreUpdate), 10, 170)
		lg.print(string.format("App Time:%.0f", appTimer), 10, 190)
		lg.print(string.format("I Frame:%.0f", player_i_frame), 10, 210)
		lg.print(string.format("Pause:%.0f".." %.0f", pauseTimer, unpauseTimer), 10, 230)
		lg.print(string.format("Debug:%.0f".." %.0f", debugTimer, undebugTimer), 10, 250)
		lg.print(string.format("Fin:%.0f", finishFrame), 10, 270)
		lg.print(string.format("Rdy:%.0f", readyFrame), 10, 290)
		lg.print(string.format("Gar:%.0f", collectgarbage("count")*1024), 10, 310)
		lg.print(string.format("Wave:%.0f", spawnRemaining), 10, 330)
		lg.print(string.format("Step:%.0f", spawnStep), 10, 350)
		lg.print(string.format("Time:%.0f", spawnTimer), 10, 370)
		lg.print(string.format("AlphaFlash:%.1f", alphaFlash), 10, 390)
		lg.print(string.format("AlphaFade:%.1f", alphaFade), 10, 410)
		lg.print(string.format("BombCD:%.0f", bombCD), 10, 430)
	end
	
	if not debugMode and not mainMenu and not creditsMenu then
		--top-left
		if gameMode == 1 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Arcade", 10, 10)
		end
		if gameMode == 2 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Endless", 10, 10)
		end
		if gameMode == 3 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Extra", 10, 10)
		end
		if gameMode == 1 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Normal", 10, 30)
		end
		if player_shotType == 1 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Type-A", 10, 50)
		end
		if player_shotType == 2 then
			lg.setColor(255, 255, 0, 1.0)
			lg.print("Type-B", 10, 50)
		end
		lg.setColor(255, 255, 0, 1.0)
		lg.print("Stage", 10, 70)
		if level == 0 then
			lg.print("1", 80, 70)
		else
			lg.print(string.format("%.0f", level), 80, 70)
		end
		lg.setColor(255, 255, 0, 1.0)
		lg.print("HiScore", 10, 110)
		if gameMode == 1 then
			if score > hiScoreArcade then
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", score), 30, 130)
			else
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", hiScoreArcade), 30, 130)
			end
		end
		if gameMode == 2 then
			if score > hiScoreEndless then
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", score), 30, 130)
			else
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", hiScoreEndless), 30, 130)
			end
		end
		if gameMode == 3 then
			if score > hiScoreExtra then
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", score), 30, 130)
			else
				lg.setColor(255, 255, 255, 1.0)
				lg.print(string.format("%.13d", hiScoreExtra), 30, 130)
			end
		end
		lg.setColor(255, 255, 0, 1.0)
		lg.print("Score", 10, 150)
		lg.setColor(255, 255, 255, 1.0)
		lg.print(string.format("%.13d", score), 30, 170)
		lg.setColor(255, 255, 0, 1.0)
		lg.print("Next Extend", 10, 190)
		lg.setColor(255, 255, 255, 1.0)
		if extendStep == 0 then lg.print(string.format("%.13d", 2500000), 30, 210) end
		if extendStep == 1 then lg.print(string.format("%.13d", 10000000), 30, 210) end
		if extendStep == 2 then lg.print(string.format("%.13d", 25000000), 30, 210) end
		if extendStep == 3 then lg.print(string.format("%.13d", 50000000), 30, 210) end
		if extendStep == 4 then lg.print(string.format("%.13d", 100000000), 30, 210) end
		if extendStep == 5 then lg.print(string.format("%.13d", 250000000), 30, 210) end
		lg.setColor(255, 255, 0, 1.0)
		lg.print("Gem Value", 10, 230)
		lg.setColor(255, 255, 255, 1.0)
		lg.draw(power_s, 30, 250)
		lg.print(string.format("%.0f", gemCollected), 50, 250)
		lg.print("x 10", 125, 250)
		lg.print(string.format("%.0f", (gemValue + (gemCollected * 10))), 60, 270)
		
		
		--bottom-left
		if bombs <= 4 then
			for i = 0, bombs - 1 do
				lg.draw(power_b, 10 + (36 * i), 510)
			end
		else
			lg.setColor(255, 255, 255, 1.0)
			lg.draw(power_b, 10, 510)
			lg.print("x", 50, 530)
			lg.print(bombs, 70, 530)
		end
		if lives <= 4 then
			for i = 0, lives - 1 do
				lg.draw(img_player, 10 + (36 * i), 550)
			end
		else
			lg.setColor(255, 255, 255, 1.0)
			lg.draw(img_player, 10, 550)
			lg.print("x", 50, 570)
			lg.print(lives, 70, 570)
		end
		
		--reset color
		lg.setColor(255, 255, 255, 1.0)
		
	end
	
	if gameOver then
		lg.setFont(myBigFont)
		lg.printf("Game Over", 300, 200, 400, "center")
		lg.setFont(myFont)
		lg.printf("Press T to return to title", 300, 300, 400, "center")
		lg.printf("Press Esc to exit", 300, 320, 400, "center")
	end
	
	if mainMenu then
		lg.printf("Astral Dragoon", 300, 100, 200, "center")
		lg.printf("v0.2a", 300, 120, 200, "center")
		
		lg.printf("Start Game", 180, 300, 200, "left")
		lg.printf("Exit", 180, 320, 200, "left")
		
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("HiScore", 360, 300, 200, "left")
		lg.setColor(255, 255, 255, 1.0)
		
		lg.print(string.format("%.13d", hiScoreArcade), 450, 300)
		--lg.print(string.format("%.13d", hiScoreEndless), 450, 320)
		--lg.print(string.format("%.13d", hiScoreExtra), 450, 340)
		
		lg.printf("Arrow keys to move", 250, 400, 300, "center")
		lg.printf("Z to shoot/confirm", 250, 420, 300, "center")
		lg.printf("X to bomb", 250, 440, 300, "center")
		lg.printf("Hold Shift to focus", 250, 460, 300, "center")
		lg.printf("Enter to pause", 250, 480, 300, "center")
		lg.printf("F toggle full screen", 250, 500, 300, "center")
		
		--main menu selection
		if mainMenuAni >= 0 and mainMenuAni < 2 then
			lg.draw(img_ebullet_1_1, 140, 300 + (20 * menuSelected))
		end
		if mainMenuAni >= 2 and mainMenuAni < 4 then
			lg.draw(img_ebullet_1_2, 140, 300 + (20 * menuSelected))
		end
		if mainMenuAni >= 4 and mainMenuAni < 6 then
			lg.draw(img_ebullet_1_3, 140, 300 + (20 * menuSelected))
		end
		if mainMenuAni >= 6 and mainMenuAni < 8 then
			lg.draw(img_ebullet_1_4, 140, 300 + (20 * menuSelected))
		end
	end
	
	if paused then
		lg.setFont(myBigFont)
		lg.printf("Paused", 400, 160, 200, "center")
		lg.setFont(myFont)
		lg.printf("Press T to return to title", 300, 200, 400, "center")
	end
	
	if readyNextStage then
		if gameMode == 1 and level == 6 then
			lg.setColor(255, 255, 255, 0.0)
		end
		lg.setFont(myBigFont)
		lg.printf("Stage", 400, 200, 250, "center")
		lg.printf(level + 1, 400, 240, 250, "center")
		lg.printf("Start", 400, 280, 250, "center")
		lg.setFont(myFont)
		if gameMode == 1 and level == 6 then
		else
			lg.printf(flavorText[currentFlavor], 400, 400, 250, "center")
		end
	end
	if readyNextStage and gameMode == 1 and level == 6 then
		lg.setFont(myBigFont)
		lg.printf("The End", 400, 240, 250, "center")
		lg.printf("Thanks for", 400, 280, 250, "center")
		lg.printf("playing!", 400, 320, 250, "center")
		lg.setFont(myFont)
		lg.setColor(255, 255, 255, 1.0)
	end
	
	if finishPhase then
		lg.setFont(myBigFont)
		lg.printf("Stage", 400, 200, 250, "center")
		lg.printf(level, 400, 240, 250, "center")
		lg.printf("Clear", 400, 280, 250, "center")
		lg.setFont(myFont)
	end
end

function drawBorders()
	--draw borders
	--lg.line(200, 0, 200, 800)
	--lg.line(800, 0, 800, 800)
	lg.setColor(0, 0, 0, 1.0)
	lg.rectangle("fill", 0, 0, 200, 600)
	lg.rectangle("fill", 800, 0, 200, 600) --right-side letterbox for fullscreen mode
	lg.setColor(255, 255, 255, 1.0)
end
