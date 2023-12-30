function draw_ground()
	map(0, 7, 0, 107, 16, 1)
	map(0, 8, 0, 115, 16, 3)
end

function draw_beam()
	if beam_on then
		for i = 0, 7 do
			spr(9, player.x - 4, player.y + 7 + i * 16, 2, 2)
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
		spr(1, player.x, player.y, 1, 1, player.fx, player.fy, player.sp)

		-- drawing cows --
		for _, cow in ipairs(cows) do
			if cow.dead then
				spr(12, cow.x, cow.y, 1, 1, cow.dir, cow.fy, cow.sp)
			else
				spr(2, cow.x, cow.y, 1, 1, cow.dir, cow.fy, cow.sp)
			end
		end
		--draw farmers-
		for _, farmer in ipairs(farmers) do
			if farmer.dead then
				spr(04, farmer.x, farmer.y - 1, 1, 1, farmer.dir, farmer.fy, farmer.sp)
			else
				spr(03, farmer.x, farmer.y - 1, 1, 1, farmer.dir, farmer.fy, farmer.sp)
			end
		end
		-- low limit warning --
		if altitude_flag then
			print("too low! too low!", 32, 40, 8)
			altitude_flag = false
		end
		-- draw projectiles --
		for _, projectile in ipairs(projectiles) do
			spr(projectile.sp, projectile.x, projectile.y, 1, 1)
		end

		--print score--
		print(score, 63, 0, 11)


		--draw health bar--
		if player.health == 3 then
			spr(32, 112, 40, 2, 2)
		end
		if player.health == 2 then
			spr(34, 112, 40, 2, 2)
		end
		if player.health == 1 then
			spr(36, 112, 40, 2, 2)
		end
	else
		--game end--
		if game_over then
			print("your score:"..score, 34, 85, 11)
			sspr(12, 44, 26, 5, 25, 56, 78, 15)
			print("press X to continue...", 20, 100, 12)
		end
	end
end
