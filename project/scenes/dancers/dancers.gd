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
	$"5".set_frame_and_progress(5, 0)
	$"6".set_frame_and_progress(5, 0)
	
func reveal_third():
	$"6".show()
	$"5".show()
	
func set_modulate_timestamp(seconds: float):
	$"3/AnimationPlayer".seek(seconds)
	$"4/AnimationPlayer".seek(seconds)
	$"6/AnimationPlayer".seek(seconds)
	
func _process(_delta: float) -> void:
	if $"3".frame == 9:
		$"3".z_index = 1
		$"1".z_index = 1
	if $"3".frame == 14:
		$"3".z_index = -1
		$"1".z_index = -1
	if $"5".frame == 9:
		$"5".z_index = 1
		$"6".z_index = 1
	if $"5".frame == 14:
		$"5".z_index = -1
		$"6".z_index = -1
	if $"2".frame == 9:
		$"2".z_index = 1
		$"4".z_index = 1
	if $"2".frame == 14:
		$"2".z_index = -1
		$"4".z_index = -1
