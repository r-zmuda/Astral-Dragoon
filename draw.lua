function drawBackground()
	--draw background
	if drawBG then
		lg.draw(bg.image, bg.x, bg.y)
		lg.draw(bg2.image, bg2.x, bg2.y)
	end

	--reset color
	lg.setColor(255, 255, 255, 1.0)
end

function drawPBullets()
	--draws all player bullets, despawns them too
	for i, bullet in ipairs(bullets) do
		lg.setColor(255, 255, 255, bullet.alpha)
		lg.draw(bullet.image, bullet.x, bullet.y, bullet.r, 1, 1, bullet.ox, bullet.oy)
		lg.setColor(255, 255, 255, 1.0)
		--goes off-screen top
		if (bullet.y <= -40) then
			--destroy off-screen bullet object
			bullet.alpha = -1.0
		end
	end
end

function drawPowerups()
	--draws all power-ups
	for i, powerup in ipairs(powerups) do
		lg.setColor(255, 255, 255, powerup.alpha)
		lg.draw(powerup.image, powerup.x, powerup.y)
		lg.setColor(255, 255, 255, 1.0)
	end
end

function drawExplosions()
	--draw all explosions
	for i, explosion in ipairs(explosions) do
		lg.setColor(255, 255, 255, explosion.alpha)
		lg.draw(explosion.image, explosion.x, explosion.y, 0, explosion.scale, explosion.scale, explosion.image:getWidth()/2, explosion.image:getHeight()/2)
		lg.setColor(255, 255, 255, 1.0)
	end
end

function drawEnemies()
	--draws all enemies, despawn them too
	for i, enemy in ipairs(enemies) do
		lg.setColor(255, 255, 255, enemy.alpha)
		lg.draw(enemy.image, enemy.x + enemy.ox, enemy.y + enemy.oy, enemy.r, enemy.sx, enemy.sy, enemy.ox, enemy.oy)
		lg.setColor(255, 255, 255, 1.0)
		
		--show enemy health
		if enemy.alpha > 0.0 and enemy.id < 1000 and enemy.health >= 0 then
			lg.setColor(0, 255, 0, 1.0)
			lg.rectangle("fill", enemy.x, enemy.y - 10, enemy.image:getWidth() * (enemy.health / enemy.health_max), 2)
			lg.setColor(255, 255, 255, 1.0)
		end
		
		--show boss health
		if enemy.alpha > 0.0 and enemy.id > 1000 and enemy.health >= 0 then
			lg.setColor(0, 255, 0, 1.0)
			lg.rectangle("fill", 200, 5, 600 * (enemy.health / enemy.health_max), 4)
			lg.setColor(255, 255, 255, 1.0)
			lg.print(enemy.name, 200, 10)
			lg.setColor(255, 255, 255, 1.0)
		end
		
		--debug: show stats
		if enemy.alpha > 0.0 and debugMode == true then
			lg.print(enemy.delay, enemy.x, enemy.y - 10)
		end
		
		--goes off-screen bottom
		--goes off left (adjust for dimensions of image)
		if enemy.x < 100 and enemy.alpha > 0.0 then
			enemy.health = -500
		end
		--goes off right (adjust for dimensions of image)
		if enemy.x > 900 and enemy.alpha > 0.0 then
			enemy.health = -500
		end
		--goes off bottom (adjust for dimensions of image)
		if enemy.y > 800 and enemy.alpha > 0.0 then
			enemy.health = -500
		end
		--goes off top (adjust for dimensions of image)
		if enemy.y < -200 and enemy.alpha > 0.0 then
			enemy.health = -500
		end
	end
end

function drawPlayer()
	
	--draws player
	for i, player in ipairs(players) do
		
		if player.i_frame > 0 then
			lg.setColor(255, 255, 255, 0.5)
		else
			lg.setColor(255, 255, 255, 1.0)
		end
		
		if deathCD > 0 then
			lg.setColor(255, 255, 255, 0.0)
		end
		
		lg.draw(player.image, player.x, player.y)
		lg.setColor(255, 255, 255, 1.0)
		
		--show player health/shields
		--if player.health >= 0 then
			--lg.setColor(255, 0, 0, 1.0)
			--lg.rectangle("fill", player.x, player.y + 37, player.image:getWidth(), 2)
			--lg.setColor(0, 255, 255, 1.0)
			--lg.rectangle("fill", player.x, player.y + 37, player.image:getWidth() * (player.health / player.health_max), 2)
			--lg.setColor(255, 255, 255, 1.0)
		--end
		
		--draw hitbox
		if player.showHitbox then
			lg.draw(player.hitbox, player.x + 12, player.y + 12)
		end
		
		--debug: show graze zone
		--if debugMode == true then
			--lg.setColor(255, 255, 255, 0.5)
			--lg.rectangle("fill", player.x - 16, player.y - 16, player_width + 32, player_height + 32)
			--lg.setColor(255, 255, 255, 1.0)
		--end
		
	end
