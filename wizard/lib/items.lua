function items_init()
	--s:sprite,q:quantity,n:name,r:red,y:yellow,u:blue
	plants={
		name="plants",
		{s=19,q=0,n="fly agaric",r=2,y=1,u=0},
		{s=35,q=0,n="hanging blossom",r=1,y=0,u=2}
	}
	--s:sprite,q:quantity,n:name,p:plant_sprite,g:grown_sprite
	seeds={
		name="seeds",
		{s=20,q=2,n="fly agaric",p=16,g=19},
		{s=36,q=5,n="hanging blossom",p=32,g=35}
	}
end

function get_seeds()
	out={}
	for v in all(seeds) do
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
	if none then print("none",x,y,6)	end		
end
