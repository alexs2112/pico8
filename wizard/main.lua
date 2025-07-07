function _init()
	menu_init()
	gdn_init()
	items_init()
	screen="start"
	err="" --debug--
end

function _update()
	if screen=="start" then
		start_update()
	else
		gdn_tick()
		if screen=="menu" then
			menu_update()
		elseif screen=="garden" then
			gdn_update()
		end
	end
end

function _draw()
	cls(1)
	if screen=="start" then
		start_draw()
	else
		if screen=="menu" then
			menu_draw()
		elseif screen=="garden" then
			gdn_draw()
		end
	end
end

function top_bar()
	print("●9999",4,3,10)
	print("⧗04:59",94,3,7)
	print(err,8,16,7)
end