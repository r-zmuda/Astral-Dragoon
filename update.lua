--include levels
require "data/arcade"

function updateGame()

	--update game timers
	t.s = t.s + fdt
	if t.s >= 60 then t.s = 0
		t.m = t.m + 1 end
	if t.m >= 60 then t.m = 0
		t.h = t.h + 1 end
	
	--spawn timer/controller
	if levelEnd == 0 and not gameOver then
		spawnTimer = spawnTimer + 1
	end
	
	--update score
	if scoreUpdate > 0 then
		scoreUpdate = scoreUpdate - 1
		score = score + 1
		if scoreUpdate > 10 then
			scoreUpdate = scoreUpdate - 10
			score = score + 10
			if scoreUpdate > 100 then
				scoreUpdate = scoreUpdate - 100
				score = score + 100
				if scoreUpdate > 1000 then
					scoreUpdate = scoreUpdate - 1000
					score = score + 1000
					if scoreUpdate > 10000 then
						scoreUpdate = scoreUpdate - 10000
						score = score + 10000
						if scoreUpdate > 100000 then
							scoreUpdate = scoreUpdate - 100000
							score = score + 100000
							if scoreUpdate > 1000000 then
								scoreUpdate = scoreUpdate - 1000000
								score = score + 1000000
							end
						end
					end
				end
			end
		end	
	end
	
	--arcade mode
	if gameMode == 1 then
		arcadeMode()
	end
	
	--set end level flag
	if spawnRemaining == 0 and bossTimer == 0 then
		levelEnd = 1
		stopStageMus()
		if level == 6 then
			playBossMus(2)
		else
			playBossMus(1)
		end
	end
	
	if levelEnd == 1 and bossTimer < 400 then
		bossTimer = bossTimer + 1
		if bossTimer == 400 then
			levelEnd = 2
		end
	end
	
	if levelEnd == 2 and bossTimer == 400 then
		--remove stray on-screen bullets/enemies to prepare boss
		for i, eBullet in ipairs(eBullets) do
			if eBullet.alpha > 0.0 then
				eBullet.health = 0
			end
		end
		if gameMode == 1 then
			if level == 1 then spawnEnemy(1001, 0) end
			if level == 2 then spawnEnemy(1002, 0) end
			if level == 3 then spawnEnemy(1003, 0) end
			if level == 4 then spawnEnemy(1004, 0) end
			if level == 5 then spawnEnemy(1005, 0) end
			if level == 6 then spawnEnemy(1006, 0) end
		end
		if gameMode == 2 then
			--ensure different boss
			while currentBoss == previousBoss do
				currentBoss = math.random(1001, 1003)
			end
			spawnEnemy(currentBoss, 0)
			previousBoss = currentBoss
			--spawnEnemy(math.random(1001,1010))
		end
		if gameMode == 3 then
			spawnEnemy(1007, 0)
		end
		levelEnd = 3
	end
	
	--start finish phase
	if finishPhase and not finishPhaseStart then
		drawBG = false
		finishFrame = 300
		finishPhaseStart = true
	end
	if finishPhase and finishPhaseStart then
		finishFrame = finishFrame - 1
		if finishFrame == 0 then
			finishPhase = false
			finishPhaseStart = false
			readyNextStage = true
			readyNextStageStart = false
		end
	end
	
	--start next ready phase
	if readyNextStage and not readyNextStageStart then
		readyFrame = 180
		currentFlavor = currentFlavor + 1
		--start credits if arcade end
		if gameMode == 1 and level == 6 then
			creditsFade = true
		else
			la.play(se_ready)
		end
		readyNextStageStart = true
	end
	if readyNextStage and creditsFade and not creditsMenu then
		readyNextStageStart = false
		--prepare to roll credits
		if creditsFade and alphaFade < 1.0 then
			alphaFade = alphaFade + 0.005
		end
		if creditsFade and alphaFade >= 1.0 then
			bullets = {}
			deathCD = 9999999
			for i, player in ipairs(players) do
				player.control = false
			end
			alphaFade = 1.0
			creditsFade = false
			creditsMenu = true
		end
	end
	if readyNextStage and readyNextStageStart then
		readyFrame = readyFrame - 1
		if readyFrame == 0 then
			readyNextStage = false
			readynextStageStart = false
			startNextStage = true
		end
	end
	
	--start next stage
	if startNextStage then
		if gameMode == 1 then
			if level == 0 then
				bg.image = img_bg1
				bg2.image = img_bg1
				playStageMus(1)
			end
			if level == 1 then
				bg.image = img_bg2
				bg2.image = img_bg2
				playStageMus(2)
			end
			if level == 2 then
				bg.image = img_bg3
				bg2.image = img_bg3
				playStageMus(3)
			end
			if level == 3 then
				bg.image = img_bg4
				bg2.image = img_bg4
				playStageMus(4)
			end
			if level == 4 then
				bg.image = img_bg5
				bg2.image = img_bg5
				playStageMus(5)
			end
			if level == 5 then
				bg.image = img_bg6
				bg2.image = img_bg6
				playStageMus(6)
			end
			--end arcade mode
			if level == 6 then
				if score > hiScoreArcade then
					hiScoreArcade = score
				end
				saveHiScore()
			end
		end
		if gameMode == 2 then
			backgroundColor = math.random(1, 6)
			shuffleStageMus()
		end
		if gameMode == 3 then
			backgroundColor = 7
			playStageMus(1)
		end
		drawBG = true
		bossTimer = 0
		levelEnd = 0
		level = level + 1
		spawnRemaining = 1
		spawnStep = 0
		spawnTimer = 0
		startNextStage = false
		--Special: terminate arcade mode, do credits
		if creditsMenu then
			stopStageMus()
			stopBossMus()
			la.stop(se_amb)
			la.play(se_credits)
			gameOver = false
			readyNextStage = false
			readyNextStageStart = false
			drawBG = false
			gameMode = 0
			spawnRemaining = -1
			readyFrame = 0
			level = 0
		end
	end
	
