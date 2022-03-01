--initialize enemy class object
--id = x,
--npos = range(0, 17)
--x = 0, --x coord + (npos * 32), left bounds = 100~200, right bounds = 832~900
--y = 0, --y coord + (npos * 32), top bounds = -100~0, bottom bounds = 600~800
--dx = 0, --delta x, positive is right, negative is left
--dy = 0, --delta y, positive is down, negative is up
--sx = 1, --scale x
--sy = 1, --scale y
--ox = 0, --offset x, half of image width
--oy = 0, --offset y, half of image width
--r = 0, --rotation of image
--dr = 0, --change in rotation, makes the image spin
--delay = -100, --shot is fired when delay is 0 then resets to delay_og
--delay_og = -100, --the initial delay, negative delays do not fire
--health = 9999, --non-negative zero or else it will die (see updateEnemies function for logic)
--health_max = 9999, --used for health bar
--score = 0, --point value of enemy
--shot = 0, --shot pattern of enemy
--image = 0, --initialize image variable
--alpha = 1.0, --image translucency, used for "despawning" when alpha <= 0.0
--behavior = nbehavior --set behavior

function spawnEnemy(x, nbehavior, npos)

	local spawnThis = false
	
	for i, enemy in ipairs(enemies) do
		if not spawnThis and enemy.alpha == 0.0 then
			spawnThis = true
			--feed enemy data
			enemy.id = x
			enemy.behavior = nbehavior
			
			--bomb carrier
			if enemy.id == -2 then
				enemy.x = 205 + (npos * 32)
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.health = 10
				enemy.health_max = 10
				enemy.score = 100
				enemy.image = enemy_nuke_green
				enemy.shot = -1
			end
			
			--spawn enemy based on id
			--this is where all parameters are set for enemies
			--enemy id #0 will not function, stick to positive definitions
			if enemy.id == 1 then --base constructor
				enemy.x = 205 + (npos * 32) --spawn at this x, don't go below 100 or above 900 or it will be despawned
				enemy.y = -100 --spawn at this y, don't go below -200 or above 800 or it will be despawned
				enemy.dx = math.random(-75, 75)
				enemy.dy = 200 + math.random(-50, 50) --delta y, y speed
				enemy.dr = 10 --delta rotation, enemy rotate speed
				enemy.health = 3 --sets health of enemy
				enemy.health_max = 3 --sets max health of enemy
				enemy.delay_og = -100 --sets initial delay
				enemy.score = 10 * gemCollected --point value for enemy
				enemy.image = enemy_yume_red --sprite id
				enemy.r = math.random(0, 360) --start with a random rotation
				enemy.shot = 0 --assigns shot id 0 (nothing) to enemy id 1 (passive)
			end
			
			if enemy.id == 4 then --blue yume right
				enemy.x = 150
				enemy.y = 32 * npos
				enemy.dx = 250
				enemy.dy = 100
				enemy.dr = 10
				enemy.health = 5
				enemy.health_max = 5
				enemy.delay_og = 300
				enemy.score = 10 * gemCollected
				enemy.image = enemy_yume_blue
				enemy.shot = 2
			end
			
			if enemy.id == 5 then --blue yume left
				enemy.x = 832
				enemy.y = 32 * npos
				enemy.dx = -250
				enemy.dy = 100
				enemy.dr = 10
				enemy.health = 5
				enemy.health_max = 5
				enemy.delay_og = 300
				enemy.score = 10 * gemCollected
				enemy.image = enemy_yume_blue
				enemy.shot = 2
			end
			
			if enemy.id == 6 then --green kami
				enemy.x = 205 + (npos * 32)
				enemy.y = -100
				enemy.dy = 150
				enemy.dr = 10
				enemy.health = 10
				enemy.health_max = 10
				enemy.delay_og = 100
				enemy.score = 10 * gemCollected
				enemy.image = enemy_kami_green
				enemy.shot = 3
			end
			
			if enemy.id == 7 then --purple kami
				enemy.x = 205 + (npos * 32)
				enemy.y = -100
				enemy.dy = 150
				enemy.dr = 10
				enemy.health = 15
				enemy.health_max = 15
				enemy.delay_og = 60
				enemy.score = 10 * gemCollected
				enemy.image = enemy_kami_purple
				enemy.shot = 4
			end
			
			if enemy.id == 11 then --red kami
				enemy.x = 205 + (npos * 32)
				enemy.y = -100
				enemy.dy = 400
				enemy.dr = 10
				enemy.health = 3
				enemy.health_max = 3
				enemy.delay_og = math.random(30, 60)
				enemy.score = 10 * gemCollected
				enemy.image = enemy_kami_red
				enemy.shot = 1
			end
			
			if enemy.id == 12 then --blue kami
				enemy.x = 205 + (npos * 32)
				enemy.dr = 10
				enemy.health = 3
				enemy.health_max = 3
				enemy.delay_og = math.random(30, 60)
				enemy.score = 10 * gemCollected
				enemy.image = enemy_kami_blue
				enemy.shot = 1
				if enemy.behavior == 1 then
					enemy.y = -100
					enemy.dy = 500
				end
				if enemy.behavior == 2 then
					enemy.y = 700
					enemy.dy = -500
				end
			end
			
			if enemy.id == 13 then --purple nuke
				enemy.y = 10 + (npos * 32)
				enemy.dr = 10
				enemy.health = 3
				enemy.health_max = 3
				enemy.delay_og = math.random(30, 60)
				enemy.score = 10 * gemCollected
				enemy.image = enemy_nuke_purple
				enemy.shot = 5
				if enemy.behavior == 1 then
					enemy.x = 168
					enemy.dx = 300
				end
				if enemy.behavior == 2 then
					enemy.x = 832
					enemy.dx = -300
				end
			end
			
			--bosses type (id > 1000)
			if enemy.id > 1000 then
			end
			
			if enemy.id == 1001 then
				enemy.name = " Ruby Ninja"
				enemy.x = 460
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_kami_red
				enemy.shot = 1001
				enemy.health = 600
				enemy.health_max = 600
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
				
			if enemy.id == 1002 then
				enemy.name = " Crimson Diamond"
				enemy.x = 460
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_yume_red
				enemy.shot = 1002
				enemy.health = 600
				enemy.health_max = 600
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			if enemy.id == 1003 then
				enemy.name = " Sapphire Ninja"
				enemy.x = 200
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_kami_blue
				enemy.shot = 1002
				enemy.health = 600
				enemy.health_max = 600
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			if enemy.id == 1004 then
				enemy.name = " Amethyst Diamond"
				enemy.x = 460
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_yume_purple
				enemy.shot = 1004
				enemy.health = 600
				enemy.health_max = 600
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			if enemy.id == 1005 then
				enemy.name = " Azure Nucleus"
				enemy.x = 200
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_nuke_blue
				enemy.shot = 1004
				enemy.health = 600
				enemy.health_max = 600
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			if enemy.id == 1006 then
				enemy.name = " Project Omega"
				enemy.x = 300
				enemy.y = -100
				enemy.dy = 200
				enemy.image = enemy_boss_omega
				enemy.shot = 1006
				enemy.health = 2500
				enemy.health_max = 2500
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			--mid-boss
			if enemy.id == 2001 then
				enemy.name = " Violet Nucleus"
				enemy.x = 460
				enemy.y = -100
				enemy.dy = 200
				enemy.dr = 10
				enemy.image = enemy_boss_nuke_purple
				enemy.shot = 1001
				enemy.health = 300
				enemy.health_max = 300
				enemy.delay_og = 1800
				enemy.score = 10 * gemCollected
			end
			
			enemy.ox = enemy.image:getWidth() / 2 --off-set to center of sprite
			enemy.oy = enemy.image:getHeight() / 2 --off-set to center of sprite
			enemy.delay = enemy.delay_og --delay gets reset to delay_og when 0
			enemy.alpha = 1.0 --make visible
		end
	end

	--counter
	enemyCount = enemyCount + 1
	
end
