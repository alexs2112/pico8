function _init()
	menu_init()
	items_init()
	gdn_init()
	lab_init()
	screen="start"
	msg=""
	err="" --debug--
end

function _update()
	if screen=="start" then
		start_update()
	else
		if btnp(❎) or btnp(🅾️) then msg="" err="" end
		gdn_tick()
		lab_tick()
		if screen=="menu" then
			menu_update()
		elseif screen=="garden" then
			gdn_update()
		elseif screen=="alchemy lab" then
			lab_update()
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
		elseif screen=="alchemy lab" then
			lab_draw()
		end
	end
	print(msg,8,16,7)
	print(err,8,22,8)
end

function top_bar()
	print("●9999",4,3,10)
	print("⧗04:59",94,3,7)
end