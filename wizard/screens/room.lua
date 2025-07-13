function bed_init()
end

function bed_update()
	if btnp(🅾️) then
		screen="menu"
	end
	p_update()
end

function bed_draw()
	map(32,0)
	top_bar()
	p_draw()
end