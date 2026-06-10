function _init()
	ginit()
	pinit()
	cinit()
end

function _update()
    gupdate()
	-- pupdate()
	-- cupdate()
end

function _draw()
    cls()
    if game.state == 1 then
        draw_title_screen()
    elseif game.state == 2 then
        mapdraw(0,0,0,0,16,16)
        draw_hud()
        spr(1, player.x, player.y, 1, 1, player.facingLeft, false)
        spr(cat.spriteNumber, cat.x, cat.y, 1, 1, cat.facingLeft, false)
    elseif game.state == 3 then
        draw_round_break()
    elseif game.state == 4 then
        draw_game_over()
    end

end