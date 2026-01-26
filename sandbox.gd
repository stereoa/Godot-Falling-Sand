extends Node2D

@onready var renderer = $Renderer

var width: int
var height: int
var cell_size = 10

var sim: Simulation

var types = {}
var current_type = 0

var brush_size = 1

func _ready():
	# Get the actual screen size in pixels
	var screen_size = get_viewport_rect().size
	
	# Calculate how many cells fit based on your cell_size
	width = int(screen_size.x / cell_size)
	height = int(screen_size.y / cell_size)

	%ElementButtons.element_selected.connect(_on_element_changed)
	%BrushSlider.value_changed.connect(_on_brush_size_changed)
	
	for id in ElementRegistry.registry.keys():
		var element = ElementRegistry.get_element(id)
		types[id] = element
		
	sim = Simulation.new()
	sim.setup(width, height)
	
	renderer.grid_data = sim.grid
	renderer.behaviors = types 
	renderer.cell_size = cell_size

func _input(event):
	# Handles touch and drag for Android
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var grid_x = int(event.position.x / cell_size)
		var grid_y = int(event.position.y / cell_size)
		
		# Boundary check
		if grid_x >= 0 and grid_x < width and grid_y >= 0 and grid_y < height:
			var x_start = max(0, grid_x - brush_size)
			var x_end = min(width - 1, grid_x + brush_size)
			
			var y_start = max(0, grid_y - brush_size)
			var y_end = min(height - 1, grid_y + brush_size)
			
			for x in range(x_start, x_end + 1):
				for y in range(y_start, y_end + 1):
					var dist = Vector2(x, y).distance_to(Vector2(grid_x, grid_y))
					
					if dist < brush_size:
						sim.grid[x][y] = current_type

func _process(_delta):
	sim.step(types)
	
func _on_element_changed(id: int):
	current_type = id

func _on_brush_size_changed(value: float):
	brush_size = int(value)
