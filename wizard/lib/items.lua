function items_init()
	--s:sprite,q:quantity,n:name,r:red,y:yellow,u:blue
	plants={
		name="plants",
		{s=67,q=1,n="fly agaric",r=1,y=0,u=0},
		{s=83,q=1,n="hanging blossom",r=0,y=1,u=1}
	}
	--s:sprite,q:quantity,n:name,p:plant_sprite,g:grown_sprite
	seeds={
		name="seeds",
		{s=68,q=2,n="fly agaric",p=64,g=67},
		{s=84,q=5,n="hanging blossom",p=80,g=83}
	}
	--s:sprite,q:quantity,n:name,r:red,y:yellow,u:blue
	pots={
		name="potions",
		{s=128,q=0,n="ash",r=0,y=0,u=0}, --shouldn't happen--
		{s=129,q=0,n="potion",r=1,y=0,u=0},
		{s=130,q=0,n="potion",r=0,y=1,u=1},
		{s=131,q=0,n="potion",r=1,y=1,u=1},
		{s=132,q=0,n="potion",r=2,y=0,u=0},
		{s=133,q=0,n="potion",r=0,y=2,u=2},
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
	y+=10
	i=0
	none=true
	for v in all(t) do
		if v.q>0 then
			none=false
			spr(v.s,x,y)
			print(v.q,x+10,y+2)
			if i>=3 then
				i=0
				x=sx
			else
				x+=18
				i+=1
			end
		end
	end
	if none then print("none",x,y,6) end
end

function draw_dots(max,index)
	y=78
	x=64-(max*6)/2
	for i=1,max do
		c=6
		if i==index then c=7 end
		print("◆",x,y,c)
		x+=6
	end
end

function draw_item(t,i)
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