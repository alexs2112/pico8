function gdn_init()
	gdn={
		state=0,
		selected=1,
		max_plots=3,
		seeds={},
		seed=1,
		plots={nil,nil,nil,nil,nil},
		timers={0,0,0,0,0}
	}
end

function gdn_update()
	if gdn.state==0 then
		--select plant--
		if btnp(➡️) then
			gdn.selected+=1
			if gdn.selected>gdn.max_plots then
				gdn.selected=1
			end
		elseif btnp(⬅️) then
			gdn.selected-=1
			if gdn.selected==0 then
				gdn.selected=gdn.max_plots
			end
		elseif btnp(❎) then
			if gdn.plots[gdn.selected] then
				harvest()
			else
				plant_mode()
			end
		end

	elseif gdn.state==1 then
		--select seed--
		if btnp(🅾️) then gdn.state=0
		elseif btnp(⬅️) then
			gdn.seed-=1
			if gdn.seed<=0 then gdn.seed=max_seeds end
		elseif btnp(➡️) then
			gdn.seed+=1
			if gdn.seed>max_seeds then gdn.seed=1 end
		elseif btnp(❎) then
		 plant()
		end
	end
end

function harvest()
	plt=gdn.plots[gdn.selected]
	if is_grown(plt) then
		gdn.plots[gdn.selected]=nil
		add_item(plants,plt,1)
	end
end

function plant_mode()
	gdn.seeds=get_seeds()
	max_seeds=count(gdn.seeds)
	if max_seeds>0 then gdn.state=1 end
	if gdn.seed>max_seeds then gdn.seed=max_seeds end
	if gdn.seed<=0 then gdn.seed=1 end
end

function plant()
	plt=gdn.plots[gdn.selected]
	seed=gdn.seeds[gdn.seed]
	if not plt then
		gdn.plots[gdn.selected]=seed.p
		add_item(seeds,seed.s,-1)
 	gdn.timers[gdn.selected]=0
 	gdn.state=0
	end
end

function gdn_draw()
	sx=64-(gdn.max_plots*8+2)/2
	sy=32
	for i=1,gdn.max_plots do
		plt=gdn.plots[i]
		spr(6,sx,sy)
		if plt~=nil then
			spr(plt,sx,sy-8)
		end
		if gdn.selected==i then
			spr(1,sx,sy+10)
		end
		sx+=10
	end
	if gdn.state==0 then
		draw_table(seeds,0)
		draw_table(plants,1)
	else
		draw_dots()
		draw_seed()
	end
end

function draw_dots()
	y=78
	x=64-(max_seeds*6)/2
	for i=1,max_seeds do
		c=6
		if i==gdn.seed then c=7 end
		print("◆",x,y,c)
		x+=6
	end
end

function draw_seed()
	x=16
	y=86
	rect(x,y,x+9,y+9,9)
	s=gdn.seeds[gdn.seed]
	spr(s.s,x+1,y+1)
	x+=12
	y+=3
	print(s.q.." "..s.n,x,y,7)
	y+=8

	--draw seed attributes--
	p=get(plants,s.g)
	print("stats",x,y,6)
	x+=22
	if p then
		for i=1,p.r do
			print("✽",x,y,8)
			x+=8
		end
		for i=1,p.y do
			print("✽",x,y,10)
			x+=8
		end
		for i=1,p.u do
			print("✽",x,y,12)
			x+=8
		end
	end
end

function gdn_tick()
	for i=1,gdn.max_plots do
		if gdn.plots[i]==nil then
			--skip
		else
			gdn.timers[i]+=1
			if gdn.timers[i]>60 then
				if not is_grown(gdn.plots[i]) then
					gdn.plots[i]+=1
				end
				gdn.timers[i]=0
			end
		end
	end
end

function is_grown(i)
	for v in all(plants) do
		if i==v.s then return true end
	end
	return false
end
