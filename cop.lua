cop_abduction_speed = 0.7
cop_lerp_speed = 0.05
cop_fall_speed = 0.6
cop_spawn_height = 100
cop_spawn_min_kill = 8

function calc_cop_next_shoot_time()
	return rnd(1)+1+gametime
end


function create_cop()
	local cop = {
		x = rnd(140) - 10,
		y = cop_spawn_height,
		speed = rnd(0.3) + 0.3,
		fx = false,
		fy = false,
		sp = SPR_COP,
		abducted = false,
		dead = false,
		next_shoot_time = calc_cop_next_shoot_time(),
		--false==left
		dir = rnd() < 0.5
	}

	return cop
end

function update_cop(cop)
	if cop.dead then
		delete_cop(cop)
		kills += 1
	end
	--move the cop up when abducted
	if cop.abducted then
		cop.fy = true
		cop.y -= cop_abduction_speed
		cop.x = lerp(cop.x, player.x, cop_lerp_speed)
		--if cop is same level as player bye bye cop--
		if cop.y <= player.y + 6 and cop.y >= player.y + 3 then
			delete_cop(cop)
			kills += 1		
		end
	else
		--cop falling--
		cop_dropped = cop.y < cop_spawn_height
		if cop_dropped then
			cop.y += cop_fall_speed
		end
		--dead cop makes good steak--
		if cop.fy and cop.y >= cop_spawn_height then
			cop.dead = true
			sfx(00)
		end
		if not cop_dropped and not cop.dead then
			if cop.next_shoot_time<=gametime then
				local bullet = create_cop_bullet(cop.x, cop.y, player.x+CENTRE_OF_PLAYER_OFFSET_X, player.y+CENTRE_OF_PLAYER_OFFSET_Y)
				cop.next_shoot_time = calc_cop_next_shoot_time()
			end
			cop_move_normal(cop)
		end
	end
end

function delete_cop(cop)
	del(cops, cop)
end
function cop_move_normal(cop)
	--move normal--
	if not cop.dir then
		cop.x -= cop.speed
	else
		cop.x += cop.speed
	end
	--keep the cop in the fence--
	if cop.x < 0 then
		cop.dir = true
	end
	if cop.x > 120 then
		cop.dir = false
	end
end