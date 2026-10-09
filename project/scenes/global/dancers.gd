extends Node2D

var dancer1: AnimatedSprite2D
var dancer2: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dancer1 = $"1"
	dancer2 = $"2"
	dancer1.set_frame_and_progress(10, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
