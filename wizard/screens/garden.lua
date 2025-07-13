function gdn_init()
	gdn={
		state=0,
		selected=1,
		max_plots=3,
		seeds={},
		seed=1,
		plots={nil,nil,nil,nil,nil},
		pos={0,0,0,0,0},
		timers={0,0,0,0,0}
	}
end

function gdn_enter()
	p.x=20
	p.f=false
	door_init()
	door_add(12)
	for i=1,gdn.max_plots do
		gdn.pos[i]=(108/(gdn.max_plots+1))*i+20
	end
end

function gdn_update()
	if gdn.state==0 then
		p_update()
		if btnp(❎) then
			if door_enter() then return end
			for i=1,gdn.max_plots do
				plot=gdn.pos[i]
				if p.x>plot-8 and p.x<plot+8 then
					gdn.selected=i
					if gdn.plots[gdn.selected] then
						harvest()
					else
						plant_mode()
					end
				end
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
		for pl in all(plants) do
			if pl.s==plt then msg="harvested "..pl.n end
		end
	end
end

function plant_mode()
	gdn.seeds=get_t(seeds)
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
		msg="planted "..seed.n
	end
end

function gdn_draw()
	draw_floor(6,120)
	map(32,0)
	top_bar()
	door_draw()
	p_draw()
	sy=48
	for i=1,gdn.max_plots do
		plt=gdn.plots[i]
		sx=gdn.pos[i]
		circfill(sx+3,sy+8,8,1)
		line(sx-1,sy,sx+7,sy,1)
		spr(6,sx,sy)
		if plt~=nil then
			spr(plt,sx,sy-4)
		end
		if p.x>sx-8 and p.x<sx+8 and gdn.state==0 and (plt==nil or is_grown(plt)) then
			print("❎",sx,p.y+18,6)
		end
	end
	if gdn.state==0 then
		draw_table(seeds,0)
		draw_table(plants,1)
	else
		draw_item(gdn.seeds,gdn.seed)
	end
end

function gdn_tick()
	for i=1,gdn.max_plots do
		if gdn.plots[i]==nil then
			--skip
		else
			gdn.timers[i]+=1
			if gdn.timers[i]>30 then
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