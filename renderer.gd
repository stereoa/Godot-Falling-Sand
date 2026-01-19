extends Node2D

var grid_data: Array = []
var behaviors: Dictionary = {}
var cell_size: int = 10

func _process(_delta):
	queue_redraw()

func _draw():
	if grid_data.is_empty():
		return

	for x in range(grid_data.size()):
		for y in range(grid_data[x].size()):
			var type_id = grid_data[x][y]

			if type_id != 0:
				var color = behaviors[type_id].get_color()
				
				var rect = Rect2(
					x * cell_size, 
					y * cell_size, 
					cell_size, 
					cell_size
				)

				draw_rect(rect, color)
