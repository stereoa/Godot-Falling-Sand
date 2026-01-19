class_name Simulation
extends Resource

@export var grid: Array = []
@export var width: int
@export var height: int

func setup(w: int, h: int):
	width = w
	height = h
	grid = []
	for x in range(width):
		grid.append([])
		for y in range(height):
			grid[x].append(0)

func step(behaviors: Dictionary):
	# Loop bottom-to-top
	for x in range(width):
		for y in range(height - 1, -1, -1):
			var type = grid[x][y]
			if type == 0: continue

			var logic = behaviors[type]
			var next_pos = logic.move(x, y, grid, width, height)
			
			if next_pos:
				grid[next_pos.x][next_pos.y] = type
				grid[x][y] = 0
