function store_init()
	str={
		p=0,
		s=0,
		i=1
	}
	store_refresh()
	crow_refresh()
end

function store_refresh()
	str.pots=get_t(pots)
	if str.i>count(str.pots) then str.i=count(str.pots) end
	if str.i<=0 then str.i=1 end
end

function crow_refresh()
	str.seeds={}
	for v in all(seeds) do
		if v.b==1 then add(str.seeds,v) end
	end
end

function store_update()
	if str.s==0 then
		if btnp(🅾️) then screen="menu"
		elseif btnp(❎) then
			str.i=1
			if str.p==0 then screen="menu"
			elseif str.p==1 then
				str.s=1
				crow_refresh()
			else --str.p==2
				str.s=1
				store_refresh()
			end
		elseif btnp(⬅️) then
			if str.p<2 then str.p+=1 end
		elseif btnp(➡️) then
			if str.p>0 then str.p-=1 end
		end
	elseif str.s==1 then
		local max=0
		if str.p==1 then max=count(str.seeds) --buying
		elseif str.p==2 then max=count(str.pots) --selling
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
				msg="sold "..p.n
				gold+=p.v
				store_refresh()
				if count(str.pots)==0 then str.s=0 end

			--buying
			else
				s=str.seeds[str.i]
				if gold<s.v then
					msg="cannot afford"
				else
					msg="bought "..s.n.." seed"
					gold-=s.v
					add_item(seeds,s.s,1)
				end
			end
		end
	end
end

function store_draw()
	map(32,0)
	top_bar()

	spr(22,96,48)
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
		else
			draw_item(str.seeds,str.i)
		end
	else
		draw_table(pots,0)
		draw_table(seeds,1)
	end
end