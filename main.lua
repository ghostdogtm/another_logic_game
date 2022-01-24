require "game"
require "menu"
require "modules/game_stuff"

state = menu

function love.load()
	local font = love.graphics.newFont("fonts/prstartk.ttf", 8)
	love.graphics.setFont(font)
	tiles_display_width  = 4
	tiles_display_height = 4
	tilesets = {
    big_block   = { name = "big_block_tileset",   block_size = 32, quads = {} },
    small_block = { name = "small_block_tileset", block_size = 7,  quads = {} }
  }
	load_blocks(tilesets.big_block)
	load_blocks(tilesets.small_block)

	if state.load then state.load() end
end

function love.keypressed(key, scancode, isrepeat)
	if state.keypressed then state.keypressed(key, scancode, isrepeat) end
end

function love.draw()
	if state.draw then state.draw() end
end
