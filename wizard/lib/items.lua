function items_init()
	gold=10

	--s:sprite,q:quantity,n:name,r:red,y:yellow,u:blue
	plants={
		name="plants",
		{s=67,q=2,n="fly agaric",r=1,y=0,u=0},
		{s=83,q=2,n="hanging blossom",r=0,y=1,u=1}
	}
	--s:sprite,q:quantity,n:name,p:plant_sprite,g:grown_sprite,b:buyable,v=value
	seeds={
		name="seeds",
		{s=68,q=1,n="fly agaric",p=64,g=67,b=1,v=1},
		{s=84,q=1,n="hanging blossom",p=80,g=83,b=1,v=2}
	}
	--s:sprite,q:quantity,n:name,v:value,r:red,y:yellow,u:blue
	pots={
		name="potions",
		{s=128,q=0,n="ash",v=0,r=0,y=0,u=0}, --shouldn't happen--
		{s=129,q=0,n="potion",v=2,r=1,y=0,u=0},
		{s=130,q=0,n="potion",v=2,r=0,y=1,u=1},
		{s=131,q=0,n="potion",v=5,r=1,y=1,u=1},
		{s=132,q=0,n="potion",v=4,r=2,y=0,u=0},
		{s=133,q=0,n="potion",v=4,r=0,y=2,u=2},
	}
end

function get_t(t)
	out={}
	for v in all(t) do
		if v.q>0 then add(out,v) end
	end
	return out
end

function get(t,s)
	for v in all(t) do
		if v.s==s then return v end
	end
end

function add_item(t,s,q)
	for v in all(t) do
		if v.s==s then v.q+=q end
	end
end

function draw_table(t,i)
	sx=8+i*64
	x=sx
	y=80
	print(t.name,sx,y,7)
	y+=8
	i=0
	none=true
	for v in all(t) do
		if v.q>0 then
			none=false
			spr(v.s,x,y)
			draw_tiny(v.q,x+6,y+4)
			if i>=4 then
				i=0
				x=sx
				y+=10
			else
				x+=10
				i+=1
			end
		end
	end
	if none then print("none",x,y,6) end
end

function draw_tiny(int,dx,dy)
	dtx=96 dty=24
	dtx+=3*((int-1)%5)
	dty+=4*flr((int-1)/5)
	sspr(dtx,dty,3,4,dx,dy)
end

function draw_item(t,i)
	y=78
	x=64-(count(t)*6)/2
	for i2=1,count(t) do
		c=6
		if i2==i then c=7 end
		print("◆",x,y,c)
		x+=6
	end
	x=16
	y=86
	rect(x,y,x+9,y+9,9)
	s=t[i]
	spr(s.s,x+1,y+1)
	x+=12
	y+=3
	print(s.q.." "..s.n,x,y,7)
	y+=8

	--draw item stats--
	if s.v then print("gold: ●"..s.v,x,y,10) y+=8 end
	p=get(plants,s.g)
	if p then s=p end
	print("stats",x,y,6)
	x+=22
	statbar(s,x,y)
end

function statbar(s,sx,sy)
	for i=1,s.r do
		print("✽",sx,sy,8)
		sx+=6
	end
	for i=1,s.y do
		print("✽",sx,sy,10)
		sx+=6
	end
	for i=1,s.u do
		print("✽",sx,sy,12)
		sx+=6
	end
end