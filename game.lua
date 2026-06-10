function ginit()
    w = 128
	h = 128
    roundTime = 20
	game = {
		player_it = true,
		p_score = 0,
		c_score = 0,
        roundClock = roundTime,
        -- 1: home screen
        -- 2: between rounds
        -- 3: gameplay
        -- 4: endscreen
        state = 1
	}
    wallFlagId = 1
    winningScore = 3
    
end

function gupdate()
    if game.state == 1 then
        if btn(❎) then 
            game.state = 2
        elseif btn(🅾️) then
            game.state = 2
            cat.spriteNumber = 18
        end
    elseif game.state == 2 then
        check_tag()
        pupdate()
        cupdate()
        if game.p_score == winningScore or game.c_score == winningScore then
            game.state = 4
            ::continue::
        end
        if game.roundClock <= 0 then
            if game.player_it then
                game.c_score += 1
            else
                game.p_score += 1
            end
            pinit()
            cinit()
            game.roundClock = roundTime
            game.state = 3
            game.player_it = not game.player_it
        else
            game.roundClock -= 0.033
        end
    elseif game.state == 3 then
        if btn(❎) then 
            game.state = 2
        end
    elseif game.stete == 4 then
        draw_game_over()
    end

end

function check_tag()
	if abs(player.x - cat.x) < 8 and abs(player.y - cat.y) < 8 then
		if game.player_it then
			game.p_score += 1
		else
			game.c_score += 1
		end
		game.player_it = not game.player_it		
		pinit()
		cinit()
        game.roundClock= roundTime
        game.state = 3
	end
end

function draw_hud()
	spr(1, 8, 120)
	print(game.p_score, 16, 120)
	spr(2, 24, 120)
	print(game.c_score, 32, 120)
    spr(17, 112, 120)
    print(ceil(game.roundClock), 120, 120)
end

function draw_title_screen()
    map(16, 0)
    print("finn's manor", 40, 64)
    print("press ❎ to begin", 30, 72)
    spr(1, 50, 80)
    spr(2, 70, 80)
end

function draw_round_break()
    local supplementText
    if game.player_it then
        supplementText = " you're it"
    else
        supplementText = " finn's it!"
    end
    map(16, 0)
    print("new round!".. supplementText, 20, 64)
    print("press ❎ to begin", 30, 72)
    spr(1, 50, 80)
    spr(2, 70, 80)
end

function draw_game_over()
    local supplementText
    if game.p_score == winningScore then
        supplementText = "you win!"
    else
        supplementText = "finn wins!"
    end

    map(16, 0)
    print(supplementText, 50, 64)
    -- print("", 30, 72)
    spr(1, 50, 80)
    spr(2, 70, 80)

end