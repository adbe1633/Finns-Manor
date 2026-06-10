function pinit()
	player = {
		x=64,
		y=20,
		speed = 1,
		cm=true,
		cw=true,
        facingLeft = false
	}
	
end

function pupdate()
	local x = player.x
	local y = player.y
	
	if btn(⬅️) then 
		player.x -= player.speed
        player.facingLeft = true
	elseif btn(➡️) then  
		player.x += player.speed
        player.facingLeft = false
	end
	if cmap(player, 1) or cmap(player, 2) then
		player.x = x
	end
	
	if btn(⬆️) then 
		player.y -= player.speed
	elseif btn(⬇️) then 
		player.y += player.speed
	end
	if cmap(player, 1) or cmap(player, 2) then
		player.y = y
	end
end