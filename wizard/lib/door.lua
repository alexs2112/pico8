function door_init()
	doors={}
	door_s=22
end

function door_add(x)
	add(doors,x)
end

function door_draw()
	for d in all(doors) do
		spr(door_s,d,p.y)
		if p.x>d-8 and p.x<d+8 then
			print("❎",d,p.y-8,6)
		end
	end
end

function door_enter()
	for d in all(doors) do
		if p.x>d-8 and p.x<d+8 then
			screen="menu"
			return true
		end
	end
	return false
end