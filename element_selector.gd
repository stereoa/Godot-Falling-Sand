extends HBoxContainer

signal element_selected(type_id: int)

func _ready():
	call_deferred("generate_buttons")

func generate_buttons():
	for child in get_children():
		child.queue_free()
	
	for type_id in ElementRegistry.registry.keys():
		var logic = ElementRegistry.get_element(type_id)
		
		var btn = Button.new()
		btn.text = logic.get_name()
		btn.custom_minimum_size = Vector2(100, 50) 
		
		btn.pressed.connect(_on_btn_pressed.bind(type_id))
		
		add_child(btn)

func _on_btn_pressed(type_id: int):
	element_selected.emit(type_id)
