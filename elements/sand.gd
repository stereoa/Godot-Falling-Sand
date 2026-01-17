class_name SandElement 
extends Element

static func get_color():
	return Color.SANDY_BROWN
		
static func move(x: int, y: int, grid: Array, width: int, height: int):
	if y + 1 < height:
		# Down
		if grid[x][y + 1] == 0: # 0 is EMPTY
			return Vector2i(x, y + 1)
		# Diagonals
		for dx in [-1, 1]:					
			var nx = x + dx
			if nx >= 0 and nx < width and grid[nx][y + 1] == 0:
				return Vector2i(nx, y + 1)
	# Stay put
	return null 
