extends Node2D

class_name DefaultSceen

signal mousemotion
signal mouseover
signal mouseoff
signal zone_clicked
signal button_pressed
signal next_screen
signal disable_cursor_change
signal enable_cursor_change
signal save_state
signal sound_check
signal play_music
signal change_volume

#set by global scene
var time: Helpers.Stage
var state: GameState
var show_over: bool = false

var background_animation_player: AnimationPlayer
	
func save():
	save_state.emit(state)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mousemotion.emit(event.position)

func shows_over() -> void:
	show_over = true

func update_time(time: Helpers.Stage) -> void:
	pass

func _on_clicked() -> void:
	if show_over:
		button_pressed.emit()
	pass

func _on_zone_clicked(screen_name: String) -> void:
	zone_clicked.emit(screen_name)

func _on_zone_mouseover(direction: Helpers.Direction) -> void:
	mouseover.emit(direction)

func _on_zone_mouseoff() -> void:
	mouseoff.emit()
