class_name WaterElement
extends Element

static func get_name() -> String: 
	return "Water"
				
static func get_color() -> Color:
	return Color.SKY_BLUE
						
static func move(x: int, y: int, grid: Array, width: int, height: int):
	# Try down and diagonals first (same as sand)
	if y + 1 < height:
		if grid[x][y + 1] == 0: return Vector2i(x, y + 1)
		for dx in [-1, 1]:
			var nx = x + dx
			if nx >= 0 and nx < width and grid[nx][y + 1] == 0:
				return Vector2i(nx, y + 1)
	
	# Liquid logic: try moving strictly left or right
	var sides = [-1, 1]
	sides.shuffle()
	for dx in sides:
		var nx = x + dx
		if nx >= 0 and nx < width and grid[nx][y] == 0:
			return Vector2i(nx, y)
	return null
