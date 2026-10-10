extends Button

class_name ClickZone

signal mouseover
signal mouseoff
signal clicked

@export var direction: Helpers.Direction = Helpers.Direction.Up
@export var screen_name: String

func pressed() -> void:
	clicked.emit(screen_name)

func emit_over() -> void:
	mouseover.emit(direction)
	
func emit_off() -> void:
	mouseoff.emit()
