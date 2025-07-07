function items_init()
	plants={
		name="plants",
		{s=19,q=0,
			n="fly agaric",
			r=2,y=1,u=0},
		{s=35,q=0,
			n="hanging blossom",
			r=1,y=0,u=2}
	}
	seeds={
		name="seeds",
		{s=20,q=2,p=16,g=19,
			n="fly agaric"},
		{s=36,q=5,p=32,g=35,
			n="hanging blossom"}
	}
end

function get_seeds()
	out={}
	for v in all(seeds) do
		if v.q>0 then add(out,v.s) end
	end
	return out
end

function p_by_s(s)
	return p_by_s(s,false)
end
function p_by_s(s,subtract)
	for v in all(seeds) do
		if v.s==s then
			if subtract then v.q-=1 end
			return v.p
		end
	end
end

function s_by_spr(s)
	for v in all(seeds) do
		if v.s==s then return v end
	end
end
function p_by_spr(s)
	for v in all(plants) do
		if v.s==s then return v end
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
