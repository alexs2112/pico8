function store_init()
	str={
		p=0,
		s=0,
		i=1
	}
	store_refresh()
end

function store_refresh()
	str.pots=get_t(pots)
	if str.i>count(str.pots) then str.i=count(str.pots) end
	if str.i<=0 then str.i=1 end
end

function store_update()
	if str.s==0 then
		if btnp(🅾️) then screen="menu"
		elseif btnp(❎) then
			if str.p==0 then screen="menu"
			elseif str.p==2 then
				str.s=1
				store_refresh()
			else str.s=1 end
		elseif btnp(⬅️) then
			if str.p<2 then str.p+=1 end
		elseif btnp(➡️) then
			if str.p>0 then str.p-=1 end
		end
	elseif str.s==1 then
		local max=0
		if str.p==1 then max=count(str.pots) --buying
		elseif str.p==2 then max=0 --selling
		end

		if btnp(🅾️) then str.s=0
		elseif btnp(⬅️) then
			str.i-=1
			if str.i<=0 then str.i=max end
		elseif btnp(➡️) then
			str.i+=1
			if str.i>max then str.i=1 end
		elseif btnp(❎) then
			--selling--
			if str.p==2 and count(str.pots)>0 then
				p=str.pots[str.i]
				add_item(pots,p.s,-1)
				gold+=p.v
				store_refresh()
				if count(str.pots)==0 then str.i=0 end

			--buying
			else
				--pass
			end
		end
	end
end

function store_draw()
	map(32,0)
	top_bar()
	print(str.s.." "..str.p.." "..str.i, 16,16,7)

	spr(23,96,48)
	spr(33,56,48)
	spr(32,28,48)
	px=96
	if str.p==1 then px=64
	elseif str.p==2 then px=36 end
	spr(1,px,48)

	if str.s==1 then
		if str.p==2 then
			if count(str.pots)>0 then
				draw_item(str.pots, str.i)
			else
				print("no potions to sell...",16,96,6)
			end
		end
	else
		draw_table(pots,0)
		draw_table(seeds,1)
	end
end