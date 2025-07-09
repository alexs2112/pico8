function lab_init()
	lab={
		i=1,
		state=0,
		time=0,
		max_time=90,
		plants={},
		soup={},
		max=2, --out of 3--
		done=false
	}
end

function lab_tick()
	if lab.done then
		return
	elseif lab.time>=lab.max_time then
		lab.done=true
		lab.state=0
	elseif count(lab.soup)>0 then
		lab.time+=1
	end
end

function lab_update()
	if btnp(🅾️) then
		if lab.state==0 then screen="menu"
		else lab.state=0 end
	elseif btnp(⬅️) then
		lab.i-=1
		if lab.i<=0 then lab.i=count(lab.plants) end
	elseif btnp(➡️) then
		lab.i+=1
		if lab.i>count(lab.plants) then lab.i=1 end
	elseif btnp(❎) then
		if lab.done then
			p=get_pot()
			p.q+=1
			msg="received "..p.n
			lab.done=false
			lab.soup={}
			lab.time=0
		elseif lab.state==0 then
			set_plants()
			if count(lab.plants)>0 then lab.state=1 end
		elseif lab.state==1 then
			add_plant()
			set_plants()
			if count(lab.plants)==0 then lab.state=0
			elseif count(lab.soup)>=lab.max then lab.state=0 end
		end
	end
end

function set_plants()
	lab.plants=get_t(plants)
	if lab.i>count(lab.plants) then lab.i=count(lab.plants) end
	if lab.i<=0 then lab.i=1 end
end

function lab_draw()
	map(32,0)
	top_bar()
	spr(48,60,60)
	spr(1,36,60)

	if lab.state==0 then
		draw_table(plants,0)
		draw_table(pots,1)
	else
		draw_item(lab.plants,lab.i)
	end

	rect(74,32,77,68,5)
	if lab.time>0 then
		rectfill(75,67,76,67-flr(34*(lab.time/lab.max_time)),10)
	end
	x=80 y=58
	for i=1,3 do
		rect(x,y,x+9,y+9,5)
		if i>lab.max then spr(7,x+1,y+1) end
		if lab.soup[i] then
			spr(lab.soup[i].s,x+1,y+1)
			statbar(lab.soup[i],x+12,y+3)
		end
		y-=12
	end
	rect(x-9,y-1,x,y+8,5)
	if lab.done then
		spr(get_pot().s,x-8,y)
		statbar(get_pot(),x+4,y+3)
	elseif lab.time>0 then spr(8,x-8,y) end

	--Temp--
	if lab.done then spr(49,60,52) end
end

function add_plant()
	if count(lab.soup)<lab.max then
		add(lab.soup,lab.plants[lab.i])
		add_item(plants,lab.plants[lab.i].s,-1)
	end
end

function get_pot()
	local r=0
	local y=0
	local u=0
	for v in all(lab.soup) do
		r+=v.r
		y+=v.y
		u+=v.u
	end
	for v in all(pots) do
		if v.r==r and v.y==y and v.u==u then return v end
	end
	--error pot--
	return pots[1]
end