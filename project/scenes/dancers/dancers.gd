extends Node2D

var dancer1: AnimatedSprite2D
var dancer2: AnimatedSprite2D
var mask1: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dancer1 = $"1"
	dancer2 = $"2"
	mask1 = $"3"
	dancer1.set_frame_and_progress(10, 0)
	mask1.set_frame_and_progress(10, 0)
	
func set_modulate_timestamp(seconds: float):
	$"3/AnimationPlayer".seek(seconds)
	$"4/AnimationPlayer".seek(seconds)