end

function updateApp()

	--main menu timers
	if mainMenu then
		mainMenuAni = mainMenuAni + 1
	end
	if mainMenuAni == 8 then
		mainMenuAni = 0
	end
	
	--fullscreen
	if lk.isDown('f') and not fullscreenmode and (mainMenu or paused) then
		lw.setMode(800, 600, {fullscreen=true})
		fullscreenmode = true
	end
	
	--windowed
	if lk.isDown('f') and fullscreenmode and (mainMenu or paused) then
		lw.setMode(800, 600, {fullscreen=false})
		fullscreenmode = false
	end
	
	--debug
	if lk.isDown('rshift') and undebugTimer == 0 and not mainMenu and not debugMode and not creditsMenu then
		la.play(se_pause:clone())
		debugMode = true
		debugTimer = 20
	end
	
	--undebug
	if lk.isDown('rshift') and debugTimer == 0 and not mainMenu and debugMode and not creditsMenu then
		la.play(se_pause:clone())
		debugMode = false
		undebugTimer = 20
	end
	
	if debugTimer > 0 then
		debugTimer = debugTimer - 1
	end
	if undebugTimer > 0 then
		undebugTimer = undebugTimer - 1
	end
	
	--return to title
	if lk.isDown('t') and (gameOver or paused) then
		la.stop(se_amb)
		stopStageMus()
		stopBossMus()
		gameOver = false
		readyNextStage = false
		readyNextStageStart = false
		drawBG = false
		gameMode = 0
		readyFrame = 0
		deaths = 0
		bombsUsed = 0
		kills = 0
		love.load()
	end
	
	--main menu selection
	if menuTimer > 0 and mainMenu then
		menuTimer = menuTimer - 1
	end
	if lk.isDown('down') and mainMenu and menuTimer == 0 then
		la.play(se_pause:clone())
		menuSelected = menuSelected + 1
		menuTimer = 10
	end
	if lk.isDown('up') and mainMenu and menuTimer == 0 then
		la.play(se_pause:clone())
		menuSelected = menuSelected - 1
		menuTimer = 10
	end
	
	--set main menu bounds
	if menuSelected == -1 then menuSelected = 1 end
	if menuSelected == 2 then menuSelected = 0 end
	
	--menu selections
	--chose arcade
	if lk.isDown('z') and mainMenu and menuSelected == 0 then
		mainMenu = false
		gameMode = 1
		la.stop(se_mus_title)
		la.play(se_start)
		readyNextStage = true
	end
	--chose how to play
	if lk.isDown('z') and mainMenu and menuSelected == 1 then
		love.event.quit()
	end
	
	--pause
	if unpauseTimer > 0 then
		unpauseTimer = unpauseTimer - 1
	end
	if lk.isDown('return') and not mainMenu and unpauseTimer == 0 then
		if not gameOver then
			if not readyNextStage then
				if not finishPhase then
					if not creditsMenu then
						if not paused then
							la.play(se_pause:clone())
							paused = true
							pauseTimer = 20
						end
					end
				end
			end
		end
	end
	
	--unpause
	if pauseTimer > 0 then
		pauseTimer = pauseTimer - 1
	end
	if lk.isDown('return') and not mainMenu and paused and pauseTimer == 0 then
		la.play(se_pause:clone())
		paused = false
		unpauseTimer = 20
	end
	
	--roll credits
	if creditsMenu then
		creditsTimer = creditsTimer + 1
		creditsRotation = creditsRotation + 0.1
	end
	
	--exit credits
	if lk.isDown('return') and creditsMenu then
		la.stop(se_credits)
		deaths = 0
		bombsUsed = 0
		kills = 0
		love.load()
	end
	
