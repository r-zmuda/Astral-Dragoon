--require stuff
require "data/second"
require "data/hud"
require "data/enemy"
require "data/draw"
require "data/update"
require "data/res"
require "data/score"

--reduce visual clutter
la = love.audio
lg = love.graphics
lk = love.keyboard
lt = love.timer
lw = love.window
lf = love.filesystem

function love.load()

	--filter mode
	--love.graphics.setDefaultFilter("nearest", "nearest", 1)

	--stores window resolution
	win = {
		x = lg.getWidth(),
		y = lg.getHeight()
	}
	
	--tables
	t = {h = 0, m = 0, s = 0} --table for game time
	app = {h = 0, m = 0, s = 0} --table for app time
	bullets = {} --contains player bullet objects
	eBullets = {} --contains enemy bullet objects
	enemies = {} --contains enemy objects
	players = {} --contains player objects
	powerups = {} --contains power-up objects
	explosions = {} --contains explosion objects
	
	--variables
	debugMode = false --toggle debug mode, show lots of cool stats
	backgroundColor = 0 --stores background value
	playerX = 0 --store player X, since players are objects
	playerY = 0 --store player Y, since players are objects
	level = 0 --initial stage to start the game on
	levelEnd = -1 --when 0, level is running, when 1, level is over
	spawnRemaining = -1 --number of waves in level
	spawnTimer = 0 --handles wave spawns
	spawnStep = 0 --handles mid-wave spawns
	appTimer = 0 --used to time events
	menuTimer = 0 --used for main menu cursor
	debugTimer = 0 --used for debug toggle
	undebugTimer = 0 --used for undebug toggle
	pauseTimer = 0 --used for pause toggle
	unpauseTimer = 0 --used for unpause toggle
	creditsTimer = 0 --used for credits
	enemyCount = 0 --total number of enemy objects present
	bossTimer = 0 --timer for boss spawn
	lives = 3 --stores player lives stock
	deaths = 0 --stores player deaths
	bombs = 3 --stores player bombs stock
	bombsUsed = 0 --stores player bombs used
	kills = 0 --stores player kills
	score = 0 --stores player's score
	scoreUpdate = 0 --adds to score every update
	gemCollected = 0 --track gems collected (gemValue + (gemCollected * 10))
	gemValue = 0 --default gem value
	hiScoreArcade = 0 --stores high score
	hiScoreEndless = 0 --stores high score
	hiScoreExtra = 0 --stores high score
	grazeCount = 0 --stores total bullets grazed
	alphaFlash = 0.0 --stores screen flash mask alpha
	alphaFade = 0.0 --stores screen fade mask alpha
	bombCD = 0 --bomb cooldown
	deathCD = 0 --player respawn cooldown
	previousBoss = 0 --remember previous boss in endless
	currentBoss = 0 --stores current boss in endless
	player_xp = 0 --stores player's xp
	player_height = 0 --store the player sprite's height
	player_width = 0 --store the player sprite's width
	player_health = 0 --store the player's health
	player_health_max = 0 --store the player's max health
	player_shotType = 1 --player's selected shot type
	player_power = 0 --store the player's current power level
	player_i_frame = 0 --stores player's i frames
	extendStep = 0 --handle player extends
	mus_current_stage = 1 --stores current stage track
	mus_current_boss = 1 --stores current boss track
	finishFrame = 0 --timer for finish phase
	readyFrame = 0 --timer for ready phase
	menuSelected = 0 --selected option in menu
	gameMode = 0 --current game mode
	currentFlavor = 0 --stage text display
	mainMenuAni = 0 --animate menu
	mainMenu = true --bool for being in main menu
	optionMenu = false --bool for being in option menu
	tutorialMenu = false --bool for being in how to play menu
	creditsMenu = false --bool for showing credits (special: arcade end)
	creditsFade = false --fade for credits (special: arcade end)
	creditsRotation = 0 --rotation during credits
	paused = false --bool for pausing game
	readySound = false --bool for initial game boot up sfx
	preparing = false --bool for starting a stage
	
	--flavor text
	flavorText = {
	"",
	"",
	"",
	"",
	"",
	"",
	}
	
	--load functions
	loadResource()
	loadPlayer()
	loadHiScore()
	prepareExplosions()
	prepareBullets()
	prepareEnemy()
	prepareEShots()
	preparePowerups()
	
	--stores background 1 for looping, 600x1280 only
	bg = {
		x = 200,
		y = 0,
		speed = 1,
		image = img_bg1
	}
	
	--stores background 2 for looping, 600x1280 only
	bg2 = {
		x = 200,
		y = -1280,
		speed = 1,
		image = img_bg1
	}
	
end

function love.update(dt)
	
	--send value dt to fdt for functions outside of love.update
	fdt = dt
	
	--background rng
	math.random(0, appTimer)
	
	--application timer
	appTimer = appTimer + 1
	if appTimer == 60 then
		appTimer = 0
		--collectgarbage("step")
	end
	--update game timers
	app.s = app.s + fdt
	if app.s >= 60 then app.s = 0
		app.m = app.m + 1 end
	if app.m >= 60 then app.m = 0
		app.h = app.h + 1 end
	
	updateApp()
	
	if not mainMenu then
		if not paused then
			--update functons
			updateBackground()
			updateFlash()
			updateGame()
			updatePlayer()
			updateEnemies()
			updateBullets()
			updatePowerups()
			updateExplosions()
			updateHiScore()
			detectPowerup()
			detectBullet()
			detectCollision()
		end
	end
	
	if not readySound then
		la.play(se_mus_title)
		readySound = true
	end
	
end

--draw order affects layering (top draws are the bottom layer, and vice versa)
function love.draw()

	--resolution scaling
	local scaleY = lg.getHeight() / 600
	lg.push()
	lg.scale(scaleY)
	if fullscreenmode then
		lg.translate(100, 0)
	end

	--DRAW ORDER
	--top of list: drawn first (under everything)
	--bottom of list: drawn last (on top of everything)
	
	--in-game draw
	if not mainMenu then
		drawBackground()
		drawPBullets()
		drawPowerups()
		drawExplosions()
		drawEnemies()
		drawPlayer()
		drawEBullets()
		drawFlash()
		drawBorders()
	end
	
	--always draw
	if not creditsMenu then
		drawHUD()
		drawFade()
	end
	
	if creditsMenu then
		drawCredits()
	end
	
	--END DRAW ORDER
	lg.pop()
	
end

--quit the application
function love.keypressed(key)

	if key == "escape" then
		stopStageMus()
		stopBossMus()
		la.stop(se_amb)
		la.stop(se_credits)
		love.event.quit()
	end
	
end