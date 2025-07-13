function p_init()
	p={
		x=64,y=40,
		f=false,
		state=1, --Idle=0,Walking=1
		tick=0,
		frame=0
	}
end

function p_tick()
	if p.state==1 then
		p.tick+=1
		if p.tick>=5 then
			p.tick=0
			p.frame+=1
			if p.frame>3 then p.frame=0 end
		end
	end
end

function p_update()
	p_update2(6,114)
end
function p_update2(minx,maxx)
	if btn(➡️) then
		p.f=false
		if p.x<maxx then p.x+=1 end
		p.state=1
	elseif btn(⬅️) then
		p.f=true
		if p.x>minx then p.x-=1 end
		p.state=1
	else
		p.state=0
		p.frame=0
		p.tick=0
	end
end

function p_draw()
	spr(1+p.frame,p.x,p.y,1,1,p.f)
end