end

function updateFlash()
	if alphaFlash > 0.0 then
		alphaFlash = alphaFlash - 0.025
	end
end

function updatePlayer()
	
	--applies to every player object
	for i, player in ipairs(players) do
		
		--feed player variables into globals, show them in the hud
		--grants entities outside of player access to this information
		playerX = player.x + player.ox - 8
		playerY = player.y + player.oy - 8
		player_health = player.health
		player_health_max = player.health_max
		player_shotType = player.shotType
		player_power = player.power
		player_i_frame = player.i_frame
		player_width = player.image:getWidth()
		player_height = player.image:getHeight()
		
		--death CD
		if deathCD <= 0 then
			player.control = true
		end
	
		--player movement
		if lk.isDown('down') and player.control then
			player.y = player.y + fdt * player.speed
		end
		if lk.isDown('up') and player.control then
			player.y = player.y - fdt * player.speed
		end
		if lk.isDown('right') and player.control then
			player.x = player.x + fdt * player.speed
		end
		if lk.isDown('left') and player.control then
			player.x = player.x - fdt * player.speed
		end
		
		--fire normal shot
		if lk.isDown('z') and not lk.isDown('lshift') and player.control then
			if player.delay < 0 then
				firePlayerBullet()
				player.delay = 0.5
			end
		end
		
		--fire focus shot
		if lk.isDown('z') and lk.isDown('lshift') and player.control then
			if player.delay < 0 then
				firePlayerBullet()
				player.delay = 0.5
			end
		end
		
		--hold shift to 'focus': slower movement and better dps
		if lk.isDown('lshift') and player.control then
			player.speed = 100
			player.showHitbox = true
		end
		
		--reset movement speed to normal
		if not lk.isDown('lshift') then
			player.speed = 300
			player.showHitbox = false
		end
		
		--do bomb
		if not finishPhase then
			if not readyNextStage then
				if lk.isDown('x') and bombs > 0 and bombCD == 0 and player.i_frame <= 0 and player.control then
					bombs = bombs - 1
					player.i_frame = 180
					bombCD = 180
					alphaFlash = 0.5
					bombsUsed = bombsUsed + 1
					for i, eBullet in ipairs(eBullets) do
						if eBullet.alpha > 0.0 then
							powerup(eBullet.x, eBullet.y, 1)
							eBullet.health = 0
						end
					end
					for i, enemy in ipairs(enemies) do
						if enemy.alpha > 0.0 then
							enemy.health =  enemy.health - 100
						end
					end
					la.play(se_bossdeath:clone())
				end
			end
		end
	
		--set move bounds
		if player.y >= 600 - player_height and player.control then
			player.y = 600 - player_height
		end
		if player.y <= 0 and player.control then
			player.y = 0
		end
		if player.x >= 800 - player_width - 1 and player.control then
			player.x = 800 - player_width - 1
		end
		if player.x <= 201 and player.control then
			player.x = 201
		end
		
		--increment timers
		player.delay = player.delay - 0.1
		if bombCD > 0 then
			bombCD = bombCD - 1
		end
		if deathCD > 0 then
			deathCD = deathCD - 1
		end
		if player.i_frame > 0 then
			player.i_frame = player.i_frame - 1
		end
	
		--kill player
		if player.health <= 0 then
			player.health = 0
			deathCD = 60
			deaths = deaths + 1
			explode(player.x + player.ox, player.y + player.oy)
			la.play(se_pdeath:clone())
			for i, eBullet in ipairs(eBullets) do
				if eBullet.alpha > 0.0 then
					eBullet.health = 0
				end
			end
			for i, powerup in ipairs(powerups) do
				if powerup.alpha > 0.0 then
					powerup.health = 0
				end
			end
			if lives > 0 then --respawn player, else game over
				lives = lives - 1
				bombs = 3
				preparePlayer()
			else
				for i, enemy in ipairs(enemies) do
					if enemy.alpha > 0.0 then
						explode(enemy.x + enemy.ox, enemy.y + enemy.oy)
						enemy.alpha = -1.0
					end
				end
				gameOver = true
				--save high score
				if gameMode == 1 and score > hiScoreArcade then
					hiScoreArcade = score
				end
				if gameMode == 2 and score > hiScoreEndless then
					hiScoreEndless = score
				end
				if gameMode == 3 and score > hiScoreExtra then
					hiScoreExtra = score
				end
				la.play(se_amb)
				--stop all music
				spawnRemaining = -1 --for silent game over (se_boss_mus plays while spawnRemaining = 0)
				stopStageMus()
				stopBossMus()
			end
			table.remove(players, i)
		end
		
		--extend
		if score > 2500000 and extendStep == 0 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		if score > 10000000 and extendStep == 1 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		if score > 25000000 and extendStep == 2 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		if score > 50000000 and extendStep == 3 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		if score > 100000000 and extendStep == 4 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		if score > 250000000 and extendStep == 5 then
			lives = lives + 1
			extendStep = extendStep + 1
			la.play(se_extend:clone())
		end
		
	end
	
