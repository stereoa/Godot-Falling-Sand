extends Node

# Stores { ID (int) : LogicInstance (Element) }
var registry: Dictionary = {}
# Stores { Name (String) : ID (int) } for easy lookup
var name_to_id: Dictionary = {}

func _ready():
	# Automatically scan the folder when the game starts
	discover_elements("res://elements/")

func discover_elements(path: String):
	var dir = DirAccess.open(path)
	if not dir:
		print("Error: Could not open path ", path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	var current_id = 1

	while file_name != "":
		# Only load .gd scripts (and skip the base Element.gd if it's in there)
		if file_name.ends_with(".gd") and file_name != "element.gd":
			var script = load(path + file_name)
			var instance = script.new()
			
			# Add to our dictionaries
			registry[current_id] = instance
			name_to_id[instance.get_name()] = current_id
			
			print("Registered: ", instance.get_name(), " as ID: ", current_id)
			current_id += 1
			
		file_name = dir.get_next()

# Helper to get the logic from a grid number
func get_element(id: int) -> Element:
	return registry.get(id, null)

# Helper to get an ID by string (e.g., for setting the brush)
func get_id(element_name: String) -> int:
	return name_to_id.get(element_name, 0)
