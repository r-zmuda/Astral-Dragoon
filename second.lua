function shuffleStageMus()
	local s = math.random(1, 2)
	la.play(se_mus_stage[s])
	mus_current_stage = s
end

function playStageMus(s)
	la.play(se_mus_stage[s])
	mus_current_stage = s
end

function stopStageMus()
	la.stop(se_mus_stage[mus_current_stage])
end

function shuffleBossMus()
	local s = 1
	if s == 1 then la.play(se_mus_boss01) end
	mus_current_boss = s
end

function playBossMus(s)
	la.play(se_mus_boss[s])
	mus_current_boss = s
end

function stopBossMus()
	la.stop(se_mus_boss[mus_current_boss])
end

function loadPlayer()

	newPlayer = {
		x = 480,
		y = 520,
		ox = img_player:getWidth()/2,
		oy = img_player:getHeight()/2,
		speed = 300,
		delay = 0,
		health = 1,
		health_max = 1,
		power = 1,
		shotType = 1,
		image = img_player,
		hitbox = img_player_hitbox,
		showHitbox = false,
		control = true,
		i_frame = 0
	}
	
	table.insert(players,newPlayer)
	
end

function preparePlayer()

	newPlayer = {
		x = 480,
		y = 520,
		ox = img_player:getWidth()/2,
		oy = img_player:getHeight()/2,
		speed = 300,
		delay = 0,
		health = 1,
		health_max = 1,
		power = 1,
		shotType = 1,
		image = img_player,
		hitbox = img_player_hitbox,
		showHitbox = false,
		control = false,
		i_frame = 240
	}
	
	table.insert(players,newPlayer)
	
end

--slot enemy shots to memory
function prepareEShots()
	for i = 1, 300 do --max enemy shots
		newEBullet = {
		id = 0,
		x = 0,
		y = 0,
		r = 0,
		dx = 0,
		dy = 0,
		speed = 0,
		angle = 0,
		damage = 0,
		alpha = 0.0,
		scale = 1.0,
		image = img_ebullet,
		ox = 0,
		oy = 0,
		behavior = 0,
		health = 1,
		frame = 0,
		ani = 0,
		grazed = false
		}
		table.insert(eBullets, newEBullet)
	end
end

--do enemy shot
	--syntax eShot(int, int, int, int, int, image, bool, int)
	--example eShot(enemyX, enemyY, angle, 200, 10, img_ebullet, true, 1)
function eShot(nx, ny, nangle, nspeed, ndamage, nid, nfade, nbehavior)
	local shootThis = false
	for i, eBullet in ipairs(eBullets) do
		if not shootThis and eBullet.alpha == 0.0 then
			shootThis = true
			eBullet.id = nid
			eBullet.x = nx
			eBullet.y = ny
			eBullet.r = angle
			eBullet.speed = nspeed
			eBullet.angle = nangle
			eBullet.damage = ndamage
			eBullet.alpha = 0.1
			eBullet.scale = 3.0
			eBullet.fade = nfade
			eBullet.behavior = nbehavior
			eBullet.health = 1
			eBullet.frame = 0
			eBullet.ani = 0
			--set bullet sprite
			if eBullet.id == 1 then eBullet.image = img_ebullet_1_1 end
			if eBullet.id == 2 then eBullet.image = img_ebullet_2_1 end
			if eBullet.id == 3 then eBullet.image = img_ebullet_3_1 end
			eBullet.ox = eBullet.image:getWidth()/2
			eBullet.oy = eBullet.image:getHeight()/2
		end
	end
	
end

--slot explosions to memory
function prepareExplosions()
	for i = 1, 300 do --max explosions
		newExplosion = {
		x = 0,
		y = 0,
		alpha = 0.0,
		scale = 1.0,
		image = img_exp
		}
		table.insert(explosions, newExplosion)
	end
end

--do explosion
function explode(nx, ny)
	local explodeThis = false
	for i, explosion in ipairs(explosions) do
		if not explodeThis and explosion.alpha <= 0.0 then
			explodeThis = true
			explosion.x = nx
			explosion.y = ny
			explosion.alpha = 1.0
			explosion.scale = 1.0
		end
	end