end

function updateBackground()

    --scrolling background
	bg.y = bg.y + bg.speed
	bg2.y = bg2.y + bg2.speed
	if bg.y > 1280 then bg.y = -1280 end
	if bg2.y > 1280 then bg2.y = -1280 end
	
	--slow scrolling background
	if gameOver then
		if bg.speed > 0.5 and bg2.speed > 0.5 then
			bg.speed = bg.speed - 0.05
			bg2.speed = bg2.speed - 0.05
		end
		if bg.speed <= 0.5 and bg2.speed <= 0.5 then
			bg.speed = 0.5
			bg2.speed = 0.5
		end
	end
	
end

function updateExplosions()
	for i, explosion in ipairs(explosions) do
		explosion.alpha = explosion.alpha - 0.05
		explosion.scale = explosion.scale + 0.2
		if explosion.alpha < 0.0 then
			explosions[i] = {
				x = 0,
				y = 0,
				alpha = 0.0,
				scale = 1.0,
				image = img_exp
			}
		end
	end
end

function updatePowerups()

	for i, powerup in ipairs(powerups) do
		
		--angle to player
		local angle = angleToPlayer(powerup.x, powerup.y)
		
		--powerup leaves bottom
		if (powerup.y >= win.y + powerup.image:getHeight()) then
			powerup.alpha = -1.0
		end
		
		--powerup spawns off sides
		if powerup.x < 200 and powerup.alpha > 0.0 then
			powerup.x = 210
		end
		if powerup.x > 800 - powerup.image:getWidth() then
			powerup.x = 790 - powerup.image:getWidth()
		end
		
		--timers
		if powerup.alpha > 0.0 then
			powerup.dx = math.cos(angle)
			powerup.dy = math.sin(angle)
			powerup.x = powerup.x + (fdt * powerup.dx * powerup.speed)
			powerup.y = powerup.y + (fdt * powerup.dy * powerup.speed)
			powerup.ani = powerup.ani + 1
			
		end
		
		--vacuum after a second
		if powerup.ani > 60 then
			powerup.speed = 1500
		end
		
		--destroy
		if powerup.health == 0 then
			explode(powerup.x + powerup.ox, powerup.y, powerup.oy)
			powerup.alpha = -1.0
		end
		
		--remove
		if powerup.alpha < 0.0 then
			powerup.x = 0
			powerup.y = 0
			powerup.dx = 0
			powerup.dy = 0
			powerup.id = 0
			powerup.ani = 0
			powerup.health = 1
			powerup.speed = 0
			powerup.alpha = 0.0
			powerup.image = power_s
		end
	end
	
end

