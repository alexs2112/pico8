function bed_init()
end

function bed_enter()
	p.x=20
	p.f=false
	door_init()
	door_add(12)
end

function bed_update()
	if btnp(🅾️) then
		screen="menu"
	elseif btnp(❎) then
		door_enter()
	end
	p_update()
end

function bed_draw()
	map(32,0)
	top_bar()
	door_draw()
	p_draw()
end