function is_equal(o1, o2, ignore_mt)
	local ty1 = type(o1)
	local ty2 = type(o2)
	if ty1 ~= ty2 then return false end

	-- non-table types can be directly compared
	if ty1 ~= 'table' then return o1 == o2 end

	-- as well as tables which have the metamethod __eq
	local mt = getmetatable(o1)
	if not ignore_mt and mt and mt.__eq then return o1 == o2 end

	--local is_equal = Underscore.funcs.is_equal

	for k1,v1 in pairs(o1) do
		local v2 = o2[k1]
		if v2 == nil or not is_equal(v1,v2, ignore_mt) then return false end
	end
	for k2,v2 in pairs(o2) do
		local v1 = o1[k2]
		if v1 == nil then return false end
	end
	return true
end

function arrayRotateRight(array)
	local size = #array
	local temp = array[size]

	while size > 1 do
		array[size] = array[size-1]
		size = size - 1
	end
	array[1] = temp

	return array
end

function arrayRotateLeft(array)
	local size = #array
	local temp = array[1]

	for i = 1, size-1 do
		array[i] = array[i+1]
	end
	array[size] = temp

	return array
end

function arrayRotateDown(column_index, map)
	local array = {}
	local i = 0

	for i = 1, #map do
		array[i] = map[i][column_index]
	end
	array = arrayRotateRight(array)
	for i = 1, #map do
		map[i][column_index] = array[i]
	end
end

function arrayRotateUp(column_index, map)
	local array = {}
	local i = 0

	for i = 1, #map do
		array[i] = map[i][column_index]
	end
	array = arrayRotateLeft(array)
	for i = 1, #map do
		map[i][column_index] = array[i]
	end
end

function check_win(level_map, shuffle_map)
	if (is_equal(shuffle_map, level_map) and win ~= 1) then win = 1 end
end

function make_rnd_map(level_map)
	local i = 0
	local j = 0
	local rnd_action = 0

	math.randomseed(os.time())
	math.random(25)
	local rnd_count = math.random(25)

	for i = 1, rnd_count do
		rnd_action = math.random(4)
		rnd_row_index = math.random(3)
		rnd_col_index = math.random(3)
		if (rnd_action == 1) then
			arrayRotateRight(level_map[rnd_row_index+1])
		elseif (rnd_action == 2) then
			arrayRotateLeft(level_map[rnd_row_index+1])
		elseif (rnd_action == 3) then
			arrayRotateDown(rnd_col_index+1, level_map)
		elseif (rnd_action == 4) then
			arrayRotateUp(rnd_col_index+1, level_map)
		end
	end

	return rnd_count
end
