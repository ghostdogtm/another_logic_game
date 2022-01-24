function load_blocks(tileset)
  local tileset_sprite = love.graphics.newImage("img/" .. tileset.name .. ".png")
  tileset.batch = love.graphics.newSpriteBatch(tileset_sprite, tiles_display_width * tiles_display_height)
  local i = 0
  local block_size = tileset.block_size

	-- this "linear filter" removes some artifacts if we were to scale the tiles
	tileset_sprite:setFilter("nearest", "linear")
	for i = 1, 4 do
		tileset.quads[i] = love.graphics.newQuad((i-1) * block_size, 0 * block_size,
		block_size, block_size, tileset_sprite:getWidth(), tileset_sprite:getHeight())
	end
end

function update_blocks(tileset, map)
  local i = 0
  local j = 0
  tileset.batch:clear()
  for i = 1, tiles_display_width do
    for j = 1, tiles_display_height do
      tileset.batch:add(tileset.quads[map[j][i]], (i-1)*tileset.block_size, (j-1)*tileset.block_size)
    end
  end
  tileset.batch:flush()
end
