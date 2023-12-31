function _update()
	-- if space is being held --
	beam_on = btn(BTN_X)
	if beam_on then
		for _, cow in ipairs(cows) do
			cow.abducted = is_in_beam(cow)
		end
		for _, farmer in ipairs(farmers) do
			farmer.abducted = is_in_beam(farmer)
		end
		for _, cop in ipairs(cops) do
			cop.abducted = is_in_beam(cop)
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
		for _, cop in ipairs(cops) do
			if cop.abducted then
				cop.abducted = false
			end
		end
	end

	-- x movement --
	if btn(➡️) then
		player.x += player.speed
		player.fx = false
	end
	if btn(⬅️) then
		player.x -= player.speed
		player.fx = true
	end
	-- y movement --
	if btn(⬆️) then
		player.y -= player.speed
	end
	if btn(⬇️) then
		if player.y + player.speed > LOW_LIMIT then
			player.y = LOW_LIMIT
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

	-- cop movement --
	for _, cop in ipairs(cops) do
		update_cop(cop)
	end

	--projectile movement--
	for _, projectile in ipairs(projectiles) do
		update_projectile(projectile)
	end

	--game states--
	if player.health < 1 and game_over == false then
		-- set game over time to gametime when the game is over
		game_over_time = gametime
		game_over = true
	end
	if btn(BTN_X) and game_over then
		run()
	end

	--time--
	--update gametime to the time since game start every frame
	gametime = time() - starttime
	if previous_update_time % SPAWN_RATE_COW > gametime % SPAWN_RATE_COW then
		add(cows, create_cow())
	end
	if previous_update_time % SPAWN_RATE_FARMER > gametime % SPAWN_RATE_FARMER then
		add(farmers, create_farmer())
	end
	if previous_update_time % SPAWN_RATE_COP > gametime % SPAWN_RATE_COP and kills>= cop_spawn_min_kill then
		add(cops, create_cop())
	end
	previous_update_time = gametime
end