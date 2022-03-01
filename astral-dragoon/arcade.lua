function arcadeMode()
	--increase step, reset timer
	if spawnRemaining > 0 and spawnTimer > 60 then
		spawnStep = spawnStep + 1
		spawnTimer = 0
	end
	--finish wave
	if spawnRemaining > 0 and spawnStep > 60 then
		spawnRemaining = spawnRemaining + 1
		spawnStep = 0
	end
	
	--stage 1
	if level == 1 then
	
		--start bg
		if spawnRemaining == 1 and spawnStep > 0 and spawnStep < 10 then
			if bg.speed < 4 and bg2.speed < 4 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 3, 11, 1, 0)
		spawnGroup(1, 4, 6, 11, 16, 0)
		spawnGroup(1, 7, 9, 11, 1, 0)
		spawnGroup(1, 10, 12, 11, 16, 0)
		spawnGroup(1, 13, 15, 11, 1, 0)
		spawnGroup(1, 13, 15, 11, 16, 0)
		spawnGroup(1, 16, 18, 11, 7, 0)
		spawnGroup(1, 16, 18, 11, 10, 0)
		spawnGroup(1, 19, 20, 11, 1, 0)
		spawnGroup(1, 19, 20, 11, 7, 0)
		spawnGroup(1, 19, 20, 11, 10, 0)
		spawnGroup(1, 19, 20, 11, 16, 0)
		
		spawnRest(1, 20)
		
		spawnGroup(1, 22, 23, 12, 0, 1)
		spawnGroup(1, 22, 23, 12, 17, 1)
		spawnGroup(1, 24, 25, 12, 0, 1)
		spawnGroup(1, 24, 25, 12, 17, 1)
		spawnGroup(1, 26, 27, 12, 0, 1)
		spawnGroup(1, 26, 27, 12, 17, 1)
		spawnGroup(1, 28, 29, 12, 0, 1)
		spawnGroup(1, 28, 29, 12, 17, 1)
		spawnGroup(1, 30, 31, 12, 0, 1)
		spawnGroup(1, 30, 31, 12, 17, 1)
		spawnGroup(1, 32, 33, 12, 0, 1)
		spawnGroup(1, 32, 33, 12, 17, 1)
		spawnGroup(1, 34, 35, 12, 0, 1)
		spawnGroup(1, 34, 35, 12, 17, 1)
		spawnGroup(1, 36, 37, 12, 0, 1)
		spawnGroup(1, 36, 37, 12, 17, 1)
		
		if spawnRemaining == 1 and spawnStep >= 22 and spawnStep < 38 then
			if spawnTimer == 60 then
				spawnEnemy(6, 0, 3)
				spawnEnemy(6, 0, 14)
			end
		end
		
		spawnGroup(1, 40, 42, 11, 1, 0)
		spawnGroup(1, 40, 42, 11, 16, 0)
		spawnGroup(1, 43, 45, 11, 3, 0)
		spawnGroup(1, 43, 45, 11, 14, 0)
		spawnGroup(1, 46, 48, 11, 5, 0)
		spawnGroup(1, 46, 48, 11, 12, 0)
		spawnGroup(1, 49, 51, 11, 7, 0)
		spawnGroup(1, 49, 51, 11, 10, 0)
		
		spawnGroup(1, 53, 57, 12, 1, 1)
		spawnGroup(1, 53, 57, 12, 4, 1)
		spawnGroup(1, 53, 57, 12, 13, 1)
		spawnGroup(1, 53, 57, 12, 16, 1)
		spawnGroup(1, 57, 59, 12, 2, 1)
		spawnGroup(1, 57, 59, 12, 5, 1)
		spawnGroup(1, 57, 59, 12, 12, 1)
		spawnGroup(1, 57, 59, 12, 15, 1)
		
		--speed up
		if spawnRemaining == 1 and spawnStep > 50 and spawnStep < 60 then
			if bg.speed < 8 and bg2.speed < 8 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		--boss 1
		if spawnRemaining == 1 and spawnStep == 60 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
	end
	
	--mission 2
	if level == 2 then
		
		--start bg
		if spawnRemaining == 1 and spawnStep > 0 and spawnStep < 10 then
			if bg.speed < 4 and bg2.speed < 4 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 10, 12, 2, 1)
		spawnGroup(1, 1, 10, 12, 4, 1)
		spawnGroup(1, 1, 10, 12, 13, 1)
		spawnGroup(1, 1, 10, 12, 15, 1)
		
		if spawnRemaining == 1 and spawnStep >= 10 and spawnStep < 20 then
			if spawnTimer == 60 then
				local rand = math.random(1, 3)
				spawnEnemy(6, 0, 3 + rand)
				spawnEnemy(6, 0, 14 - rand)
				spawnEnemy(6, 0, 1)
				spawnEnemy(6, 0, 16)
			end
		end
		
		spawnGroup(1, 21, 31, 12, 1, 1)
		spawnGroup(1, 21, 31, 12, 16, 1)
		
		if spawnRemaining == 1 and spawnStep >= 21 and spawnStep < 31 then
			if spawnTimer == 60 then
				local rand = math.random(1, 3)
				spawnEnemy(7, 0, 3 + rand)
				spawnEnemy(7, 0, 14 - rand)
			end
		end
		
		spawnRest(1, 32)
		
		spawnGroup(1, 33, 35, 11, 1, 0)
		spawnGroup(1, 33, 35, 11, 16, 0)
		spawnGroup(1, 36, 37, 11, 3, 0)
		spawnGroup(1, 36, 37, 11, 14, 0)
		spawnGroup(1, 38, 40, 11, 5, 0)
		spawnGroup(1, 38, 40, 11, 12, 0)
		spawnGroup(1, 41, 43, 11, 7, 0)
		spawnGroup(1, 41, 43, 11, 10, 0)
		
		--boss 2
		if spawnRemaining == 1 and spawnStep == 43 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
	end
	
	--stage 3
	if level == 3 then
	
		--start bg
		if spawnRemaining == 1 and spawnStep > 0 and spawnStep < 10 then
			if bg.speed < 6 and bg2.speed < 6 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 3, 4, 1, 0)
		spawnGroup(1, 5, 7, 5, 1, 0)
		spawnGroup(1, 9, 11, 4, 1, 0)
		spawnGroup(1, 13, 15, 5, 1, 0)
		
		if spawnRemaining == 1 and spawnStep >= 16 and spawnStep < 29 then
			if spawnTimer == 60 then
				local rand = math.random(1, 3)
				spawnEnemy(6, 0, 3 + rand)
				spawnEnemy(6, 0, 14 - rand)
				spawnEnemy(6, 0, 1)
				spawnEnemy(6, 0, 16)
			end
		end
		
		spawnRest(1, 30)
		
		spawnGroup(1, 31, 33, 4, 1, 0)
		spawnGroup(1, 35, 37, 5, 1, 0)
		spawnGroup(1, 39, 41, 4, 1, 0)
		spawnGroup(1, 43, 45, 5, 1, 0)
		
		--boss 3
		if spawnRemaining == 1 and spawnStep == 45 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
		
	end
	
	--stage 4
	if level == 4 then
	
		--start bg scroll
		if spawnRemaining == 1 then
			if bg.speed < 5 and bg2.speed < 5 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 3, 11, 1, 0)
		spawnGroup(1, 1, 3, 11, 3, 0)
		spawnGroup(1, 1, 3, 11, 14, 0)
		spawnGroup(1, 1, 3, 11, 16, 0)
		
		spawnGroup(1, 4, 6, 11, 3, 0)
		spawnGroup(1, 4, 6, 11, 5, 0)
		spawnGroup(1, 4, 6, 11, 12, 0)
		spawnGroup(1, 4, 6, 11, 14, 0)
		
		spawnGroup(1, 8, 10, 11, 5, 0)
		spawnGroup(1, 8, 10, 11, 7, 0)
		spawnGroup(1, 8, 10, 11, 10, 0)
		spawnGroup(1, 8, 10, 11, 12, 0)
		
		spawnGroup(1, 11, 25, 13, 1, 1)
		spawnGroup(1, 11, 25, 13, 3, 2)
		spawnGroup(1, 16, 25, 13, 5, 1)
		spawnGroup(1, 16, 25, 13, 7, 2)
		
		spawnGroup(1, 26, 28, 4, 1, 0)
		spawnGroup(1, 30, 32, 5, 1, 0)
		spawnGroup(1, 34, 36, 4, 1, 0)
		spawnGroup(1, 38, 40, 5, 1, 0)
		spawnGroup(1, 42, 44, 4, 1, 0)
		spawnGroup(1, 46, 48, 5, 1, 0)
		spawnGroup(1, 50, 52, 4, 1, 0)
		spawnGroup(1, 54, 56, 5, 1, 0)
		
		spawnRest(1, 56)
		
		--boss 4
		if spawnRemaining == 1 and spawnStep == 56 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
		
	end
	
	--stage 5
	if level == 5 then
	
		--start bg scroll
		if spawnRemaining == 1 then
			if bg.speed < 5 and bg2.speed < 5 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 4, 11, 1, 0)
		spawnGroup(1, 1, 4, 11, 3, 0)
		spawnGroup(1, 1, 4, 11, 14, 0)
		spawnGroup(1, 1, 4, 11, 16, 0)
		
		spawnGroup(1, 6, 9, 11, 3, 0)
		spawnGroup(1, 6, 9, 11, 5, 0)
		spawnGroup(1, 6, 9, 11, 12, 0)
		spawnGroup(1, 6, 9, 11, 14, 0)
		
		spawnGroup(1, 10, 55, 13, 1, 1)
		spawnGroup(1, 15, 55, 13, 3, 2)
		spawnGroup(1, 20, 55, 13, 5, 1)
		spawnGroup(1, 25, 55, 13, 7, 2)
		spawnGroup(1, 30, 55, 13, 9, 1)
		spawnGroup(1, 35, 55, 13, 11, 2)
		
		spawnRest(1, 56)
		
		spawnGroup(1, 57, 60, 12, 3, 1)
		spawnGroup(1, 57, 60, 12, 5, 1)
		spawnGroup(1, 57, 60, 12, 12, 1)
		spawnGroup(1, 57, 60, 12, 14, 1)
		
		spawnGroup(2, 1, 5, 4, 1, 0)
		spawnGroup(2, 7, 11, 5, 1, 0)
		spawnGroup(2, 13, 17, 4, 1, 0)
		spawnGroup(2, 21, 25, 5, 1, 0)
		spawnGroup(2, 27, 31, 4, 1, 0)
		spawnGroup(2, 33, 37, 5, 1, 0)
		
		--boss 5
		if spawnRemaining == 2 and spawnStep == 37 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
		
	end
	
	--stage 6
	if level == 6 then
	
		--start bg scroll
		if spawnRemaining == 1 then
			if bg.speed < 5 and bg2.speed < 5 then
				bg.speed = bg.speed + 0.01
				bg2.speed = bg2.speed + 0.01
			end
		end
		
		spawnGroup(1, 1, 3, 11, 1, 0)
		spawnGroup(1, 1, 3, 11, 3, 0)
		spawnGroup(1, 1, 3, 11, 14, 0)
		spawnGroup(1, 1, 3, 11, 16, 0)
		
		spawnGroup(1, 4, 6, 11, 3, 0)
		spawnGroup(1, 4, 6, 11, 5, 0)
		spawnGroup(1, 4, 6, 11, 12, 0)
		spawnGroup(1, 4, 6, 11, 14, 0)
		
		spawnGroup(1, 8, 10, 11, 5, 0)
		spawnGroup(1, 8, 10, 11, 7, 0)
		spawnGroup(1, 8, 10, 11, 10, 0)
		spawnGroup(1, 8, 10, 11, 12, 0)
		
		spawnRest(1, 12)
		
		--mid-boss
		if spawnRemaining == 1 and spawnStep == 11 then
			if spawnTimer == 30 then
				spawnEnemy(2001)
			end
		end
		
		spawnGroup(1, 14, 24, 12, 1, 1)
		spawnGroup(1, 14, 24, 12, 16, 1)
		
		if spawnRemaining == 1 and spawnStep >= 12 and spawnStep < 24 then
			if spawnTimer == 60 then
				local rand = math.random(1, 3)
				spawnEnemy(7, 0, 3 + rand)
				spawnEnemy(7, 0, 14 - rand)
			end
		end
		
		spawnGroup(1, 25, 30, 12, 1, 1)
		spawnGroup(1, 25, 30, 12, 3, 1)
		spawnGroup(1, 25, 30, 12, 14, 1)
		spawnGroup(1, 25, 30, 12, 16, 1)
		
		spawnGroup(1, 31, 36, 12, 3, 1)
		spawnGroup(1, 31, 36, 12, 5, 1)
		spawnGroup(1, 31, 36, 12, 12, 1)
		spawnGroup(1, 31, 36, 12, 14, 1)
		
		spawnGroup(1, 37, 47, 12, 1, 1)
		spawnGroup(1, 37, 47, 12, 3, 1)
		spawnGroup(1, 37, 47, 12, 5, 1)
		spawnGroup(1, 37, 47, 12, 12, 1)
		spawnGroup(1, 37, 47, 12, 14, 1)
		spawnGroup(1, 37, 47, 12, 16, 1)
		
		spawnGroup(1, 48, 58, 12, 1, 1)
		spawnGroup(1, 48, 58, 12, 16, 1)
		
		if spawnRemaning == 1 and spawnStep >= 48 and spawnStep < 58 then
			if spawnTimer == 60 then
				local rand = math.random(1, 3)
				spawnEnemy(7, 0, 3 + rand)
				spawnEnemy(7, 0, 14 - rand)
			end
		end
		
		spawnRest(1, 59)
		
		spawnGroup(2, 1, 9, 4, 1, 0)
		spawnGroup(2, 11, 19, 5, 1, 0)
		spawnGroup(2, 21, 29, 4, 1, 0)
		spawnGroup(2, 31, 39, 5, 1, 0)
		spawnGroup(2, 41, 49, 4, 1, 0)
		spawnGroup(2, 51, 59, 5, 1, 0)
		
		--boss 6
		if spawnRemaining == 2 and spawnStep == 60 then
			spawnRemaining = 0
		end
		
		--slow down
		if spawnRemaining == 0 then
			if bg.speed > 2 and bg2.speed > 2 then
				bg.speed = bg.speed - 0.01
				bg2.speed = bg2.speed - 0.01
			end
		end
		
	end
	
end

function spawnGroup(remain, stepStart, stepEnd, enemyID, pos, behavior)
	if spawnRemaining == remain and spawnStep >= stepStart and spawnStep < stepEnd then
		if spawnTimer == 10 or spawnTimer == 20 or spawnTimer == 30 or spawnTimer == 40 or spawnTimer == 50 or spawnTimer == 60 then
			spawnEnemy(enemyID, behavior, pos)
		end
	end
end

function spawnRest(remain, step)
	if spawnRemaining == remain and spawnStep == step then
		if spawnTimer == 60 then
			spawnEnemy(-2, 0, 8.5)
		end
	end
end