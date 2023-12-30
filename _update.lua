function _update()
	-- if space is being held --
	beam_on = btn(5)
	if beam_on then
		for _, cow in ipairs(cows) do
			cow.abducted = is_in_beam(cow)
		end
		for _, farmer in ipairs(farmers) do
			farmer.abducted = is_in_beam(farmer)
		end
	else
		-- if space is released, release abducted cows -- --
		for _, cow in ipairs(cows) do
			if cow.abducted then
				cow.abducted = false
			end
		end
		for _, farmer in ipairs(farmers) do
			if farmer.abducted then
				farmer.abducted = false
			end
		end
	end

	-- x movement --
	if btn(➡️) then
		player.x += player.speed
		player.fx = false
		player.sp = 1
	end
	if btn(⬅️) then
		player.x -= player.speed
		player.fx = true
		player.sp = 1
	end
	-- y movement --
	if btn(⬆️) then
		player.y -= player.speed
	end
	if btn(⬇️) then
		if player.y + player.speed > lowlimit then
			player.y = lowlimit
			altitude_flag = true
		else
			player.y += player.speed
		end
	end

	-- cow movement --
	for _, cow in ipairs(cows) do
		update_cow(cow)
	end
	-- farmer movement --
	for _, farmer in ipairs(farmers) do
		update_farmer(farmer)
	end

	--projectile movement--
	for _, projectile in ipairs(projectiles) do
		update_projectile(projectile)
	end

	--game states--
	if player.health < 1 then
		game_over = true
	end
	if btn(5) and game_over then
		run()
	end

	--time--
	gametime = time() - starttime
	if previous_update_time % 10 > gametime % 10 then
		add(cows, create_cow())
	end
	if previous_update_time % 5 > gametime % 5 then
		add(farmers, create_farmer())
	end
	previous_update_time = gametime
end