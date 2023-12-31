previous_update_time = 0
cow_abduction_speed = 0.4
cow_lerp_speed = 0.05
cow_fall_speed = 0.5
cow_spawn_height = 100

function create_cow()
	local cow = {
		x = rnd(140) - 10,
		y = cow_spawn_height,
		speed = rnd(0.3) + 0.3,
		fx = false,
		fy = false,
		sp = SPR_COW,
		abducted = false,
		dead = false,
		--false==left
		dir = rnd() < 0.5
	}

	return cow
end

function update_cow(cow)
	if cow.dead then
		delete_cow(cow)
	end
	--move the cow up when abducted
	if cow.abducted then
		cow.fy = true
		cow.y -= cow_abduction_speed
		cow.x = lerp(cow.x, player.x, cow_lerp_speed)
		--if cow is roughly at player height bye bye cow--
		if cow.y <= player.y + 6 and cow.y >= player.y + 3 then
			delete_cow(cow)
			score += 1
		end
	else
		--cow falling--
		cow_dropped = cow.y < cow_spawn_height
		if cow_dropped then
			cow.y += cow_fall_speed
		end
		--dead cow makes good steak--
		if cow.fy and cow.y >= cow_spawn_height then
			cow.dead = true
			sfx(00)
		end
		if not cow_dropped then
			cow_move_normal(cow)
		end
	end
end

function delete_cow(cow)
	del(cows, cow)
end

function cow_move_normal(cow)
	--move normal--
	if not cow.dir then
		cow.x -= cow.speed
	else
		cow.x += cow.speed
	end
	--keep the cow in the fence--
	if cow.x < 0 then
		cow.dir = true
	end
	if cow.x > 120 then
		cow.dir = false
	end
end