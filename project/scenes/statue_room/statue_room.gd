extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_volume.emit(-20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
