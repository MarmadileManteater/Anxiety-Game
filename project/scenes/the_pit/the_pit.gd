extends DefaultSceen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if time != Helpers.Stage.Early:
		background_animation_player.play("modulate")
		$Dancers.set_modulate_timestamp(background_animation_player.current_animation_position)
