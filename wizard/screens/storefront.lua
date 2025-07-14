function store_init()
	str={
		p=0,
		s=0,
		i=1
	}
	sellx=32
	crowx=64
	store_refresh()
	crow_refresh()
end

function store_enter()
	p.x=102
	p.f=true
	str.p=0
	door_init()
	door_add(112)
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
		p_update()
		if btnp(❎) then
			if door_enter() then return
			elseif p.x>crowx-8 and p.x<crowx+8 then
				str.s=1
				str.p=1
				crow_refresh()
			elseif p.x>sellx-8 and p.x<sellx+8 then
				str.s=1
				str.p=2
				store_refresh()
			end
		end
	else
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
				pot=str.pots[str.i]
				add_item(pots,pot.s,-1)
				msg="sold "..pot.n
				gold+=pot.v
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
	draw_floor(28,120)
	map(32,0)
	top_bar()
	door_draw()

	spr(34,crowx,p.y)
	spr(33,crowx,p.y-6,1,1,p.x<crowx)
	p_draw()
	spr(32,sellx,p.y)

	if str.s==0 then
		if p.x>crowx-8 and p.x<crowx+8 then
			print("❎",crowx,p.y+14,6)
		elseif p.x>sellx-8 and p.x<sellx+8 then
			print("❎",sellx,p.y+14,6)
		end
	end

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