function _init()
	printh('start of game')

	starttime = time()

	gametime = 0

	button = ""

	lowlimit = 80

	altitude_flag = false

	score = 0

	beam_half_width = 8

	beam_on = false

	player = {
		health = 3,
		speed = 1,
		x = 63,
		y = 63,
		fx = false,
		fy = false,
		sp = 1,
		--relative to top left of sprite--
		collider = {
			-- top left --
			x1 = 1,
			y1 = 3,
			-- bottom right --
			x2 = 6,
			y2 = 6
		},
		check_if_collider_hit = function(self, x, y)
			-- translate the relative player collider to screen space --
			local absolute_player_collider = {
				x1 = self.x + self.collider.x1,
				y1 = self.y + self.collider.y1,
				x2 = self.x + self.collider.x2,
				y2 = self.y + self.collider.y2
			}
			-- its between the top of the box and the bottom of the box.
			local is_between_top_and_bottom = y>absolute_player_collider.y1 and y<absolute_player_collider.y2
			--and its between the right and left
			local is_between_right_and_left = x>absolute_player_collider.x1 and x<absolute_player_collider.x2

			local is_in_box = is_between_top_and_bottom and is_between_right_and_left
			return is_in_box
		end
	}

	cows = {
		create_cow(),
		create_cow(),
		create_cow()
	}

	farmers = {
		create_farmer(),
		create_farmer()
	}
end

function is_in_beam(object)
	return object.x < player.x + beam_half_width and object.x > player.x - beam_half_width
end