function updateBullets()

	for i, bullet in ipairs(bullets) do
		if bullet.alpha > 0.0 then
			bullet.x = bullet.x + fdt * bullet.dx
			bullet.y = bullet.y + fdt * bullet.dy
			--bullet rotation
			if bullet.type == 1 then
				bullet.r = bullet.r + 10
			end
		end
		
		if bullet.alpha < 0.0 then
			bullet.x = 0
			bullet.y = 0
			bullet.dx = 0
			bullet.dy = 0
			bullet.r = 0
			bullet.type = 0
			bullet.damage = 0
			bullet.image = player_bullet1
			bullet.alpha = 0.0
		end
	end
	
	for i, eBullet in ipairs(eBullets) do
		
		--update ebullets
		if eBullet.alpha > 0.0 then
			eBullet.x = eBullet.x + fdt * eBullet.dx
			eBullet.y = eBullet.y + fdt * eBullet.dy
		end
		
		--advance bullet
		eBullet.frame = eBullet.frame + 1
		eBullet.ani = eBullet.ani + 1
		
		--reset frames
		if eBullet.id == 1 and eBullet.ani == 8 then
			eBullet.ani = 0
		end
		if eBullet.id == 2 and eBullet.ani == 8 then
			eBullet.ani = 0
		end
		if eBullet.id == 3 and eBullet.ani == 8 then
			eBullet.ani = 0
		end
		if eBullet.id == 4 and eBullet.ani == 8 then
			eBullet.ani = 0
		end
		if eBullet.id == 5 and eBullet.ani == 8 then
			eBullet.ani = 0
		end
		
		--animate bullets
		if eBullet.id == 1 then
			if eBullet.ani == 0 then
				eBullet.image = img_ebullet_1_1
			end
			if eBullet.ani == 2 then
				eBullet.image = img_ebullet_1_2
			end
			if eBullet.ani == 4 then
				eBullet.image = img_ebullet_1_3
			end
			if eBullet.ani == 6 then
				eBullet.image = img_ebullet_1_4
			end
		end
		if eBullet.id == 2 then
			if eBullet.ani == 0 then
				eBullet.image = img_ebullet_2_1
			end
			if eBullet.ani == 2 then
				eBullet.image = img_ebullet_2_2
			end
			if eBullet.ani == 4 then
				eBullet.image = img_ebullet_2_3
			end
			if eBullet.ani == 6 then
				eBullet.image = img_ebullet_2_2
			end
		end
		if eBullet.id == 3 then
			if eBullet.ani == 0 then
				eBullet.image = img_ebullet_3_1
			end
			if eBullet.ani == 2 then
				eBullet.image = img_ebullet_3_2
			end
			if eBullet.ani == 4 then
				eBullet.image = img_ebullet_3_3
			end
			if eBullet.ani == 6 then
				eBullet.image = img_ebullet_3_2
			end
		end
		if eBullet.id == 4 then
			if eBullet.ani == 0 then
				eBullet.image = img_ebullet_4_1
			end
			if eBullet.ani == 2 then
				eBullet.image = img_ebullet_4_2
			end
			if eBullet.ani == 4 then
				eBullet.image = img_ebullet_4_3
			end
			if eBullet.ani == 6 then
				eBullet.image = img_ebullet_4_4
			end
		end
		if eBullet.id == 5 then
			if eBullet.ani == 0 then
				eBullet.image = img_ebullet_5_1
			end
			if eBullet.ani == 2 then
				eBullet.image = img_ebullet_5_2
			end
			if eBullet.ani == 4 then
				eBullet.image = img_ebullet_5_3
			end
			if eBullet.ani == 6 then
				eBullet.image = img_ebullet_5_2
			end
		end
		
		--kill bullet
		if eBullet.health == 0 then
			explode(eBullet.x + eBullet.ox, eBullet.y + eBullet.oy)
			eBullet.alpha = -1.0
		end
		
		--fade in bullet
		if eBullet.alpha >= 0.1 and eBullet.alpha < 1.0 then
			eBullet.alpha = eBullet.alpha + 0.05
		end
		if eBullet.scale <= 3.0 and eBullet.scale > 1.0 then
			eBullet.scale = eBullet.scale - 0.5
		end
	
		--bullet math
		if eBullet.scale <= 1.0 then
			eBullet.x = eBullet.x + (math.cos(eBullet.angle) * eBullet.speed * fdt)
			eBullet.y = eBullet.y + (math.sin(eBullet.angle) * eBullet.speed * fdt)
		end
		
		--bullet logic
		if eBullet.fade then
			if eBullet.speed > 200 then
				eBullet.speed = eBullet.speed - 5
			end
		end
		
		if eBullet.behavior == 1 then
			if eBullet.frame < 60 then
				eBullet.angle = eBullet.angle + 0.05
			end
		end
		
		if eBullet.behavior == 2 then
			if eBullet.frame < 60 then
				eBullet.angle = eBullet.angle - 0.05
			end
		end
		
		if eBullet.behavior == 3 then
			eBullet.angle = eBullet.angle + 0.01
		end
		
		if eBullet.behavior == 4 then
			eBullet.angle = eBullet.angle - 0.01
		end
		
		--delete bullet
		if eBullet.alpha < 0.0 then
			eBullet.x = 0
			eBullet.y = 0
			eBullet.dx = 0
			eBullet.dy = 0
			eBullet.r = 0
			eBullet.speed = 0
			eBullet.angle = 0
			eBullet.damage = 0
			eBullet.alpha = 0.0
			eBullet.scale = 0.0
			eBullet.image = img_ebullet
			eBullet.ox = 0
			eBullet.oy = 0
			eBullet.behavior = 0
			eBullet.health = 1
			eBullet.frame = 0
		end
		
	end
	
