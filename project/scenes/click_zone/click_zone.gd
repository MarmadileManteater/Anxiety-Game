extends Button

class_name ClickZone

signal mouseover
signal mouseoff
signal clicked

@export var direction: Helpers.Direction = Helpers.Direction.Up

func pressed() -> void:
	clicked.emit()

func emit_over() -> void:
	mouseover.emit(direction)
	
func emit_off() -> void:
	mouseoff.emit()
