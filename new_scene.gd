extends Node2D

class gameWorld:
	var cw = Color (1,1,1)
	var cr = Color (1,0,0)
	var cg = Color (0,1,0)
	var cb = Color (0,0,1)
	var cy = Color(255, 223, 0)
		
	var colors = [cw,cr,cg,cb,cy]
					
	var variant = {cw:[0,2,3],
					cr:[1,2,4],
					cg:[0,1,2,3,4],
					cb:[0,2,3],
					cy:[4,2,3]
					}
						
						
	var map = []
	var n = 100
	
	func _init():
		var color=cg
		randomize()
		for i in range (0,n):
			var t = []
			for j in range (0,n):
				t.append(-1)
			map.append(t)
				
		for i in range (0,n):
			for j in range (0,n):
				if i==0 and j==0:
					color = randi() % colors.size() # 0-4
				else:
	
					var dir = [[1,0],[-1,0], [0,-1],[0,1],
					          [1,1],[-1,-1],[-1,1],[1,-1]]
					var cur_variant = variant[colors[color]] #1->cr->[1,2] #color = old color
	
					var ok=0
					while ok<8:
						color = cur_variant[randi() % cur_variant.size()]
						for d_xy in dir:
							var i2 = d_xy[0]+i
							var j2 = d_xy[1]+j
							if not(i2 in [-1,0,n,n+1]) and not(j2 in [-1,0,n,n+1]):
								if map[i2][j2] in variant[colors[color]]+[-1]:
									ok+=1
								else:
									ok=0
									break
							else:
								ok+=1
					
				map[i][j] = color

		#join
		for i in range (0, n):
			for j in range (0, n):
				var neigbor_points = [[[1,0], [-1,0]], [[0,-1], [0,1]]]
				for points in neigbor_points:
					var vh = []
					for point in points:
						var i2 = i + point[0] # 0 < - x
						var j2 = j + point[1] # 1 < - y
						if not(i2 in [-1,n]) and not(j2 in [-1,n]):
							vh.append(map[i2][j2])
						else:
							vh.append(-1)
					if vh[0]==vh[1]:
						map[i][j]=vh[0]
					
func _draw():
	var SIZE_RECT = 10
	var w = gameWorld.new()
	for i in range (0, w.n):
		for j in range (0, w.n):	
			draw_rect(Rect2(Vector2(i*SIZE_RECT,j*SIZE_RECT),Vector2(SIZE_RECT,SIZE_RECT)),w.colors[w.map[i][j]])
	

func _on_Button_pressed():
	update()
