farmer_abduction_speed = 0.4
farmer_lerp_speed = 0.05
farmer_fall_speed = 0.4
farmer_spawn_height = 100

function calc_next_shoot_time()
	return rnd(3)+2+gametime
end


function create_farmer()
	local farmer = {
		x = rnd(140) - 10,
		y = farmer_spawn_height,
		speed = rnd(0.3) + 0.3,
		fx = false,
		fy = false,
		sp = 2,
		abducted = false,
		dead = false,
		next_shoot_time = calc_next_shoot_time(),
		--false==left
		dir = rnd() < 0.5
	}

	return farmer
end

function update_farmer(farmer)
	if farmer.dead then
		delete_farmer(farmer)
	end
	--move the farmer up when abducted
	if farmer.abducted then
		farmer.fy = true
		farmer.y -= farmer_abduction_speed
		farmer.x = lerp(farmer.x, player.x, farmer_lerp_speed)
		--if farmer is same level as player bye bye farmer--
		if farmer.y <= player.y + 6 then
			delete_farmer(farmer)
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
		if not farmer_dropped then
			if farmer.next_shoot_time<=gametime then
				local projectile = create_projectile(farmer.x, farmer.y, player.x+4, player.y+5)
				projectile.x = farmer.x
				projectile.y = farmer.y
				projectile.rise = 0
				projectile.run = 0
				farmer.next_shoot_time = calc_next_shoot_time()
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