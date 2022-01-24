require "modules/inifile"

-- love.filesystem.setIdentity("another_logic_game")

setting_file = love.filesystem.getInfo("setting.ini", file)

if setting_file == nil or setting_file.size == 0 then
	s = {
		window = {
			title  = "Another Logic Game",
			width  = 256,
			height = 240,
			zoom   = 1
		},
		sound = {
			menu = 0.1,
			game = 0.2
		},
		game = {
			author = "GhostDog"
		}
	}

	inifile.save("setting.ini", s)
end

setting = inifile.parse("setting.ini")

function love.conf(t)
	t.window.title  = setting.window.title
	t.window.width  = setting.window.width
	t.window.height = setting.window.height
end
