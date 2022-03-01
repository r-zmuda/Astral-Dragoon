function loadResource()
	--set current font
	myBigFont = lg.newFont("font/emulogic.ttf", 24)
	myFont = lg.newFont("font/emulogic.ttf", 12)
	lg.setFont(myFont)
	
	--set images
	img_exp = lg.newImage("gfx/exp.png")
	img_player = lg.newImage("gfx/player.png")
	img_player_hitbox = lg.newImage("gfx/player_hitbox.png")
	img_ebullet = lg.newImage("gfx/bullet/ebullet.png")
	img_ebullet_1_1 = lg.newImage("gfx/bullet/ebullet_1_1.png")
	img_ebullet_1_2 = lg.newImage("gfx/bullet/ebullet_1_2.png")
	img_ebullet_1_3 = lg.newImage("gfx/bullet/ebullet_1_3.png")
	img_ebullet_1_4 = lg.newImage("gfx/bullet/ebullet_1_4.png")
	img_ebullet_2_1 = lg.newImage("gfx/bullet/ebullet_2_1.png")
	img_ebullet_2_2 = lg.newImage("gfx/bullet/ebullet_2_2.png")
	img_ebullet_2_3 = lg.newImage("gfx/bullet/ebullet_2_3.png")
	img_ebullet_3_1 = lg.newImage("gfx/bullet/ebullet_3_1.png")
	img_ebullet_3_2 = lg.newImage("gfx/bullet/ebullet_3_2.png")
	img_ebullet_3_3 = lg.newImage("gfx/bullet/ebullet_3_3.png")
	img_ebullet_4_1 = lg.newImage("gfx/bullet/ebullet_4_1.png")
	img_ebullet_4_2 = lg.newImage("gfx/bullet/ebullet_4_2.png")
	img_ebullet_4_3 = lg.newImage("gfx/bullet/ebullet_4_3.png")
	img_ebullet_4_4 = lg.newImage("gfx/bullet/ebullet_4_4.png")
	img_ebullet_5_1 = lg.newImage("gfx/bullet/ebullet_5_1.png")
	img_ebullet_5_2 = lg.newImage("gfx/bullet/ebullet_5_2.png")
	img_ebullet_5_3 = lg.newImage("gfx/bullet/ebullet_5_3.png")
	
	--set backgrounds
	img_bg1 = lg.newImage("gfx/bg1.png")
	img_bg2 = lg.newImage("gfx/bg2.png")
	img_bg3 = lg.newImage("gfx/bg3.png")
	img_bg4 = lg.newImage("gfx/bg4.png")
	img_bg5 = lg.newImage("gfx/bg5.png")
	img_bg6 = lg.newImage("gfx/bg6.png")
	img_fade = lg.newImage("gfx/mask_black.png")
	
	--set sprites
	--player
	player_bullet1 = lg.newImage("gfx/bullet/star_1.png")
	player_bullet2 = lg.newImage("gfx/bullet/bullet1.png")
	--pickup
	power_s = lg.newImage("gfx/s_up.png")
	power_b = lg.newImage("gfx/b_up.png")
	--enemies
	enemy_kami_red = lg.newImage("gfx/enemy/kami_red.png")
	enemy_kami_blue = lg.newImage("gfx/enemy/kami_blue.png")
	enemy_kami_green = lg.newImage("gfx/enemy/kami_green.png")
	enemy_kami_purple = lg.newImage("gfx/enemy/kami_purple.png")
	enemy_yume_red = lg.newImage("gfx/enemy/yume_red.png")
	enemy_yume_blue = lg.newImage("gfx/enemy/yume_blue.png")
	enemy_yume_green = lg.newImage("gfx/enemy/yume_green.png")
	enemy_yume_purple = lg.newImage("gfx/enemy/yume_purple.png")
	enemy_nuke_red = lg.newImage("gfx/enemy/nuke_red.png")
	enemy_nuke_blue = lg.newImage("gfx/enemy/nuke_blue.png")
	enemy_nuke_green = lg.newImage("gfx/enemy/nuke_green.png")
	enemy_nuke_purple = lg.newImage("gfx/enemy/nuke_purple.png")
	--bosses
	enemy_boss_kami_red = lg.newImage("gfx/enemy/boss_kami_red.png")
	enemy_boss_kami_blue = lg.newImage("gfx/enemy/boss_kami_blue.png")
	enemy_boss_kami_green = lg.newImage("gfx/enemy/boss_kami_green.png")
	enemy_boss_kami_purple = lg.newImage("gfx/enemy/boss_kami_purple.png")
	enemy_boss_yume_red = lg.newImage("gfx/enemy/boss_yume_red.png")
	enemy_boss_yume_blue = lg.newImage("gfx/enemy/boss_yume_blue.png")
	enemy_boss_yume_green = lg.newImage("gfx/enemy/boss_yume_green.png")
	enemy_boss_yume_purple = lg.newImage("gfx/enemy/boss_yume_purple.png")
	enemy_boss_nuke_red = lg.newImage("gfx/enemy/boss_nuke_red.png")
	enemy_boss_nuke_blue = lg.newImage("gfx/enemy/boss_nuke_blue.png")
	enemy_boss_nuke_green = lg.newImage("gfx/enemy/boss_nuke_green.png")
	enemy_boss_nuke_purple = lg.newImage("gfx/enemy/boss_nuke_purple.png")
	enemy_boss_omega = lg.newImage("gfx/enemy/boss_omega.png")
	
	--set system audio
	se_fire = la.newSource("se/_hit.wav", "static")
	se_fire:setVolume(0.1)
	se_hit = la.newSource("se/_hit.wav", "static")
	se_hit:setVolume(0.1)
	se_get = la.newSource("se/_get.wav", "static")
	se_get:setVolume(0.1)
	se_pause = la.newSource("se/_select.wav", "static")
	se_pause:setVolume(0.2)
	se_death1 = la.newSource("se/_exp.wav", "static")
	se_death1:setVolume(0.05)
	se_death2 = la.newSource("se/_exp.wav", "static")
	se_death2:setVolume(0.05)
	se_death3 = la.newSource("se/_exp.wav", "static")
	se_death3:setVolume(0.05)
	se_pdeath = la.newSource("se/_death.wav", "static")
	se_pdeath:setVolume(0.2)
	se_ready = la.newSource("se/_goodluck.ogg", "static")
	se_ready:setVolume(0.7)
	se_start = la.newSource("se/_start.wav", "static")
	se_start:setVolume(0.2)
	se_extend = la.newSource("se/_extend.wav", "static")
	se_extend:setVolume(0.2)
	--boss death
	se_bossdeath = la.newSource("se/_boss_vanish.wav", "static")
	se_bossdeath:setVolume(0.5)
	--win stage sound
	se_clear = la.newSource("se/_bonus.ogg", "static")
	se_clear:setVolume(0.1)
	--ambience
	se_amb = la.newSource("se/_amb.wav", "stream")
	se_amb:setLooping(true)
	se_amb:setVolume(0.5)
	--title sound
	se_mus_title = la.newSource("se/_start.wav", "static")
	se_mus_title:setLooping(false)
	se_mus_title:setVolume(0.2)
	--stage bgm
	se_mus_stage = {
		la.newSource("bgm/sincx_stage2.ogg", "stream"),
		la.newSource("bgm/shinobi_whirl.ogg", "stream"),
		la.newSource("bgm/ut_sky.ogg", "stream"),
		la.newSource("bgm/ac_dead.ogg", "stream"),
		la.newSource("bgm/sor_super.ogg", "stream"),
		la.newSource("bgm/jp_seek.ogg", "stream")
	}
	se_mus_stage[1]:setLooping(true)
	se_mus_stage[1]:setVolume(0.1)
	se_mus_stage[2]:setLooping(true)
	se_mus_stage[2]:setVolume(0.1)
	se_mus_stage[3]:setLooping(true)
	se_mus_stage[3]:setVolume(0.1)
	se_mus_stage[4]:setLooping(true)
	se_mus_stage[4]:setVolume(0.1)
	se_mus_stage[5]:setLooping(true)
	se_mus_stage[5]:setVolume(0.1)
	se_mus_stage[6]:setLooping(true)
	se_mus_stage[6]:setVolume(0.1)
	--boss bgm
	se_mus_boss = {
		la.newSource("bgm/sincx_regular_boss.ogg", "stream"),
		la.newSource("bgm/raph_last_boss.ogg", "stream")
	}
	se_mus_boss[1]:setLooping(true)
	se_mus_boss[1]:setVolume(0.1)
	se_mus_boss[2]:setLooping(true)
	se_mus_boss[2]:setVolume(0.1)
	--credits bgm
	se_credits = la.newSource("bgm/ds_complete.ogg", "stream")
	se_credits:setLooping(true)
	se_credits:setVolume(0.05)
end