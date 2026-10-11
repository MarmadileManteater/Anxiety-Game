extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if state.game_started:
		$Curtain.hide()
	else:
		$Car.play()
		disable_cursor_change.emit()
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
				$Car.stop()
				$OutOfCar.play()
				$OutOfCar.finished.connect(
					func():
						$Curtain/AnimationPlayer.play("fade")
						enable_cursor_change.emit()
						state.game_started = true
						save()
				, ConnectFlags.CONNECT_ONE_SHOT)

		, ConnectFlags.CONNECT_ONE_SHOT)

func _on_clicked() -> void:
	$Dialog.progress()
