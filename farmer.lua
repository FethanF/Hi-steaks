farmer_abduction_speed = 0.5
farmer_lerp_speed = 0.05
farmer_fall_speed = 0.4
farmer_spawn_height = 100

function calc_farmer_next_shoot_time()
	return rnd(1)+2+gametime
end


function create_farmer()
	local farmer = {
		x = rnd(140) - 10,
		y = farmer_spawn_height,
		speed = rnd(0.3) + 0.3,
		fx = false,
		fy = false,
		sp = SPR_FARMER,
		abducted = false,
		dead = false,
		next_shoot_time = calc_farmer_next_shoot_time(),
		--false==left
		dir = rnd() < 0.5
	}

	return farmer
end

function update_farmer(farmer)
	if farmer.dead then
		delete_farmer(farmer)
		kills += 1
	end
	--move the farmer up when abducted
	if farmer.abducted then
		farmer.fy = true
		farmer.y -= farmer_abduction_speed
		farmer.x = lerp(farmer.x, player.x, farmer_lerp_speed)
		--if farmer is same level as player bye bye farmer--
		if farmer.y <= player.y + 6 and farmer.y >= player.y + 3 then
			delete_farmer(farmer)
			kills += 1
		end
	else
		--farmer falling--
		farmer_dropped = farmer.y < farmer_spawn_height
		if farmer_dropped then
			farmer.y += farmer_fall_speed
		end
		--dead farmer makes good steak--
		if farmer.fy and farmer.y >= farmer_spawn_height then
			farmer.dead = true
			sfx(00)
		end
		if not farmer_dropped and not farmer.dead then
			if farmer.next_shoot_time<=gametime then
				local bullet = create_bullet(farmer.x, farmer.y, player.x+CENTRE_OF_PLAYER_OFFSET_X, player.y+CENTRE_OF_PLAYER_OFFSET_Y)
				farmer.next_shoot_time = calc_farmer_next_shoot_time()
			end
			farmer_move_normal(farmer)
		end
	end
end

function delete_farmer(farmer)
	del(farmers, farmer)
end
function farmer_move_normal(farmer)
	--move normal--
	if not farmer.dir then
		farmer.x -= farmer.speed
	else
		farmer.x += farmer.speed
	end
	--keep the farmer in the fence--
	if farmer.x < 0 then
		farmer.dir = true
	end
	if farmer.x > 120 then
		farmer.dir = false
	end
end