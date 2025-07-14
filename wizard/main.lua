function _init()
	menu_init()
	items_init()
	gdn_init()
	lab_init()
	store_init()
	bed_init()
	p_init()
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
		p_tick()
		if screen=="menu" then
			menu_update()
		elseif screen=="garden" then
			gdn_update()
		elseif screen=="alchemy lab" then
			lab_update()
		elseif screen=="storefront" then
			store_update()
		elseif screen=="bedroom" then
			bed_update()
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
		elseif screen=="storefront" then
			store_draw()
		elseif screen=="bedroom" then
			bed_draw()
		end
	end
	print(msg,8,16,7)
	print(err,8,22,8)
end

function top_bar()
	print("●"..gold,4,3,10)
	print("⧗04:59",94,3,7)
end

function draw_floor(x1,x2)
	while x1<x2 do
		spr(21,x1+1,p.y+8)
		x1+=8
	end
	if x1>x2 then rectfill(x2+1,p.y+8,x1,p.y+12,1) end
end