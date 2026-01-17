extends Node2D

# Grid settings
var width: int
var height: int
var cell_size = 10 # Size of each grain on screen
var grid = []

# Cell types
enum { EMPTY, SAND, WATER }

# Add a variable to track what you are currently drawing
var current_type = SAND

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
			grid[x].append(EMPTY)

func _input(event):
	# Handles touch and drag for Android
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var grid_x = int(event.position.x / cell_size)
		var grid_y = int(event.position.y / cell_size)
		
		# Boundary check
		if grid_x >= 0 and grid_x < width and grid_y >= 0 and grid_y < height:
			grid[grid_x][grid_y] = SAND

func _process(_delta):
	update_sand()
	queue_redraw()

func update_sand():
	# Loop backwards from bottom to top
	for x in range(width):
		for y in range(height - 2, -1, -1):
			if grid[x][y] == SAND:
				# 1. Down
				if grid[x][y + 1] == EMPTY:
					grid[x][y + 1] = SAND
					grid[x][y] = EMPTY
				# 2. Diagonal Down-Left
				elif x > 0 and grid[x - 1][y + 1] == EMPTY:
					grid[x - 1][y + 1] = SAND
					grid[x][y] = EMPTY
				# 3. Diagonal Down-Right
				elif x < width - 1 and grid[x + 1][y + 1] == EMPTY:
					grid[x + 1][y + 1] = SAND
					grid[x][y] = EMPTY

func _draw():
	for x in range(width):
		for y in range(height):
			if grid[x][y] == SAND:
				var rect = Rect2(x * cell_size, y * cell_size, cell_size, cell_size)
				draw_rect(rect, Color.SANDY_BROWN)