end

--slot powerup
function preparePowerups()
	for i = 1, 300 do --max powerups
		newPowerup = {
			id = 0,
			x = 0,
			y = 0,
			dx = 0,
			dy = 0,
			ox = 0,
			oy = 0,
			alpha = 0.0,
			health = 1,
			speed = 0,
			ani = 0,
			image = power_s
		}
		
		table.insert(powerups, newPowerup)
	end
end

--make powerup
function powerup(nx, ny, ni)
	local makeThis = false
	for i, powerup in ipairs(powerups) do
		if not makeThis and powerup.alpha == 0.0 then
			makeThis = true
			powerup.x = nx
			powerup.y = ny
			powerup.dy = -60
			powerup.id = ni
			powerup.ani = 0
			powerup.health = 1
			powerup.alpha = 0.5
			
			--powerup sprite by id
			if powerup.id == 1 then
				powerup.image = power_s
			end
			if powerup.id == 3 then
				powerup.image = power_b
			end
			
			powerup.ox = powerup.image:getWidth() / 2
			powerup.oy = powerup.image:getHeight() / 2
		end
	end
end

--slot enemies
function prepareEnemy()
	for i = 1, 100 do --max enemy
		newEnemy = {
			id = 0,
			x = 0,
			y = 200,
			dx = 0,
			dy = 0,
			ox = 0,
			oy = 0,
			sx = 1,
			sy = 1,
			r = 0,
			dr = 0,
			delay = 0,
			delay_og = 0,
			health = 9999,
			health_max = 9999,
			score = 0,
			shot = 0,
			image = enemy_kami_red,
			alpha = 0.0,
			behavior = 0
		}
		
		table.insert(enemies, newEnemy)
	end
end

function prepareBullets()
	for i = 1, 100 do
		--create a bullet
		newBullet = {
			x = 0,
			y = 0,
			r = 0,
			dx = 0,
			dy = 0,
			ox = 0,
			oy = 0,
			damage = 0,
			image = player_bullet1,
			alpha = 0.0
		}
		
		--table insert new bullet
		table.insert(bullets, newBullet)
	end
end

function firePlayerBullet()

	for i, player in ipairs(players) do
	
		--player shot types
		if player.shotType == 1 then
			playerBullet(player.x + 8, player.y, -100)
			playerBullet(player.x + 24, player.y, 100)
			playerBullet(player.x + 8, player.y, -200)
			playerBullet(player.x + 24, player.y, 200)
			playerBullet(player.x + 8, player.y, -300)
			playerBullet(player.x + 24, player.y, 300)
		end
		if player.shotType == 2 then
			playerBullet(player.x + 4, player.y + 8, 0)
			playerBullet(player.x + 16, player.y, 0)
			playerBullet(player.x + 28, player.y + 8, 0)
		end
		
		la.play(se_fire:clone())
		
	end
	
end

function playerBullet(nx, ny, ndx)

	local shootThis = false
	for i, bullet in ipairs(bullets) do
		if not shootThis and bullet.alpha == 0.0 then
			shootThis = true
			bullet.x = nx
			bullet.y = ny
			bullet.dx = ndx
			bullet.alpha = 0.5
			--adjust bullet speed based on normal/focus mode
			if lk.isDown('z') then
				bullet.dy = -1000
			else
				bullet.dy = -1000
			end
			--bullet image and damage
			for i, player in ipairs(players) do
				if player.shotType == 1 then
					bullet.type = 1
					bullet.image = player_bullet1
					bullet.damage = 1
				end
				if player.shotType == 2 then
					bullet.type = 2
					bullet.image = player_bullet2
					bullet.damage = 2
				end
			end
			--image offset
			bullet.ox = bullet.image:getWidth() / 2
			bullet.oy = bullet.image:getHeight() / 2
		end
	end
	
end