end

function drawEBullets()
	--draws all ebullets, despawns them too
	for i, eBullet in ipairs(eBullets) do
		lg.setColor(255, 255, 255, eBullet.alpha)
		lg.draw(eBullet.image, eBullet.x, eBullet.y, eBullet.r, eBullet.scale, eBullet.scale)
		lg.setColor(255, 255, 255, 1.0)
		--goes off left (adjust for dimensions of image)
		if eBullet.alpha > 0.0 and eBullet.x < 200 - eBullet.image:getWidth() then
			eBullet.alpha = -1.0
		end
		--goes off right (adjust for dimensions of image)
		if eBullet.alpha > 0.0 and eBullet.x > 800 + eBullet.image:getWidth() then
			eBullet.alpha = -1.0
		end
		--goes off bottom (adjust for dimensions of image)
		if eBullet.alpha > 0.0 and eBullet.y > 600 + eBullet.image:getHeight() then
			eBullet.alpha = -1.0
		end
		--goes off top (adjust for dimensions of image)
		if eBullet.alpha > 0.0 and eBullet.y < -100 - eBullet.image:getHeight() then
			eBullet.alpha = -1.0
		end
	end
end

function drawFlash()
	lg.setColor(255, 255, 255, alphaFlash)
	--rectangle("fill", x, y, w, h)
	lg.rectangle("fill", 200, 0, 600, 600)
	lg.setColor(255, 255, 255, 1.0)
end

function drawFade()
	lg.setColor(255, 255, 255, alphaFade)
	lg.draw(img_fade, 0, 0)
	lg.setColor(255, 255, 255, 1.0)
end

function drawCredits()
	local width = 32
	lg.setColor(255, 255, 255, 1.0)
	
	for i = 0, 100 do
		lg.draw(enemy_kami_red, -400 + (width * i), 16, creditsRotation, 1.0, 1.0, 16, 16)
		lg.draw(enemy_kami_red, 2000 - (width * i), 584, creditsRotation, 1.0, 1.0, 16, 16)
	end
	
	if creditsTimer > 180 and creditsTimer < 480 then
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("Congratulations!", 280, 200, 300, "center")
		lg.printf("Your mission is complete", 280, 220, 300, "center")
		
		lg.setColor(255, 255, 255, 1.0)
		lg.draw(img_player, 420, 300)
		lg.printf("Game data saved", 280, 540, 300, "center")
	end
	
	if creditsTimer > 540 then
		lg.setColor(255, 255, 255, 1.0)
		lg.printf("Press Enter to Return to Title", 230, 520, 400, "center")
		lg.printf("Press Esc to Exit Program", 230, 540, 400, "center")
	end
	
	if creditsTimer > 540 and creditsTimer < 840 then
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("Credits", 280, 100, 300, "center")
		lg.setColor(255, 255, 255, 1.0)
		lg.printf("Astral Dragoon v0.2", 280, 120, 300, "center")
		
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("Programming, Graphics", 280, 240, 300, "center")
		lg.setColor(255, 255, 255, 1.0)
		lg.printf("Ryan Zmuda", 280, 260, 300, "center")
		
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("Engine", 280, 360, 300, "center")
		lg.setColor(255, 255, 255, 1.0)
		lg.printf("Love 11.1", 280, 380, 300, "center")
	end
	
	if creditsTimer > 900 and creditsTimer < 99999999 then
		lg.setColor(255, 255, 0, 1.0)
		lg.printf("THE END", 280, 100, 300, "center")
		lg.printf("Statistics", 280, 140, 300, "center")
		lg.printf("Score: ", 280, 200, 300, "left")
		lg.printf("Gems: ", 280, 220, 300, "left")
		lg.printf("Lives: ", 280, 240, 300, "left")
		lg.printf("Deaths: ", 280, 260, 300, "left")
		lg.printf("Bombs: ", 280, 280, 300, "left")
		lg.printf("Bombs Used: ", 280, 300, 300, "left")
		lg.printf("Kills: ", 280, 320, 300, "left")
		lg.setColor(255, 255, 255, 1.0)
		lg.printf(score, 280, 200, 300, "right")
		lg.printf(gemCollected, 280, 220, 300, "right")
		lg.printf(lives, 280, 240, 300, "right")
		lg.printf(deaths, 280, 260, 300, "right")
		lg.printf(bombs, 280, 280, 300, "right")
		lg.printf(bombsUsed, 280, 300, 300, "right")
		lg.printf(kills, 280, 320, 300, "right")
	end
	
	lg.setColor(255, 255, 255, 1.0)
end