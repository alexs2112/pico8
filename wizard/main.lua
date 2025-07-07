function _init()
	gdn_init()
	items_init()
	screen="garden"
	err="" --debug--
end

function _update()
	gdn_tick()
	if screen=="garden" then
		gdn_update()
	end
end

function _draw()
	cls()
	map()
	if screen=="garden" then
		gdn_draw()
	end
	print("●9999",4,3,10)
	print("⧗04:59",94,3,7)
	print(err,8,16,7)
end
