extends DefaultSceen


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_volume.emit(-10)
	if not state.bracelet_obtained:
		disable_cursor_change.emit()
		Helpers.set_timeout(
			func ():
				sound_check.emit()
				$Dialog.display()
		, 1, self)
		$Dialog.line_started.connect(
			func (index: int):
				if index == 0:
					$Dialog.set_title("some human")
				if index == 1:
					$Dialog.clear_title()
				if index == 3:
					$Dialog.set_title("some human")
				if index == 4:
					$Dialog.clear_title()
				if index == 5:
					$Dialog.set_title("some human")
				if index == 7:
					$Dialog.clear_title()
		)
		$Dialog.done.connect(
			func ():
				Helpers.set_timeout(
					func ():
						enable_cursor_change.emit()
						state.bracelet_obtained = true
						save()
				, 0.1, self)
		, ConnectFlags.CONNECT_ONE_SHOT)

func _on_clicked() -> void:
	$Dialog.progress()
