function cinit()
	cat = {
		x=64,
		y=64,
		speed=1,
		cm=true,
		cw=true,
        catMoveClock = 5,
        facingLeft = false,
        spriteNumber = 2
        
	}
end

function cchase()
    if cat.catMoveClock > 0 then
        cat.catMoveClock -= .5
    else
        cat.catMoveClock = 5
        local astar = a_star()

        if astar == nil then
            astar = {flr(player.x/8), flr(player.y/8)}
        end

        --Move x 
        if astar[1] * 8 > cat.x then
            -- cat.x += cat.speed
            cat.x += 8
            cat.facingLeft = false
        elseif astar[1] * 8 < cat.x then
            -- cat.x -= cat.speed
            cat.x -= 8
            cat.facingLeft = true
        end
        --Move y
        if astar[2] * 8 > cat.y then
            -- cat.y += cat.speed
            cat.y += 8
        elseif astar[2] * 8 < cat.y then
            -- cat.y -= cat.speed
            cat.y -= 8
        end
    end
	
end

function crun()
    if cat.catMoveClock > 0 then
        cat.catMoveClock -= .5
    else
        cat.catMoveClock = 5
        local initcatx = cat.x
        local initcaty = cat.y
        local catgridx = flr((cat.x + 1) / 8)
        local catgridy = flr((cat.y + 1) / 8)
        local options = {
            --up
            {catgridx, catgridy - 1},
            --up right
            {catgridx + 1, catgridy - 1},
            --right
            {catgridx + 1, catgridy},
            --down right
            {catgridx + 1, catgridy + 1},
            --down
            {catgridx, catgridy + 1},
            --down left
            {catgridx - 1, catgridy + 1},
            --left
            {catgridx - 1, catgridy},
            --up left
            {catgridx - 1, catgridy - 1}
        }
        local choice = -1

        local maxdist = -1
        for i = 1, #options do
            if  (options[i][1] <= -1) or (options[i][1] > 15) or (options[i][2] <= -1) or (options[i][2] > 15) or (fget(mget(options[i][1], options[i][2]), 1) == true) then 
                ::continue::
            else
                dist = abs(player.x - ((options[i][1] * 8) + 4)) + abs(player.y - ((options[i][2] * 8) + 4))
                if dist > maxdist then
                    maxdist = dist
                    choice = i
                end
            end
        end

        if choice == 1 then
            cat.y -= 8

        elseif choice == 2 then
            cat.x += 8
            cat.facingLeft = false
            cat.y -= 8

        elseif choice == 3 then
            cat.x += 8
            cat.facingLeft = false

        elseif choice == 4 then
            cat.x += 8
            cat.facingLeft = false
            cat.y += 8

        elseif choice == 5 then
            cat.y += 8

        elseif choice == 6 then
            cat.x -=8
            cat.facingLeft = true
            cat.y += 8

        elseif choice == 7 then
            cat.x -= 8
            cat.facingLeft = true

        elseif choice == 8 then
            cat.x -=8
            cat.facingLeft = true
            cat.y -= 8

        end
    end

end

function cupdate()
    if game.player_it then
        crun()
    else
	    cchase()
    end

end