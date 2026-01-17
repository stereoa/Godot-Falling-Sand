extends Node2D

var width: int
var height: int
var cell_size = 10 

var grid = []

enum Type { EMPTY, SAND, WATER }

var behaviors = {
	Type.SAND: SandElement,
	Type.WATER: WaterElement
}
var current_type = Type.WATER

func _ready():
	# Get the actual screen size in pixels
	var screen_size = get_viewport_rect().size
	
	# Calculate how many cells fit based on your cell_size
	width = int(screen_size.x / cell_size)
	height = int(screen_size.y / cell_size)
	
	# Initialize the grid with the new dimensions
	for x in range(width):
		grid.append([])
		for y in range(height):
			grid[x].append(Type.EMPTY)

func _input(event):
	# Handles touch and drag for Android
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var grid_x = int(event.position.x / cell_size)
		var grid_y = int(event.position.y / cell_size)
		
		# Boundary check
		if grid_x >= 0 and grid_x < width and grid_y >= 0 and grid_y < height:
			grid[grid_x][grid_y] = current_type

func _process(_delta):
	update_physics()
	queue_redraw()

func _draw():
	for x in range(width):
		for y in range(height):
			var type = grid[x][y]
			if type != Type.EMPTY:
				draw_rect(Rect2(x*cell_size, y*cell_size, cell_size, cell_size), behaviors[type].get_color())


func update_physics():
	# Loop bottom-to-top
	for x in range(width):
		for y in range(height - 1, -1, -1):
			var type = grid[x][y]
			if type == Type.EMPTY: continue
			
			var logic = behaviors[type]
			var next_pos = logic.move(x, y, grid, width, height)
			
			if next_pos:
				grid[next_pos.x][next_pos.y] = type
				grid[x][y] = Type.EMPTY
