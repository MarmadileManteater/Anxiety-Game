extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Helpers.set_timeout(
		func ():
			$Dialog.display()
	, 1, self)
	$Dialog.line_started.connect(
		func (index: int):
			if index == 5:
				$Dialog.set_title("joyfriend")
			if index == 6:
				$Dialog.clear_title()
	)
	$Dialog.done.connect(
		func ():
			Helpers.set_timeout(
				func ():
					$Curtain/AnimationPlayer.play("fade")
			, 1, self)
	, ConnectFlags.CONNECT_ONE_SHOT)

func _on_clicked() -> void:
	$Dialog.progress()