end

function updateEnemies()
	
	--enemy logic
	for i, enemy in ipairs(enemies) do
	
		--calculate angles
		local enemyX = enemy.x + enemy.ox - 8
		local enemyY = enemy.y + enemy.oy - 8
		local angle = angleToPlayer(enemyX, enemyY)
	
		--timers/movement
		if enemy.delay == 0 then
			enemy.delay = enemy.delay_og
		end
		if enemy.alpha > 0.0 then
			enemy.x = enemy.x + (fdt * enemy.dx)
			enemy.y = enemy.y + (fdt * enemy.dy)
			enemy.delay = enemy.delay - 1
		end
		
		--wait until mid-boss is dead (with buffer)
		if enemy.id > 2000 and spawnTimer > 45 then
			spawnTimer = spawnTimer - 1
		end
		
		--enemy maintain facing toward player
		--adjust for radians
		if enemy.id == 3 then enemy.r = angle + 4.9 end
		
		--constant rotation
		enemy.r = enemy.r + (fdt * enemy.dr)
		
		--enemy movement logic
		if enemy.id == 3 and enemy.dy > 0 then
			enemy.dy = enemy.dy - 1
		end
		if enemy.id == 4 then
			enemy.dx = enemy.dx + 5
			enemy.dy = enemy.dy - 2
		end
		if enemy.id == 5 then
			enemy.dx = enemy.dx - 5
			enemy.dy = enemy.dy - 2
		end
		if enemy.id == 7 and enemy.y > playerY and enemy.behavior == 0 then
			if enemy.x < playerX then
				enemy.dy = 0
				enemy.dx = 400
				enemy.behavior = 1
			end
			if enemy.x > playerX then
				enemy.dy = 0
				enemy.dx = -400
				enemy.behavior = 1
			end
		end
		if enemy.id == 11 and enemy.y > 150 then
			if enemy.x < 450 and enemy.behavior == 0 then
				enemy.behavior = 1
				enemy.dx = 200
			end
			if enemy.x > 450 and enemy.behavior == 0 then
				enemy.behavior = 1
				enemy.dx = -200
			end
			if enemy.behavior == 1 then
				enemy.dy = enemy.dy - 10
			end
		end
		
		--boss movement logic
		if enemy.id == 1001 and enemy.y > 150 and enemy.delay > 1600 then
			enemy.dy = 0
		end
		if enemy.id == 1002 and enemy.y > 150 and enemy.delay > 1700 then
			enemy.dy = 0
			enemy.behavior = 1
		end
		if enemy.id == 1002 and enemy.behavior > 0 then
			if enemy.behavior == 1 then
				enemy.x = enemy.x - 3
			end
			if enemy.behavior == 2 then
				enemy.x = enemy.x + 3
			end
			if enemy.x < 200 then
				enemy.behavior = 2
				enemy.x = 200
			end
			if enemy.x > 704 then
				enemy.behavior = 1
				enemy.x = 704
			end
		end
		if enemy.id == 1003 and enemy.y >= 0 and enemy.behavior == 0 then
			enemy.dy = 0
			enemy.behavior = 1
		end
		if enemy.id == 1003 and enemy.x <= 200 and enemy.behavior == 1 then
			enemy.x = 200
			enemy.dy = 200
			enemy.dx = 0
			enemy.behavior = 2
		end
		if enemy.id == 1003 and enemy.y >= 504 and enemy.behavior == 2 then
			enemy.y = 504
			enemy.dx = 200
			enemy.dy = 0
			enemy.behavior = 3
		end
		if enemy.id == 1003 and enemy.x >= 704 and enemy.behavior == 3 then
			enemy.x = 704
			enemy.dy = -200
			enemy.dx = 0
			enemy.behavior = 4
		end
		if enemy.id == 1003 and enemy.y <= 0 and enemy.behavior == 4 then
			enemy.y = 0
			enemy.dy = 0
			enemy.dx = -200
			enemy.behavior = 1
		end
		if enemy.id == 1004 and enemy.y > 150 and enemy.delay > 1600 then
			enemy.dy = 0
		end
		if enemy.id == 1005 and enemy.y >= 0 and enemy.behavior == 0 then
			enemy.dy = 0
			enemy.behavior = 1
		end
		if enemy.id == 1005 and enemy.x <= 200 and enemy.behavior == 1 then
			enemy.x = 200
			enemy.dy = 200
			enemy.dx = 0
			enemy.behavior = 2
		end
		if enemy.id == 1005 and enemy.y >= 504 and enemy.behavior == 2 then
			enemy.y = 504
			enemy.dx = 200
			enemy.dy = 0
			enemy.behavior = 3
		end
		if enemy.id == 1005 and enemy.x >= 704 and enemy.behavior == 3 then
			enemy.x = 704
			enemy.dy = -200
			enemy.dx = 0
			enemy.behavior = 4
		end
		if enemy.id == 1005 and enemy.y <= 0 and enemy.behavior == 4 then
			enemy.y = 0
			enemy.dy = 0
			enemy.dx = -200
			enemy.behavior = 1
		end
		if enemy.id == 1006 and enemy.y > 50 and enemy.delay > 1600 then
			enemy.dy = 0
		end
		if enemy.id == 2001 and enemy.y > 150 and enemy.delay > 1600 then
			enemy.dy = 0
		end
		
		--shot pattern based on enemy id
		if enemy.y < 200 then --don't shoot while near bottom
			if enemy.shot == 1 then
				if enemy.delay == 0 then
					eShot(enemyX, enemyY, angle, 500, 10, 1, true)
				end
			end
			if enemy.shot == 2 then
				if enemy.delay % 10 == 0 then
					eShot(enemyX, enemyY, angle, 450, 10, 1, true)
					eShot(enemyX, enemyY, angle+0.5, 450, 10, 1, true)
					eShot(enemyX, enemyY, angle-0.5, 450, 10, 1, true)
				end
			end
			if enemy.shot == 3 then
				if enemy.delay == 0 then
					for i = 0, 10 do
						eShot(enemyX, enemyY, angle, 300, 10, 1, true)
						angle = angle + 0.57
					end
				end
			end
			if enemy.shot == 4 and enemy.behavior == 0 then
				if enemy.delay == 0 then
					eShot(enemyX, enemyY, angle, 300, 10, 1, true)
					eShot(enemyX, enemyY, angle, 350, 10, 1, true)
					eShot(enemyX, enemyY, angle, 400, 10, 1, true)
				end
			end
			if enemy.shot == 5 then
				if enemy.delay == 0 then
					eShot(enemyX, enemyY, 1.6, 500, 10, 1, true)
				end
			end
		end
		
		--boss shot pattern based on id
		--they are allowed to shoot near bottom
		if enemy.shot == 1001 then
		
			--random spray
			if enemy.delay > 0 and enemy.delay < 1600 and enemy.delay % 4 == 0 then
				for i = 0, 5 do
					eShot(enemyX, enemyY, math.random(0, 360), math.random(200, 400), 10, 1, true)
				end
			end
			
			if enemy.delay == 0 then
				enemy.delay = 1700
			end
			
		end
		
		if enemy.shot == 1002 then
		
			--bullet circle 1 (a circle is just over 6 radians)
			if enemy.delay > 800 and enemy.delay < 1600 and enemy.delay % 20 == 0 then
				for i = 0, 15 do
					eShot(enemyX, enemyY, angle, 200, 10, 1, true, 1)
					angle = angle + 0.4
				end
			end
			
			--bullet circle 2
			if enemy.delay > 0 and enemy.delay < 800 and enemy.delay % 20 == 0 then
				for i = 0, 15 do
					eShot(enemyX, enemyY, angle, 200, 10, 1, true, 2)
					angle = angle + 0.4
				end
			end
			
			--aimed circle
			if enemy.delay > 100 and enemy.delay < 1500 and enemy.delay % 30 == 0 then
				for i = 0, 15 do
					eShot(enemyX, enemyY, angle, 300, 10, 1, true)
					angle = angle + 0.4
				end
			end
			
		end
		
		if enemy.shot == 1004 then
			
			--circles of rotating bullets
			if enemy.delay > 100 and enemy.delay < 1500 and enemy.delay % 30 == 0 then
				for i = 0, 15 do
					eShot(enemyX, enemyY, angle, 200, 10, 1, true, 3)
					angle = angle + 0.4
				end
				for i = 0, 15 do
					eShot(enemyX, enemyY, angle, 200, 10, 1, true, 4)
					angle = angle + 0.4
				end
			end
			
		end
		
		if enemy.shot == 1005 then
			
			--shower of bullets
			if enemy.delay > 100 and enemy.delay < 1500 and enemy.delay % 4 == 0 then
				eShot(enemyX, enemyY, math.random(4.0, 5.4), 100, 10, 1, true, 5)
			end
			
		end
		
		if enemy.shot == 1006 then
		
			--bullet rain
			if enemy.delay > 0 and enemy.delay < 1600 and enemy.delay % 4 == 0 then
				eShot(320 + math.random(0, 380), 100 + math.random(-50, 50), 1.6, 300 + math.random(0, 100), 10, 1, true)
			end
			
			--spawner
			if enemy.delay > 0 and enemy.delay < 1600 and enemy.delay % 30 == 0 then
				spawnEnemy(6, 0, 1)
				spawnEnemy(6, 0, 16)
			end
			
			if enemy.delay == 0 then
				enemy.delay = 1600
			end
			
		end
		
		--kill enemy object (requires differentiation)
		if enemy.health > -500 and enemy.health <= 0 then --buffer for player dps
			enemy.alpha = -1.0
			enemyCount = enemyCount - 1
			kills = kills + 1
			if enemy.id > 0 and enemy.id < 1000 then
				se_death()
				explode(enemyX, enemyY)
				powerup(enemyX, enemyY, 1)
			end
			if enemy.id == -1 then
				se_death()
				explode(enemyX, enemyY)
				powerup(enemyX, enemyY, 2)
			end
			if enemy.id == -2 then
				se_death()
				explode(enemyX, enemyY)
				powerup(enemyX, enemyY, 3)
			end
			--boss death (all dead)
			if enemy.id > 1000 and enemy.id < 2000 then
				alphaFlash = 0.5
				la.play(se_bossdeath:clone())
				explode(enemyX, enemyY)
				--kill all on-screen ebullets and enemies
				for i, enemy in ipairs(enemies) do
					if enemy.alpha > 0.0 then
						enemy.health = 0
					end
				end
				for i, eBullet in ipairs(eBullets) do
					if eBullet.alpha > 0.0 then
						powerup(eBullet.x, eBullet.y, 1)
						eBullet.health = 0
					end
				end
				--drop items
				for i = 0, 20 do
					powerup(enemyX + math.random(-30, 30), enemyY + math.random(-30, 30), 1)
				end
				--stop music
				la.play(se_clear:clone())
				stopBossMus()
				--finish boss phase
				finishPhase = true
			end
			
			--mid-boss death
			if enemy.id > 2000 then
				alphaFlash = 0.5
				la.play(se_bossdeath:clone())
				explode(enemyX, enemyY)
				--kill all on-screen ebullets and enemies
				for i, enemy in ipairs(enemies) do
					if enemy.alpha > 0.0 then
						enemy.health = 0
					end
				end
				for i, eBullet in ipairs(eBullets) do
					if eBullet.alpha > 0.0 then
						powerup(eBullet.x, eBullet.y, 1)
						eBullet.health = 0
					end
				end
				--drop items
				for i = 0, 20 do
					powerup(enemyX + math.random(-30, 30), enemyY + math.random(-30, 30), 1)
				end
			end
			
			--death bullets by enemy shot id (don't spawn bullets during screen flash)
			if enemy.shot == 0 and alphaFlash <= 0.0 then
				for i = 0, 20 do -- i = 0, 62 and angle = angle + 0.1 creates a circle
					eShot(enemyX, enemyY, angle, 400, 10, 1, true)
					angle = angle + 0.3
				end
			end
			
			--add points
			scoreUpdate = scoreUpdate + enemy.score
			
		end
		
		if enemy.health <= -500 then --remove enemies quietly and scorelessly
			enemy.alpha = -1.0
			enemyCount = enemyCount - 1
		end
		
		--remove enemy
		if enemy.alpha < 0.0 then
			enemy.id = 0
			enemy.x = 0
			enemy.y = 200
			enemy.dx = 0
			enemy.dy = 0
			enemy.r = 0
			enemy.dr = 0
			enemy.delay = 0
			enemy.delay_og = 0
			enemy.health = 9999
			enemy.health_max = 9999
			enemy.score = 0
			enemy.shot = 0
			enemy.image = enemy_kami_red
			enemy.alpha = 0.0
			enemy.behavior = 0
		end
		
	end
end