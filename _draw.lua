function draw_ground()
	map(0, 7, 0, 107, 16, 1)
	map(0, 8, 0, 115, 16, 3)
end

function draw_beam()
	if beam_on then
		for i = 0, 7 do
			spr(SPR_BEAM, player.x - 4, player.y + 7 + i * 16, 2, 2)
		end
	end
end

function _draw()
	cls()

	if not game_over then
		print(gametime, 0, 0, 7)
		draw_beam()
		draw_ground()
		-- draw player -- 
		spr(SPR_PLAYER, player.x, player.y, 1, 1, player.fx, player.fy)

		-- drawing cows --
		for _, cow in ipairs(cows) do
			if cow.dead then
				spr(SPR_COW_DEAD, cow.x, cow.y, 1, 1, cow.dir, cow.fy)
			else
				spr(SPR_COW, cow.x, cow.y, 1, 1, cow.dir, cow.fy)
			end
		end
		--draw farmers-
		for _, farmer in ipairs(farmers) do
			if farmer.dead then
				spr(SPR_FARMER_DEAD, farmer.x, farmer.y - 1, 1, 1, farmer.dir, farmer.fy)
			else
				spr(SPR_FARMER, farmer.x, farmer.y - 1, 1, 1, farmer.dir, farmer.fy)
			end
		end
		--draw cops --
		for _, cop in ipairs(cops) do
			if cop.dead then
				spr(SPR_COP_DEAD, cop.x, cop.y - 1, 1, 1, cop.dir, cop.fy)
			else
				spr(SPR_COP, cop.x, cop.y - 1, 1, 1, cop.dir, cop.fy)
			end
		end
		-- low limit warning --
		if low_flag then
			print("too low! too low!", 32, 40, 8)
			low_flag = false
		end
		-- high limit warning --
		if high_flag then
			print("too high! too high!", 32, 40, 8)
			high_flag = false
		end
		-- right limit warning --
		if right_flag then
			print("too far east!", 32, 40, 8)
			right_flag = false
		end
		-- left limit warning --
		if left_flag then
			print("too far west!", 32, 40, 8)
			left_flag = false
		end
		-- draw projectiles --
		for _, projectile in ipairs(projectiles) do
			spr(projectile.sp, projectile.x, projectile.y, 1, 1)
		end

		--print score--
		print(score, 63, 0, 11)


		--draw health bar--
		if player.health == 3 then
			spr(SPR_HEALTH_3, 112, 40, 2, 2)
		end
		if player.health == 2 then
			spr(SPR_HEALTH_2, 112, 40, 2, 2)
		end
		if player.health == 1 then
			spr(SPR_HEALTH_1, 112, 40, 2, 2)
		end
	else
		--game end--
		if game_over then
			print("your score:"..score, 34, 82, 11)
			sspr(12, 44, 26, 5, 25, 56, 78, 15)
			--make text blink every other half second
			if (gametime - game_over_time) % 1 > 0.5 then
				print("press X to play again...", 15, 100, 11)
			end
		end
	end
end
