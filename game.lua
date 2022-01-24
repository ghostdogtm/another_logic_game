require "modules/game_functions"

game = {}

local level_map = {
	{1, 2, 3, 4},
	{1, 2, 3, 4},
	{1, 2, 3, 4},
	{1, 2, 3, 4}
	}
-- "randomize" map
local randomize_map = {}
local row_index = 0
local col_index = 0
local game_music = love.audio.newSource("music/game.xm", "stream")

function game.load()
	randomize_map = {
		{1, 2, 3, 4},
		{1, 2, 3, 4},
		{1, 2, 3, 4},
		{1, 2, 3, 4}
	}
	win = 0
	moves = 0
	all_moves = 0
	music_volume = setting.sound.game
	love.audio.setVolume(music_volume)
	game_music:setLooping(true)
	game_music:play()

	all_moves = make_rnd_map(randomize_map)
	update_blocks(tilesets.big_block, randomize_map)
	update_blocks(tilesets.small_block, level_map)
end

function game.draw()
	love.graphics.draw(tilesets.big_block.batch, 19, 19)

	love.graphics.rectangle("line", 18, 18 + 32 * row_index, 128, 32)
	love.graphics.rectangle("line", 18 + 32 * col_index, 18, 32, 128)

	love.graphics.draw(tilesets.small_block.batch, 185, 32)
	love.graphics.setLineStyle("rough")
	love.graphics.rectangle("line", 185, 32, 28, 28)
	love.graphics.rectangle("line", 18, 172, 218, 60)
	love.graphics.print(string.format("Moves: %d/%d", moves, all_moves), 20, 175)
	love.graphics.print("Music Volume: "..music_volume, 20, 195)

	if win == 1 then love.graphics.print("YOU WIN! LOL", 20, 220) end
end

function game.keypressed(key, scancode, isrepeat)
	if (key == "right") then
		randomize_map[row_index+1] = arrayRotateRight(randomize_map[row_index+1])
		check_win(level_map, randomize_map)
		update_blocks(tilesets.big_block, randomize_map)
		moves = moves + 1
	elseif (key == "left") then
		randomize_map[row_index+1] = arrayRotateLeft(randomize_map[row_index+1])
		check_win(level_map, randomize_map)
		update_blocks(tilesets.big_block, randomize_map)
		moves = moves + 1
	elseif (key == "down") then
		arrayRotateDown(col_index+1, randomize_map)
		check_win(level_map, randomize_map)
		update_blocks(tilesets.big_block, randomize_map)
		moves = moves + 1
	elseif (key == "up") then
		arrayRotateUp(col_index+1, randomize_map)
		check_win(level_map, randomize_map)
		update_blocks(tilesets.big_block, randomize_map)
		moves = moves + 1
	end
	if (key == "w") then
		if row_index ~= 0 then
			row_index = row_index - 1
		else
			row_index = 3
		end
	elseif (key == "s") then
		if row_index ~= 3 then
			row_index = row_index + 1
		else
			row_index = 0
		end
	elseif (key == "a") then
		if col_index ~= 0 then
			col_index = col_index - 1
		else
			col_index = 3
		end
	elseif (key == "d") then
		if col_index ~= 3 then
			col_index = col_index + 1
		else
			col_index = 0
		end
	end

	-- sound setting
	if (key == "1" and music_volume ~= 0) then
		music_volume = music_volume - 0.1
		if (music_volume < 0.1) then music_volume = 0 end
		set_and_save_music_vol('game', music_volume)
	elseif (key == "2" and music_volume <= 0.9) then
		music_volume = music_volume + 0.1
		set_and_save_music_vol('game', music_volume)
	end

	if (key == "return" and win == 1 or key == "r") then
		game.load()
	end
end

function set_and_save_music_vol(state, vol)
	love.audio.setVolume(vol)
	setting['sound'][state] = vol
	inifile.save('setting.ini', setting)
end
