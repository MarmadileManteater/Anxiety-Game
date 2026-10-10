extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Helpers.set_timeout(
		func ():
			$TextBox.display()
	, 1, self)
	$TextBox.line_started.connect(
		func (index: int):
			if index == 5:
				$TextBox.set_title("joyfriend")
			if index == 6:
				$TextBox.clear_title()
	)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		if not $Cursor.visible:
			$Cursor.show()
		$Cursor.position = (event.position / 1.5) + Vector2(30, 30)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_click() -> void:
	$TextBox.progress()


func _on_mouse_exited() -> void:
	$Cursor.hide()

func _on_mouse_up() -> void:
	$Cursor.play("up")
	
func _on_mouse_neutral() -> void:
	$Cursor.play("default")


func _on_mouse_direction_mouseover(direction: Helpers.Direction) -> void:
	$Cursor.play(Helpers.direction_to_string(direction))


func _on_mouse_direction_mouseoff() -> void:
	$Cursor.play("default")
