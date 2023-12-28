function lerp(a, b, t)
	local result = a + t * (b - a)
	return result
end

function calc_hypotenuse(a, b)
	local hypotenuse = sqrt((a*a)+(b*b))
	return hypotenuse
end

function calc_unit_vector(x1,y1,x2,y2)
	--takes 2 points & finds the ratio of rise and run where the hypotenuse is 1--
	local a = x2-x1
	local b = y2-y1
	local hypotenuse = calc_hypotenuse(a, b)
	local rise = b/hypotenuse
	local run = a/hypotenuse

	return {
		rise = rise,
		run = run,
	}
end