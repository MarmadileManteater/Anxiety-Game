extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		$Cursor.position = event.position
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_click() -> void:
	$TextBox.progress()
