function menu_init()
	menu={
		i=1,
		opts={
			"storefront",
			"garden",
			"alchemy lab",
			"bedroom"
		}
	}
end

function menu_update()
	if btnp(⬇️) then
		menu.i+=1
		if menu.i>count(menu.opts) then menu.i=1 end
	elseif btnp(⬆️) then
		menu.i-=1
		if menu.i<1 then menu.i=count(menu.opts) end
	elseif btnp(❎) then
		screen=menu.opts[menu.i]
	end
end

function menu_draw()
	map(16,0)
	top_bar()
	x=24
	y=21
	i=1
	for o in all(menu.opts) do
		c=6
		if i==menu.i then
			spr(1,x-16,y-2)
			c=7
		end
		print(o,x,y,c)
		y+=16
		i+=1
	end
end