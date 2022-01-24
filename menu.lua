menu = {}

local love_ver = string.format("LOVE Ver: %d.%d.%d\n%s", love.getVersion())
local logo_map = {{1, 2, 3, 4}, {4, 1, 2, 3}, {3, 4, 1, 2}, {2, 3, 4, 1}}
local menu_music = love.audio.newSource("music/menu.mod", "stream")

function menu.load()
  music_volume = setting.sound.menu
  love.audio.setVolume(music_volume)
  love.audio.play(menu_music)
  update_blocks(tilesets.big_block, logo_map)
end

function menu.draw()
  love.graphics.draw(tilesets.big_block.batch, 64, 15)
  love.graphics.print("PRESS ENTER TO START", 48, 165)
  love.graphics.print("   GhostDog 2016    ", 48, 175)
  love.graphics.print(love_ver, 48, 185)
end

function menu.keypressed(key, scancode, isrepeat)
  if key == "return" then
    love.audio.stop(menu_music)
    state = game
    game.load()
  end
end
