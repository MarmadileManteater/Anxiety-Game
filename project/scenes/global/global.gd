extends Node2D

@export var start_screen: String = "the_pit"

var time: Helpers.Stage = Helpers.Stage.Middle
var current_screen: DefaultSceen

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	load_screen(start_screen)

func _on_mouse_motion(position: Vector2) -> void:
	if not $Cursor.visible:
		$Cursor.show()
	$Cursor.position = (position / 1.5) + Vector2(30, 30)

func _on_mouse_direction_mouseover(direction: Helpers.Direction) -> void:
	$Cursor.flip_h = direction == Helpers.Direction.Right
	$Cursor.play(Helpers.direction_to_string(direction))

func _on_mouse_direction_mouseoff() -> void:
	$Cursor.flip_h = false
	$Cursor.play("default")
	
func load_screen(screen_name: String):
	if current_screen != null:
		remove_child(current_screen)
		current_screen.queue_free()
	var scene: PackedScene = load("res://scenes/" + screen_name + "/" + screen_name + ".tscn")
	var instance: DefaultSceen = scene.instantiate()
	instance.time = time
	instance.background_animation_player = $Background/AnimationPlayer
	instance.mousemotion.connect(_on_mouse_motion)
	instance.mouseover.connect(_on_mouse_direction_mouseover)
	instance.mouseoff.connect(_on_mouse_direction_mouseoff)
	instance.zone_clicked.connect(
		func (screen_name):
			load_screen(screen_name)
	)
	add_child(instance)
	current_screen = instance

func _on_button_pressed() -> void:
	current_screen._on_clicked()

func _on_button_exited() -> void:
	$Cursor.hide()