function detectPowerup()
	for i, powerup in ipairs(powerups) do
		for j, player in ipairs(players) do
			collision = checkCollision(player.x, player.y, player.image:getWidth(), player.image:getHeight(), powerup.x, powerup.y, powerup.image:getWidth(), powerup.image:getHeight())
			if collision then
				la.play(se_get:clone())
				powerup.alpha = -1.0
				if powerup.id == 1 then
					scoreUpdate = scoreUpdate + (gemValue + (gemCollected * 10))
					gemCollected = gemCollected + 1
				end
				if powerup.id == 2 then
					player.power = player.power + 1
				end
				if powerup.id == 3 then
					bombs = bombs + 1
				end
				if powerup.id == 5 then
					lives = lives + 1
				end
			end
		end
	end
end

function detectBullet()
	--player bullet to enemy
	for i, enemy in ipairs(enemies) do
		for j, bullet in ipairs(bullets) do
			collision = checkCollision(enemy.x, enemy.y, enemy.image:getWidth(), enemy.image:getHeight(), bullet.x, bullet.y, bullet.image:getWidth(), bullet.image:getHeight())
			if collision then
				--explode(bullet.x, bullet.y)
				bullet.alpha = -1.0
				enemy.health = enemy.health - bullet.damage
				scoreUpdate = scoreUpdate + (1 * level)
				se_hit:setVolume(0.2)
				la.play(se_hit:clone())
			end
		end
	end
	
	--enemy bullet to player
	for i, player in ipairs(players) do
		for j, eBullet in ipairs(eBullets) do
			--because of axis-aligned bounding box collision, be generous
			graze = checkCollision(eBullet.x, eBullet.y, eBullet.image:getWidth(), eBullet.image:getHeight(), player.x - 16, player.y, player_width + 32, player_height)
			--collision = checkCollision(eBullet.x + eBullet.ox, eBullet.y + eBullet.oy, eBullet.image:getWidth() - eBullet.ox, eBullet.image:getHeight() - eBullet.oy, player.x + --player.ox - 2, player.y + player.oy - 2, player_width - player.ox + 2, player_height - player.oy + 2)
			collision = checkCollision(eBullet.x + eBullet.ox, eBullet.y + eBullet.oy, eBullet.image:getWidth() - eBullet.ox, eBullet.image:getHeight() - eBullet.oy, player.x + player.ox - 2, player.y + player.oy - 2, player.hitbox:getWidth(), player.hitbox:getHeight())
			--graze once per bullet, not while player has iframes
			if eBullet.grazed == false and graze and player_i_frame == 0 then
				eBullet.grazed = true
				grazeCount = grazeCount + 1
				--la.play(se_hit:clone())
			end
			if collision then
				explode(eBullet.x, eBullet.y)
				eBullet.alpha = -1.0
				if player.i_frame < 1 then
					player.health = player.health - eBullet.damage
				end
			end
		end
	end	
end

function detectCollision()
	--enemy to player
	for i, enemy in ipairs(enemies) do
		for j, player in ipairs(players) do
			collision = checkCollision(enemy.x, enemy.y, enemy.image:getWidth(), enemy.image:getHeight(), player.x, player.y, player_width, player_height)
			if collision then
				if enemy.id < 1000 then
					explode(enemy.x + enemy.ox, enemy.y + enemy.oy)
					enemyCount = enemyCount - 1
					enemy.alpha = -1.0
					se_death()
				end
				if enemy.id > 1000 then
					enemy.health = enemy.health - 0.01
				end
				if player.i_frame < 1 then
					player.health = player.health - 50
				end
			end
		end
	end
end

function se_death()
	local s = math.random(1, 3)
	--local s = 1
	if s == 1 then
		se_death1:setPitch(math.random(85, 115) / 100)
		la.play(se_death1:clone())
	end
	if s == 2 then
		se_death2:setPitch(math.random(85, 115) / 100)
		la.play(se_death2:clone())
	end
	if s == 3 then
		se_death3:setPitch(math.random(85, 115) / 100)
		la.play(se_death3:clone())
	end
end

--get angle to player
function angleToPlayer(x, y)
	local a = math.atan2((y - playerY), (x - playerX))
	return a + math.pi
end

--axis-aligned bounding box collision detection
function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end