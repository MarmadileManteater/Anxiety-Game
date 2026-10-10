extends DefaultSceen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if time != Helpers.Stage.Early:
		background_animation_player.play("modulate")
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

func _on_clicked() -> void:
	$TextBox.progress()
